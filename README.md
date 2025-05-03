# Gemini.lua

`gemini.lua` is a lightweight Lua library for interacting with the Gemini API.

## Installation

To install `gemini.lua`, you can use Luarocks:

```sh
luarocks install geminilua
```

Alternatively, you can download the repository and include it in your Lua project manually.

## Dependencies

`gemini.lua` requires the following libraries:

- `lua-cjson`
- `luasocket`
- `luasec`

If you installed `gemini.lua` via Luarocks, these dependencies will be installed automatically. Otherwise, you can install them manually:

```sh
luarocks install lua-cjson
luarocks install luasocket
luarocks install luasec
```

## Example Usage

Here’s a basic example of how to use `gemini.lua`:

```lua
local gemini = require("gemini")

local api_key = "YOUR_API_KEY"  -- Replace with your actual API key

local client = gemini.Client.new(api_key, "gemini-2.0-flash")
print("What is your question?")
local prompt = io.read()

local response, err = client:generate_content(prompt)

if response then
    print(response)
else
    print("Error:", err)
end
```

## Roadmap

Planned features for future releases of `gemini.lua` include:
- **Media Support**: Improve functionality for sending and receiving media.

## Contributing

If you have suggestions for new features or improvements, feel free to open an issue or submit a pull request.

## Contact 

You can contact me on Discord. My username is `tbkurt`

## License

`gemini.lua` is open-source and distributed under the MIT License.

