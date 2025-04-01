rockspec_format = "3.0"

package = "geminilua"
version = "1.0.0-1"
source = {
  url = "https://github.com/Adem-Kurt/Gemini.lua/blob/main/gemini.lua",
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
  "dkjson >= 2.5",
}

build = {
   type = "builtin",
   modules = {
      gemini = "gemini.lua"
   }
}
