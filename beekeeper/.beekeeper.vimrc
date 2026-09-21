" =======================================================
" 1. NON-RECURSIVE MNEI NAVIGATION CLUSTER
" =======================================================
" nnoremap = Normal mode (no-recurse) | vnoremap = Visual mode (no-recurse)

" Normal Mode Directionals
nnoremap m h
nnoremap n j
nnoremap e k
nnoremap i l

" Visual Mode Directionals (Selection)
vnoremap m h
vnoremap n j
vnoremap e k
vnoremap i l

" =======================================================
" 2. INSERT MODE
" =======================================================
" Safely map 'j' to the default factory 'i' behavior
nnoremap j i

" =======================================================
" 3. HELIX LINE-LEVEL NAVIGATION
" =======================================================
nnoremap gm ^
nnoremap gl $

vnoremap gm ^
vnoremap gl $
