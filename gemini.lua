local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson")

local gemini = {}

gemini.API_KEY = ""
gemini.BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models/"

gemini.models = {
    _2_0_ = {
	PRO = "gemini-2.0-pro",
        FLASH = "gemini-2.0-flash",
	FLASH_LITE = "gemini-2.0-flash-lite",
    },

    _1_5_ = {
        PRO_15 = "gemini-1.5-pro",
        FLASH_15 = "gemini-1.5-flash",
        FLASH_15_8B = "gemini-1.5-flash-8b",
    },

    EXPERIMENTAL = {
        _2_5_ = {
		PRO_EXP_03_25 = "gemini-2.5-pro-exp-03-25",
	},

	_2_0_ = {
		PRO_EXP_02_05 = "gemini-2.0-pro-exp-02-05",
		FLASH_EXP = "gemini-2.0-flash-exp",
		PRO_EXP_1206 = "gemini-exp-1206",
		FLASH_THINKING_EXP = "gemini-2.0-flash-thinking-exp-1219",
	},

	_1_5_ = {
		PRO_EXP_0827 = "gemini-1.5-pro-exp-0827",
		PRO_EXP_0801 = "gemini-1.5-pro-exp-0801",
		FLASH_EXP_8B_0924 = "gemini-1.5-flash-8b-exp-0924",
		FLASH_EXP_8B_0827 = "gemini-1.5-flash-8b-exp-0827",
	},

	EXP_1121 = "gemini-exp-1121",
	EXP_1114 = "gemini-exp-1114",
    },
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
