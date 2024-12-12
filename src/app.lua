local http_server = require "http.server"
local http_headers = require "http.headers"
local json = require "dkjson"
local util = require "util"
local service = require "service"

local persons = {{id=1, name="Fabio"}, {id=2, name="Claudia"}, {id=3, name="Natasha"}}

local function handle_request(app, stream)
    local req_headers = stream:get_headers()
    local method = req_headers:get(":method")
    local path = req_headers:get(":path")

    if method == "GET" and path:match("^/persons$") then
        local res_headers = http_headers.new()
        res_headers:append(":status", "200")
        res_headers:append("content-type", "application/json")
        stream:write_headers(res_headers, false)
        stream:write_chunk(json.encode(persons), true)
    elseif method == "GET" and path:match("^/[persons]+/%d+$") then
        local id = string.match(path, "%d+")
        local res_headers = http_headers.new()
        res_headers:append(":status", "200")
        res_headers:append("content-type", "application/json")
        stream:write_headers(res_headers, false)
        stream:write_chunk(json.encode(persons[tonumber(id)]), true)
    elseif method == "POST" and path:match("^/persons$") then
        local body = stream:get_body_as_string()
        local data = json.decode(body)
        print(data.name)
        local res_headers = http_headers.new()
        res_headers:append(":status", "201")
        stream:write_headers(res_headers, false)
    elseif method == "DELETE" and ath:match("^/persons$") then
        local res_headers = http_headers.new()
        res_headers:append(":status", "204")
        stream:write_headers(res_headers, false)
    else
        local res_headers = http_headers.new()
        res_headers:append(":status", "404")
        stream:write_headers(res_headers, false)
    end
end

local server = assert(http_server.listen {
    host = "127.0.0.1",
    port = 8080,
    onstream = handle_request,
    onerror = function(app, context, op, err, errno)
        local msg = op .. " on " .. tostring(context) .. " failed: " .. tostring(err)
        print(msg)
    end,
})

print("Server listening at http://127.0.0.1:8080/")
assert(server:loop())