" vim:set ts=8 sts=2 sw=2 tw=0 et:
"
" vimparser.vim - Vim script parser written in vim script.

function! vimparser#get_funcdef(name)
  redir => str
  silent execute "function " . a:name
  redir END
  let lines = split(str, '\n')
  return map(lines, 'substitute(v:val, "\\\m^\\\d*\\\s*  ", "", "")')
endfunction

function! vimparser#parse(str)
endfunction
