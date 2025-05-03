local gemini = require("gemini")

local api_key = "YOUR_API_KEY"  -- Replace with your actual API key

local client = gemini.Client.new(api_key)

local model_names, err = client:get_model_names()

if model_names then
    print("Available Gemini Models:")
    print("------------------------------")
    
    for i, model_name in ipairs(model_names) do
        print(i .. ". " .. model_name)
    end
else
    print("Error retrieving models:", err)
end