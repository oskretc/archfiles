" =======================================================
" 1. NON-RECURSIVE MNEI NAVIGATION CLUSTER
" =======================================================
nnoremap m h
nnoremap n j
nnoremap e k
nnoremap i l

vnoremap m h
vnoremap n j
vnoremap e k
vnoremap i l

" =======================================================
" 2. INSERT MODE
" =======================================================
nnoremap j i

" =======================================================
" 3. HELIX-STYLE WORD SELECTION (w & b)
" =======================================================
nnoremap w ve
nnoremap b vb

vnoremap w e
vnoremap b b

" =======================================================
" 4. HELIX-STYLE LINE SELECTION (x to select and advance)
" =======================================================
" From Normal Mode: Pressing x highlights the current line and jumps down
nnoremap x V

" From Visual Mode: Pressing x expands the current line selection down one line
vnoremap x j

" =======================================================
" 5. HELIX LINE-LEVEL NAVIGATION
" =======================================================
nnoremap gm ^
nnoremap gl $

vnoremap gm ^
vnoremap gl $
