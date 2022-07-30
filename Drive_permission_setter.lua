local Ids = {[7] = "4873-867"}

local Drive = peripheral.find("drive")
local Args = {...}

local Level = Args[2]

if not Drive then print("No Drive"); return; end
if not Drive.isDiskPresent() then print("No Disk"); return; end

if Level and type(Args[2]) == "number" then
    Drive.setDiskLabel("Access level: " .. tostring(Ids[Level]) .. ", keycard")
end
