# Gemini.lua

`gemini.lua` is a lightweight Lua library for interacting with the Gemini API.

## Installation

To install `gemini.lua`, download the repository and include it in your Lua project.

## Dependencies

`gemini.lua` requires the following libraries:

- `dkjson`
- `luasocket`

Ensure these dependencies are installed before using `gemini.lua`. You can install them easily via Luarocks.

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
- **Luarocks Support**: Simplify installation and dependency management.
- **Media Support**: Improve functionality for sending and receiving media.
- **Chat Support**: Add chat functionality to allow the library to remember previous messages and context.

## Contributing

If you have suggestions for new features or improvements, feel free to open an issue or submit a pull request.

## License

`gemini.lua` is open-source and distributed under the MIT License.
