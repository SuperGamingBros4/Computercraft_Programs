local Timer = 5 -- Closes the door after this timer has passed
local OutputSide = "Left" -- The side of the Computer the door is on
local PassCode = "FissileFuel" -- The password

-- Do not modify anything below this line
while true do
    while true do
        term.clear()
        term.setCursorPos(0,0)
        write("Enter Passcode\n")
        write("> ")
        local Input = read("*")

        if Input == PassCode then break end
        print("Wrong passcode.")
        os.sleep(2)
    end
    rs.setOutput(OutputSide, true)
    os.sleep(Timer)
    rs.setOutput(OutputSide, false)
end
