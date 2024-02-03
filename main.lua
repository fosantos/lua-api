local pegasus = require "pegasus"
local mongo = require "mongodb"

local server = pegasus:new("9090")

server:start(function (req, rep)
    if req:path() == "/poirepresentations" and req:method() == "GET" then
      rep:addHeader("Content-Type", "application/json"):write(mongo.getData())
    elseif req:path() == "/pizzas" and req:method() == "POST" then
      local body = req:post() -- get the POST data
      rep:addHeader("Content-Type", "text/html"):write("<h>This is a POST endpoint. You sent: " .. body .. "</h>")
    else
      rep:addHeader("Content-Type", "text/html"):write("This is neither the GET nor the POST endpoint")
    end
  end)