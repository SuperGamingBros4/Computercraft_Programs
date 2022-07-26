local Timer = 2.5 -- Closes the door after this timer has passed
local OutputSide = "Left" -- The side of the Computer the door is on
local PassCode = "FissileFuel" -- The password

function Type(Text)
    for i=1,#Text do
        write(string.sub(Text, i, i))
        os.sleep()
    end
end

-- Do not modify anything below this line
while true do
    while true do
        term.clear()
        term.setCursorPos(1,1)
        write("Enter passcode\n")
        write("> ")
        local Input = read("*")

        if Input == PassCode then
            Type("Correct passcode.")
            break end
        print("Wrong passcode.")
        os.sleep(0.5)
    end
    rs.setOutput(OutputSide, true)
    os.sleep(Timer)
    rs.setOutput(OutputSide, false)
end
