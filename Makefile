lint:
	luacheck lua
stylua:
	stylua --color always lua/
styluaCheck:
	stylua --color always --check lua/