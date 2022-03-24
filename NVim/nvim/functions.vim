" Remove blank lines at end of file and remember cursor position
" https://stackoverflow.com/questions/7495932/how-can-i-trim-blank-lines-at-the-end-of-file-in-vim
function TrimEndLinesAndTrailingWhitespace()
  let save_cursor = getpos(".")
  silent! %s#\($\n\s*\)\+\%$##  "Substitute adjacent lines terminated by EOF w/null string
  silent! %s#\s\+$##e           "Remove trailing whitespace
  call setpos('.', save_cursor)
endfunction
