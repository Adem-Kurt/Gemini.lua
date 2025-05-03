local gemini = require("gemini")

local api_key = "YOUR_API_KEY"  -- Replace with your actual API key

local client = gemini.Client.new(api_key, "gemini-2.0-flash")
local chat = client:new_chat("gemini-2.0-flash")

while true do
    io.write("User: ")
    local user_input = io.read()
    
    if user_input == "exit" then
        print("Chat ended.")
        break
    end

    local response, err = chat:send_message(user_input)
    if response then
        print("AI: " .. response)
    else
        print("Error:", err)
    end
end
