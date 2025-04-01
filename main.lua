local gemini = require("gemini")

gemini.API_KEY = "AIzaSyBBZUZgvuxuoluWHViKda0YCtrfC76xxbQ"  -- Replace with your actual API key

local model = gemini.models.FLASH
print("What is your question?")
local prompt = io.read()

local response, err = gemini.send_request(model, prompt)

if response then
    print(response)
else
    print("Error:", err)
end