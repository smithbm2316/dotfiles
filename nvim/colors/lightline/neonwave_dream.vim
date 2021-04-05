

  
  if &background == 'dark'
    
  let s:shade0 = "#18132f"
  let s:shade1 = "#2f2c4d"
  let s:shade2 = "#47466a"
  let s:shade3 = "#5e5f88"
  let s:shade4 = "#7579a6"
  let s:shade5 = "#8c92c4"
  let s:shade6 = "#a4ace1"
  let s:shade7 = "#bbc5ff"
  let s:accent0 = "#495396"
  let s:accent1 = "#f95e94"
  let s:accent2 = "#85eea7"
  let s:accent3 = "#d288f5"
  let s:accent4 = "#e33df2"
  let s:accent5 = "#fee153"
  let s:accent6 = "#ef2a8c"
  let s:accent7 = "#67bcf9"
  
  endif
  

  

  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
  let s:p.normal.left = [ [ s:shade1, s:accent2 ], [ s:shade7, s:shade2 ] ]
  let s:p.normal.right = [ [ s:shade1, s:shade4 ], [ s:shade5, s:shade2 ] ]
  let s:p.inactive.right = [ [ s:shade1, s:shade3 ], [ s:shade3, s:shade1 ] ]
  let s:p.inactive.left =  [ [ s:shade4, s:shade1 ], [ s:shade3, s:shade0 ] ]
  let s:p.insert.left = [ [ s:shade1, s:accent7 ], [ s:shade7, s:shade2 ] ]
  let s:p.replace.left = [ [ s:shade1, s:accent4 ], [ s:shade7, s:shade2 ] ]
  let s:p.visual.left = [ [ s:shade1, s:accent3 ], [ s:shade7, s:shade2 ] ]
  let s:p.normal.middle = [ [ s:shade5, s:shade1 ] ]
  let s:p.inactive.middle = [ [ s:shade4, s:accent0 ] ]
  let s:p.tabline.left = [ [ s:shade6, s:shade2 ] ]
  let s:p.tabline.tabsel = [ [ s:shade6, s:shade0 ] ]
  let s:p.tabline.middle = [ [ s:shade2, s:shade4 ] ]
  let s:p.tabline.right = copy(s:p.normal.right)
  let s:p.normal.error = [ [ s:accent1, s:shade0 ] ]
  let s:p.normal.warning = [ [ s:accent5, s:shade0 ] ]

  let g:lightline#colorscheme#neonwave_dream#palette = lightline#colorscheme#fill(s:p)

  
