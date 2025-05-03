local http = require("socket.http")
local ltn12 = require("ltn12")
local cjson = require("cjson")

local gemini = {}

local client = {
    api_key = nil,
    base_url = "https://generativelanguage.googleapis.com/v1beta/models/",
    model = nil
}

gemini.Client = {}
gemini.Chat = {}

gemini.Client.new = function(api_key, model)
    local self = setmetatable({}, { __index = gemini.Client })
    self.api_key = api_key
    self.model = model
    return self
end

function gemini.Client:get_model_names()
    local response_body = {}
    local url = "https://generativelanguage.googleapis.com/v1beta/models/?key=" .. self.api_key

    local res, code, headers, status = http.request{
        url = url,
        method = "GET",
        headers = {
            ["Content-Type"] = "application/json"
        },
        sink = ltn12.sink.table(response_body)
    }
    if code ~= 200 then
        return nil, "HTTP request failed with status code: " .. tostring(code)
    end

    local body = table.concat(response_body)
    local data, pos, err = cjson.decode(body)

    if not data or not data.models then
        return nil, "Failed to decode or parse model list"
    end

    local names = {}
    for _, model in ipairs(data.models or {}) do
        local name = model.name:gsub("^models/", "")
        table.insert(names, name)
    end

    return names
end

function gemini.Client:generate_content(prompt, systemInstruction)
    local url = string.format("%s%s:generateContent?key=%s", client.base_url, self.model, self.api_key)
    local request_body = cjson.encode({
        contents = {
            {
                parts = {
                    { text = prompt }
                }
            }
        },
        systemInstruction = {
            parts = {
                { text = systemInstruction}
            }
        }
    })
    local response_body = {}

    local _, status_code = http.request{
        url = url,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#request_body)
        },
        source = ltn12.source.string(request_body),
        sink = ltn12.sink.table(response_body)
    }

    if status_code == 200 then
        local response_json = cjson.decode(table.concat(response_body))
        if response_json and response_json.candidates then
            local ai_response = response_json.candidates[1].content.parts[1].text
            return ai_response
        end
    else
        return nil, "HTTP request failed with status: " .. tostring(status_code)
    end
end

function gemini.Client:new_chat(model, systemInstruction, history)
    local chat = setmetatable({}, { __index = gemini.Chat })
    chat.api_key = self.api_key
    chat.model = model or self.model
    chat.history = history or {}
    chat.systemInstruction = systemInstruction or ""
    return chat
end

function gemini.Chat:send_message(prompt)
    print(self.systemInstruction ) 
    table.insert(self.history, { role = "user", parts = { { text = prompt } } })

    local url = string.format("%s%s:generateContent?key=%s", client.base_url, self.model, self.api_key)
    local request_body = cjson.encode({
        contents = self.history,
        systemInstruction = {
            parts = {
                { text = self.systemInstruction }
            }
        }
    })
    local response_body = {}

    local _, status_code = http.request{
        url = url,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#request_body)
        },
        source = ltn12.source.string(request_body),
        sink = ltn12.sink.table(response_body)
    }

    if status_code == 200 then
        local response_json = cjson.decode(table.concat(response_body))
        if response_json and response_json.candidates then
            local ai_response = response_json.candidates[1].content.parts[1].text
            table.insert(self.history, { role = "assistant", parts = { { text = ai_response } } })
            return ai_response
        end
    else
        return nil, "HTTP request failed with status: " .. tostring(status_code)
    end
end

return gemini