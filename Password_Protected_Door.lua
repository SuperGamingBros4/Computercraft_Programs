local Timer = 5 -- Closes the door after this timer has passed
local OutputSide = "Left" -- The side of the Computer the door is on
local PassCode = "FissileFuel" -- The password

-- Do not modify anything below this line

local Toggled = false

while true do
    while true do
        term.clear()
        write("Enter Passcode\n")
        write("> ")
        local Input = read("*")

        if Input = PassCode then break end
        print("Wrong passcode.")
        os.sleep(5)
    end
    if Toggle then
        Toggled = not Toggled
    end
    rs.setOutput(OutputSide, Toggled)
    if not Toggle then
        os.sleep(Timer)
        rs.setOutput(OutputSide, not Toggled)
    end
end
