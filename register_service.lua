registerService = {}

local mongo = require "mongodb"

function registerService.getData()
    return mongo.getData()
end

function registerService.saveData(data)
    mongo.saveData(data)
end

return registerService