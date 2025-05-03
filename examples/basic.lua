local gemini = require("gemini")

local api_key = "YOUR_API_KEY"  -- Replace with your actual API key

local client = gemini.Client.new(api_key, "gemini-2.0-flash")

print("give a prompt to Gemini\n")
local user_input = io.read()

local response, err = client:generate_content(user_input)

if response then
    print("Gemini's response:")
    print("------------------")
    print(response)
else
    print("Error occurred:", err)
end