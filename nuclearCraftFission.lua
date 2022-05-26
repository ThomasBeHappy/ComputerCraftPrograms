local reactor = peripheral.wrap("nuclearcraft:fission_port_0")

local maxEnergy = reactor.getEnergyCapacity()

while true do
    if (reactor.getEnergyStored() / maxEnergy * 100) < 0.3 then
        rs.setOutput("back", true)
    elseif   (reactor.getEnergyStored() / maxEnergy * 100) > 0.9 then
        rs.setOutput("back", false)
    end
end