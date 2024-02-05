mongoDB = {}

local mongo = require "mongo"
local cjson = require "cjson"
local config = require "configuration"

local client = mongo.Client(config.url)
local collection = assert(client:getCollection(config.database, config.collection))

function mongoDB.getData()
    local data = {}
    local index = 1
    for poirepresentations in collection:find({}):iterator() do
        data[index] = cjson.encode(poirepresentations)
        index = index + 1
    end
    return cjson.encode(data)
end

return mongoDB