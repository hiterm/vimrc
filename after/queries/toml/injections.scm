;; for """vim script"""
((pair
  (bare_key) @_key
  (string) @vim)
 (#vim-match? @_key "^hook_\w*")
 (#vim-match? @vim "^\"\"\"")
 (#offset! @vim 0 3 0 -3))
;; for '''vim script'''
((pair
  (bare_key) @_key
  (string) @vim)
 (#vim-match? @_key "^hook_\w*")
 (#vim-match? @vim "^'''")
 (#offset! @vim 0 3 0 -3))
;; for "vim script"
((pair
  (bare_key) @_key
  (string) @vim)
 (#vim-match? @_key "^hook_\w*")
 (#vim-match? @vim "^\"\([^\"]\)\@=")
 (#offset! @vim 0 1 0 -1))
;; for 'vim script'
((pair
  (bare_key) @_key
  (string) @vim)
 (#vim-match? @_key "^hook_\w*")
 (#vim-match? @vim "^'\([^']\)\@=")
 (#offset! @vim 0 1 0 -1))
