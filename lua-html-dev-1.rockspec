package = "lua-html"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/hcssmith/lua-html.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
dependencies = {
   "lua ~> 5.4"
}
build = {
   type = "builtin",
   modules = {
      ["lua-html"] = "src/lua-html.lua"
   }
}
