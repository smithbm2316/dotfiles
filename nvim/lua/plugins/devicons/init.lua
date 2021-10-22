require('nvim-web-devicons').setup {
  override = {
    ["yarn.lock"] = {
      icon = "",
      color = "#2188b6",
      name = "YarnLockfile",
    },
    ["package-lock.json"] = {
      icon = "",
      color = "#cb0000",
      name = "NPMLockfile",
    },
    ["package.json"] = {
      icon = "",
      color = "#84ba64",
      name = "PackageJSON",
    },
    ["njk"] = {
      icon = "",
      color = "#5cb85c",
      name = "Nunjucks",
    },
    ["lir_folder_icon"] = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode"
    },
    ["test.js"] = {
      icon = "ﭧ",
      color = "#cbcb41",
      name = "JsTest"
    },
    ["spec.js"] = {
      icon = "",
      color = "#cbcb41",
      name = "JsSpec"
    },
    ["test.lua"] = {
      icon = "ﭧ",
      color = "#51a0cf",
      name = "LuaTest"
    },
    ["spec.lua"] = {
      icon = "",
      color = "#51a0cf",
      name = "LuaSpec"
    },
    -- eventually add icons for folders!
    --[[ ["*/"] = {
      icon = "",
      color = "#0fbfcf",
      name = "Folder",
    }; ]]
  },
  default = false,
}