local has_treesitter, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
local has_cmp, cmp = pcall(require, 'cmp')
local has_plenary, _ = pcall(require, 'plenary')

local M = {}

local deps = {
  ['nvim-treesitter'] = has_treesitter,
  ['nvim-cmp'] = has_cmp,
  ['plenary.nvim'] = has_plenary,
}

local curl = require 'plenary.curl'
local Path = require 'plenary.path'

-- verify that we have all dependencies available, otherwise error out
for dep, has_dep in pairs(deps) do
  if not has_dep then
    vim.notify(
      string.format(
        'ERROR: vscode-custom-data.lua requires the %s plugin to be installed. Please load the plugin and try again.',
        dep
      ),
      vim.log.levels.ERROR
    )
    error(
      string.format(
        'ERROR: vscode-custom-data.lua requires the %s plugin to be installed. Please load the plugin and try again.',
        dep
      ),
      vim.log.levels.ERROR
    )
  end
end

---@class CmpSource: cmp.Source
local source = {}

---@alias CustomDataConfigCompletionType 'single_quotes' | 'double_quotes' | 'only-attribute'

---@class CustomDataConfig
---@field filetypes string[]? a list of nvim filetypes for this source to be activated on
---@field local_data_files string[]? a list of paths to JSON custom data files to load and parse
---@field data_files table<string, string>? a dictionary of URLs to JSON custom data files to load, parse, and cache
---@field completion_type CustomDataConfigCompletionType? Whether to complete the full attribute with an equal sign and single quotes, double quotes, or only the attribute (without the equal sign)
local default_config = {
  filetypes = { 'html' },
  local_data_files = {},
  data_files = {},
  completion_type = 'single_quotes',
}
---@type CustomDataConfig
local config
---@type lsp.CompletionItem[]
local completion_items = {}

---@class CustomDataFile
---@field version string The custom data version
---@field tags string[]? Custom HTML tags
---@field globalAttributes CustomDataGlobalAttribute[]? Custom HTML global attributes
---@field valueSet nil A set of attribute value. When an attribute refers to an attribute set, its value completion will use value from that set
---
---@class CustomDataGlobalAttribute Custom HTML global attributes
---@field name string Name of attribute
---@field description (lsp.MarkupContent | string) Description of attribute shown in completion and hover
---@field references CustomDataReferences[]? A list of references for the attribute shown in completion and hover
---@field valueSet string? Name of the matching attribute value set
---@field values nil? A list of possible values for the attribute
---
---@class CustomDataReferences
---@field name string The name of the reference.
---@field url string? The URL of the reference. Pattern: `https?://`

---Returns a custom data file parsed as JSON into a lua table
---@param file_path string
---@return CustomDataFile
local function parse_file_to_json(file_path)
  local file = assert(io.open(file_path, 'r'))
  local data = file:read '*a' --[[@as string]]
  local json_data = vim.json.decode(data) --[[@as CustomDataFile]]
  file:close()
  return json_data
end

---Writes the data file found at the provided url to a JSON file found in $XDG_DATA_HOME/nvim/vscode-custom-data
---@param file_name string the name for the new file
---@param url string the url
---@return CustomDataFile
local function get_file_from_url(file_name, url)
  local folder_path = vim.env.XDG_DATA_HOME .. '/nvim/vscode-custom-data'
  local file_path = folder_path .. '/' .. file_name .. '.json'
  local cached_file = io.open(file_path, 'r')
  if cached_file then
    cached_file:close()
    return parse_file_to_json(file_path)
  end

  vim.notify('Downloading and parsing ' .. url .. '...', vim.log.levels.INFO)
  local response = curl.get(url)
  if not response.body then
    vim.notify("Couldn't download JSON file from %s" .. url, vim.log.levels.ERROR)
    error("Couldn't download JSON file from %s" .. url, vim.log.levels.ERROR)
  end

  vim.fn.mkdir(folder_path, 'p')
  vim.fn.writefile({}, file_path)
  local file_to_cache = io.open(file_path, 'w')
  if not file_to_cache then
    vim.notify("Couldn't parse JSON from cached file: " .. file_path, vim.log.levels.ERROR)
    error("Couldn't parse JSON from cached file: " .. file_path, vim.log.levels.ERROR)
  end
  file_to_cache:write(response.body)
  file_to_cache:close()
  return vim.json.decode(response.body) --[[@as CustomDataFile]]
end

---Return whether this source is available in the current context or not (optional).
---@return boolean
function source:is_available()
  local target = ts_utils.get_node_at_cursor()
  if target == nil then
    return false
  end

  local valid_target_types = {
    'open_tag',
    'start_tag',
    'attribute',
  }
  local current_filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  return vim.tbl_contains(config.filetypes, current_filetype) and vim.tbl_contains(valid_target_types, target:type())
end

---Return the debug name of this source (optional).
---@return string
function source:get_debug_name()
  return 'debug vscode-custom-data'
end

---Return trigger characters for triggering completion (optional).
function source:get_trigger_characters()
  return { '.' }
end

---Invoke completion (required).
---@param _ cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(_, callback)
  callback(completion_items)
end

---Resolve completion item (optional). This is called right before the completion is about to be displayed.
---Useful for setting the text shown in the documentation window (`completion_item.documentation`).
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:resolve(completion_item, callback)
  callback(completion_item)
end

---Executed after the item was selected.
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:execute(completion_item, callback)
  callback(completion_item)
end

---Register your source to nvim-cmp.
cmp.register_source('vscode_custom_data', source)

M.setup = function(user_config)
  config = vim.tbl_deep_extend('force', default_config, user_config)

  for file_name, url in pairs(config.data_files) do
    local json_data = get_file_from_url(file_name, url)
    local global_attributes = json_data and json_data.globalAttributes or {}
    for _, globalAttr in ipairs(global_attributes) do
      ---@type lsp.CompletionItem
      local cmp_item = {
        label = globalAttr.name,
        filterText = globalAttr.name,
        insertText = globalAttr.name,
        insertTextMode = cmp.lsp.InsertTextMode.AsIs,
        insertTextFormat = cmp.lsp.InsertTextFormat.Snippet,
        kind = cmp.lsp.CompletionItemKind.Value,
      }

      -- format the completion snippet appropriately depending on the user's config
      if config.completion_type == 'single_quotes' then
        cmp_item.insertText = string.format([[%s='$0']], globalAttr.name)
      elseif config.completion_type == 'double_quotes' then
        cmp_item.insertText = string.format([[%s="$0"]], globalAttr.name)
      end

      -- make sure to include our documentation string
      if globalAttr.description then
        cmp_item.documentation = {
          kind = 'markdown',
          ---@diagnostic disable-next-line: assign-type-mismatch
          value = type(globalAttr.description) == 'string' and globalAttr.description or globalAttr.description.value,
        }

        -- if we have references to show, then loop through them and append them to the end of our
        -- documentation string
        if type(globalAttr.references) == 'table' and #globalAttr.references > 0 then
          cmp_item.documentation.value = cmp_item.documentation.value .. '\n'
          for _, reference in ipairs(globalAttr.references) do
            cmp_item.documentation.value =
              string.format('%s\n[%s](%s)', cmp_item.documentation.value, reference.name, reference.url)
          end
        end
      end

      table.insert(completion_items, cmp_item)
    end
  end
end

return M

-- NOTE: References
-- https://code.visualstudio.com/blogs/2020/02/24/custom-data-format
-- https://github.com/hrsh7th/nvim-cmp/discussions/1531
-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/
-- https://github.com/LuaLS/lua-language-server/wiki/Annotations
-- https://json-schema.app/view/%23?url=https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fvscode-html-languageservice%2Fmain%2Fdocs%2FcustomData.schema.json
-- https://github.com/buschco/nvim-cmp-ts-tag-close/blob/main/lua/nvim-cmp-ts-tag-close/init.lua
