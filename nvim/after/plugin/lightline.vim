let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], 
  \             [ 'filename' ],
  \             [ 'gitbranch', 'gitgutter' ], ],
  \   'right': [ [ 'obsession', 'lineinfo', 'percent' ],
  \              [ 'cocstatus', 'filetype', 'readonly' ], ],
  \ },
  \ 'tabline': {
  \   'left': [ [ 'buffers' ] ],
  \   'right': [ ],
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'gitbranch': 'LightLineGitBranch',
  \   'gitgutter': 'LightLineGitGutter',
  \   'obsession': 'ObsessionStatus',
  \ },
\ }

" GitHub issue detailing how to add extra Git info: https://github.com/itchyny/lightline.vim/issues/164
function! LightLineGitBranch()
  if exists("*FugitiveHead")
    let branch = FugitiveHead()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction
function! LightLineGitGutter()
  if exists("*FugitiveHead") && FugitiveHead() != ''
    let [ added, modified, removed ] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', added, modified, removed)
  else
    return ''
  endif
endfunction

" Change theme based upon time of day
" if strftime("%H") > 9 && strftime("%H") < 16 
let g:lightline.colorscheme='laserwave'
