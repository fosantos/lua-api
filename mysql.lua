local driver = require "luasql.mysql"
local env = driver.mysql()
local con = assert(env:connect("stage_common","uat","pw4dev","gcp-stage-oos-sql-proxysql-g04-vip.gcp.dlns.io", 6033))

local cursor = assert(con:execute("SELECT * FROM sftpConfigurations"))
local row = cursor:fetch({}, "a")

while row do
    print(string.format("homeDir: %s", row.homeDir))
    row = cursor:fetch(row, "a")
end

con:close()
env:close()