rockspec_format = "3.0"

package = "geminilua"
version = "2.0.1-1"
source = {
  url = "git://github.com/Adem-Kurt/Gemini.lua",
  branch = "main"
}

description = {
  summary = "A beautiful Gemini API for Lua",
  detailed = [[
  This project provides a simple and intuitive API for the Gemini protocol, enabling seamless communication and interaction with Gemini servers. It offers robust features for handling requests and responses, making development easier and more efficient.
  ]],
  license = "MIT",
  homepage = "https://github.com/Adem-Kurt/Gemini.lua",
}

dependencies = {
  "lua >= 5.1",
  "luasocket >= 3.0-rc1",
  "lua-cjson >= 2.1.0.10-1",
  "luasec >= 1.3.0",
}

build = {
   type = "builtin",
   modules = {
      gemini = "src/gemini.lua"
   }
}
