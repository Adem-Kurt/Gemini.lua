local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson")

local gemini = {}

gemini.API_KEY = ""
gemini.BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models/"

gemini.models = {
    FLASH = "gemini-2.0-flash",
    PRO = "gemini-2.0-pro"
}

local function send_api_request(url, method, body)
    local response_body = {}
    local headers = {
        ["Content-Type"] = "application/json",
        ["Content-Length"] = tostring(#body)
    }

    local res, code, _, status = http.request{
        url = url,
        method = method,
        headers = headers,
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response_body)
    }

    print("HTTP Code: ", code)

    if #response_body == 0 then
        return nil, "Error: Empty response from API"
    end

    local raw_json = table.concat(response_body):gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace

    local response_json, err = json.decode(raw_json)
    if not response_json then
        print("JSON Decode Error: ", err)
        return nil, "JSON Decode Error: " .. tostring(err)
    end

    return response_json
end

function gemini.process_response(response_json)
    if response_json and response_json.candidates then
        for _, candidate in ipairs(response_json.candidates) do
            if candidate.content and candidate.content.parts then
                for _, part in ipairs(candidate.content.parts) do
                    return part.text
                end
            end
        end
    end
    return nil, "No valid response found."
end

function gemini.send_request(model, prompt)
    local url = gemini.BASE_URL .. model .. ":generateContent?key=" .. gemini.API_KEY

    local request_body = json.encode({
        contents = {
            { parts = { { text = prompt } } }
        }
    })

    local response_json, err = send_api_request(url, "POST", request_body)
    if err then
        return nil, err
    end

    return gemini.process_response(response_json)
end

return gemini
