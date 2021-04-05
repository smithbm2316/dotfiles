  if &background == 'dark'
    
  let s:shade0 = "#27212e"
  let s:shade1 = "#46414c"
  let s:shade2 = "#65606a"
  let s:shade3 = "#848088"
  let s:shade4 = "#a2a0a5"
  let s:shade5 = "#c1c0c3"
  let s:shade6 = "#e0dfe1"
  let s:shade7 = "#ffffff"
  let s:accent0 = "#b381c5"
  let s:accent1 = "#ffe261"
  let s:accent2 = "#eb64b9"
  let s:accent3 = "#b4dce7"
  let s:accent4 = "#716385"
  let s:accent5 = "#74dfc4"
  let s:accent6 = "#40b4c4"
  let s:accent7 = "#b381c5"
  
  endif
  

  

  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
  let s:p.normal.left = [ [ s:shade0, s:accent5 ], [ s:shade0, s:accent2 ] ]
  let s:p.normal.right = [ [ s:shade0, s:accent2 ], [ s:shade0, s:accent2 ] ]
  let s:p.inactive.right = [ [ s:shade0, s:accent2 ], [ s:shade0, s:accent2 ] ]
  let s:p.inactive.left =  [ [ s:shade0, s:accent2 ], [ s:shade0, s:accent2 ] ]
  let s:p.insert.left = [ [ s:shade0, s:accent6 ], [ s:shade0, s:accent2 ] ]
  let s:p.replace.left = [ [ s:shade0, s:accent1 ], [ s:shade0, s:accent2 ] ]
  let s:p.visual.left = [ [ s:shade0, s:accent7 ], [ s:shade0, s:accent2 ] ]
  let s:p.normal.middle = [ [ s:shade0, s:accent2 ] ]
  let s:p.inactive.middle = [ [ s:shade0, s:accent2 ] ]
  let s:p.tabline.left = [ [ s:shade0, s:accent2 ] ]
  let s:p.tabline.tabsel = [ [ s:shade0, s:accent2 ] ]
  let s:p.tabline.middle = [ [ s:shade0, s:accent2 ] ]
  let s:p.tabline.right = copy(s:p.normal.right)
  let s:p.normal.error = [ [ s:accent0, s:shade0 ] ]
  let s:p.normal.warning = [ [ s:accent2, s:shade1 ] ]

  let g:lightline#colorscheme#laserwave_all_pink#palette = lightline#colorscheme#fill(s:p)

  
