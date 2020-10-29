set smartindent

function! s:Init()
  let b:def_expandtab = &expandtab
  let b:def_shiftwidth = &shiftwidth
  let b:def_tabstop = &tabstop
  let b:def_softtabstop = &softtabstop

  let b:tabbing = -1

  function! s:CycleTabbing(i)
    if b:tabbing < 0
      let b:tabbing = 0
    else
      let b:tabbing = (b:tabbing + a:i) % 4
    endif
    if b:tabbing == 1
      set expandtab shiftwidth=2 tabstop=8 softtabstop=-1
    elseif b:tabbing == 2
      set expandtab shiftwidth=4 tabstop=8 softtabstop=-1
    elseif b:tabbing == 3
      set noexpandtab shiftwidth=2 tabstop=2 softtabstop=0
    else
      if b:def_expandtab
        set expandtab
      else
        set noexpandtab
      endif
      exe 'set shiftwidth=' . b:def_shiftwidth
      exe 'set tabstop=' . b:def_tabstop
      exe 'set softtabstop=' . b:def_softtabstop
    endif
    echo '[' . b:tabbing . ']' &expandtab &shiftwidth &tabstop &softtabstop
  endfunction

  nnoremap <silent> <A-Tab> :call <SID>CycleTabbing(1)<CR>
  inoremap <silent> <A-Tab> <Esc>:call <SID>CycleTabbing(1)<CR>a
endfunction

au BufWinEnter * call s:Init()
