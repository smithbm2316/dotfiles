return {
  -- lsp renamer function that provides extra information
  rename = function()
    local curr_name = vim.fn.expand '<cword>'
    vim.ui.input({
      prompt = 'LSP Rename: ',
      default = curr_name,
    }, function(new_name)
      if new_name then
        ---@diagnostic disable-next-line: missing-parameter
        local lsp_params = vim.lsp.util.make_position_params(0, 'utf-8')

        if not new_name or #new_name == 0 or curr_name == new_name then
          return
        end

        -- request lsp rename
        lsp_params.newName = new_name
        vim.lsp.buf_request(
          0,
          'textDocument/rename',
          lsp_params,
          function(_, res, ctx, _)
            if not res then
              return
            end

            -- apply renames
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            if not client then
              vim.notify(
                string.format(
                  'Could not find a matching LSP client "%d" for renaming.',
                  ctx.client_id
                )
              )
              return
            end
            vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

            -- print renames
            local changed_files_count = 0
            local changed_instances_count = 0

            if res.documentChanges then
              for _, changed_file in pairs(res.documentChanges) do
                changed_files_count = changed_files_count + 1
                changed_instances_count = changed_instances_count
                  + #changed_file.edits
              end
            elseif res.changes then
              for _, changed_file in pairs(res.changes) do
                changed_instances_count = changed_instances_count
                  + #changed_file
                changed_files_count = changed_files_count + 1
              end
            end

            -- compose the right print message
            vim.notify(
              string.format(
                'Renamed %s instance%s in %s file%s. %s',
                changed_instances_count,
                changed_instances_count == 1 and '' or 's',
                changed_files_count,
                changed_files_count == 1 and '' or 's',
                changed_files_count > 1 and "To save them run ':cfdo w'" or ''
              ),
              vim.log.levels.INFO
            )
          end
        )
      end
    end)
  end,
}
