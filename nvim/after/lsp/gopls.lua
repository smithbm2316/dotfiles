return {
  filetypes = { 'go' },
  settings = {
    gopls = {
      analyses = {
        httpresponse = true,
        loopclosure = true,
        nilfunc = true,
        nilness = true,
        printf = true,
        shadow = false,
        unusedparams = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      completeFunctionCalls = true,
      experimentalPostfixCompletions = true,
      matcher = 'Fuzzy',
      staticcheck = false,
      usePlaceholders = false,
    },
  },
}
