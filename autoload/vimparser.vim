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

function! vimparser#empty()
endfunction

function! vimparser#parse(str)
endfunction

"===========================================================================
" reader
"

function! vimparser#new_reader(lines)
  let reader = { 'lines': a:lines, 'nline': 0, 'ncol': 0 }

  function reader.is_end()
    return self.nline < len(self.lines) ? 0 : 1
  endfunction

  function reader.forward(num)
    let self.ncol += a:num
    if self.ncol >= len(self.lines[self.nline])
      let self.nline += 1
      return 1
    else
      return 0
    endif
  endfunction

  function reader.peek_char()
    if self.is_end() | return '' | endif " check end of stream.
    return self.lines[self.nline][self.ncol]
  endfunction

  function reader.char()
    let ch = self.peek_char()
    call self.forward(len(ch))
    return ch
  endfunction

  function reader.skipwhite()
    while 1
      let ch = self.peek_char()
      if ch ==# '' || (ch !=# ' ' && ch !=# "\t")
        return
      endif
      call self.forward(len(ch))
    endwhile
  endfunction

  return reader
endfunction
