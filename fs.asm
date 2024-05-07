bin: db 2, 1, 0, 1, "bin", 0, 0
  init: db 1, 2, 1, 1, "init", 8
  sh: db 1, 3, 1, 1, "sh", 0, 0, 9
  test: db 1, 4, 1, 1, "test", 10
  dldemo: db 1, 5, 1, 2, "demo", 11
times 2048-($-$$) db 0
