local AlarmSide = "top"
local MinCoolant = 10 
local MaxHeatedCoolant = 50
local MaxWaste = 90

--[[
Notes:
    Variables:
        AlarmSide: side of the computer you have the alarm placed on.
        MinCoolant: Minimum amount of coolant stored before shutting down(in %).
        MaxHeatedCoolant: Maximum amount of heated coolant before shutting down(in %).
        MaxWaste: Maximum amount of waste stored before sshutting down(in %).
--]]

--Don't modify anything below this line.

os.sleep(5)
local Reactor = peripheral.find("fissionReactorLogicAdapter")
local PreviousDamage = 0

function Stop(alarm)
    if not Reactor.getStatus() then return; end
    if alarm and not redstone.getOutput(AlarmSide) then
        redstone.setOutput(AlarmSide, true)
        print("Stopping Reactor to avoid catastrophic meltdown/explosion")
    end
    Reactor.scram()
end
function Start()
    if Reactor.getStatus() then return; end
    if redstone.getOutput(AlarmSide) then
        print("Reactor is stable, starting reactor")
        redstone.setOutput(AlarmSide, false)
    end
    Reactor.activate()
end

--Main loop
while true do
    --Variables
    local Alarming = redstone.getOutput(AlarmSide)
    local Running = Reactor.getStatus()
    local Damage = Reactor.getDamagePercent()
    local Temperature = Reactor.getTemperature()
    local CoolantPercentage = (Reactor.getCoolantFilledPercentage() < MinCoolant/100)
    local CoolantOutputPercentage = (Reactor.getHeatedCoolantFilledPercentage() > MaxHeatedCoolant/100)
    local WastePercentage = (Reactor.getWasteFilledPercentage() > MaxWaste/100)
    
    --Checks and balances
    if Running then
        if (Damage > 10  or (Damage-PreviousDamage) > 1) and Running then
            print("Reactor temperature critical")
            Stop(true)
        elseif CoolantPercentage then
            print("Reactor ran out of coolant")
            Stop()
        elseif CoolantOutputPercentage then
            print("Reactor heated coolant output filled")
            if MaxHeatedCoolant <= 50 then
                Stop(false)
            else
                Stop(true)
            end
        elseif WastePercentage then
            print("Reactor waste stores filled up")
            Stop(true)
        end
    end
    if not WastePercentage and not CoolantOutputPercentage and not CoolantPercentage and (Temperature < 400 and Damage <= 10) then
        Start() 
    end
    PreviousDamage = Damage
end
