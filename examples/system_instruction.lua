local gemini = require("gemini")

local api_key = "YOUR_API_KEY"  -- Replace with your actual API key

local client = gemini.Client.new(api_key, "gemini-2.0-flash")

print("This program will check if your statement is factually correct")
print("Example: Paris is the capital of France")
print("------------------------------")

io.write("Enter a statement")
local user_input = io.read()

local system_instruction = [[
You are a fact-checking assistant. 
Your task is to analyze the given statement and determine if it's factually correct or incorrect.
Respond with:
1. Whether the statement is correct or incorrect
2. A brief explanation with relevant facts
3. If the statement is partially correct, explain which parts are accurate and which aren't
Keep your response informative but concise.
]]

local response, err = client:generate_content(user_input, system_instruction)

if response then
    print("\nResult:")
    print(response)
else
    print("Error:", err)
end
