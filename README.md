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

- `dkjson`
- `luasocket`
- `luasec`

If you installed `gemini.lua` via Luarocks, these dependencies will be installed automatically. Otherwise, you can install them manually:

```sh
luarocks install dkjson
luarocks install luasocket
luarocks install luasec
```

## Example Usage

Here’s a basic example of how to use `gemini.lua`:

```lua
local gemini = require("gemini")

gemini.API_KEY = "YOUR_API_KEY"  -- Replace with your actual API key

local model = gemini.models.FLASH
print("What is your question?")
local prompt = io.read()

local response, err = gemini.send_request(model, prompt)

if response then
    print(response)
else
    print("Error:", err)
end
```

## Roadmap

Planned features for future releases of `gemini.lua` include:
- **Media Support**: Improve functionality for sending and receiving media.
- **Chat Support**: Add chat functionality to allow the library to remember previous messages and context.

## Contributing

If you have suggestions for new features or improvements, feel free to open an issue or submit a pull request.

## License

`gemini.lua` is open-source and distributed under the MIT License.

