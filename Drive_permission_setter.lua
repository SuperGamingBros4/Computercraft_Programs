local Ids = {[7] = "4873-867"}

local Drive = peripheral.find("drive")
local Args = {...}

local Level = tonumber(Args[2])

if not Drive then print("No Drive"); return; end
if not Drive.isDiskPresent() then print("No Disk"); return; end

if Level and type(Level) == "number" then
    Drive.setDiskLabel("Keycard, level: " .. tostring(Level))
    local Keycard = fs.open("disk/id.txt", "w")
    Keycard.write(Ids[Level])
    Keycard.close()
end
