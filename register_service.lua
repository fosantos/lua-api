registerService = {}

local mongo = require "mongodb"

function registerService.getData()
    return mongo.getData()
end

return registerService