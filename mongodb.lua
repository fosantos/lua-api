mongoDB = {}

local mongo = require "mongo"
local cjson = require "cjson"
local config = require "configuration"
local util = require "pl.pretty"

local client = mongo.Client(config.url)
local collection = assert(client:getCollection(config.database, config.collection))

function mongoDB.getData()
    local data = {}
    local index = 1
    for register in collection:find({}):iterator() do
        data[index] = register
        index = index + 1
    end
    return data
end

function mongoDB.saveData(data)
    collection:insert(data)
end

return mongoDB