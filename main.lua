local pegasus = require "pegasus"
local regService = require "register_service"
local util = require "pl.pretty"
local cjson = require "cjson"

local server = pegasus:new("9090")

server:start(function (req, res)
    if req:path() == "/registers" and req:method() == "GET" then
      local responseData = assert(cjson.encode(regService.getData()))
      res:addHeader("Content-Type", "application/json"):write(responseData)
    elseif req:path() == "/registers" and req:method() == "POST" then
      local body = req:receiveBody()
      local decoded = cjson.decode(body)
      print(decoded.name)
      regService.saveData(body)
      res:addHeader("Content-Type", "text/html"):write("<h>This is a POST endpoint. You sent: " .. body .. "</h>")
    else
      res:addHeader("Content-Type", "text/html"):write("This is neither the GET nor the POST endpoint")
    end
  end)