function eat()
    print("eating...")
    for i = 1, 16 do -- loop through the slots
        turtle.select(i) -- change to the slot
        if turtle.refuel(0) then -- if it's valid fuel
            local halfStack = math.ceil(turtle.getItemCount(i)/2) -- work out half of the amount of fuel in the slot
            turtle.refuel(halfStack) -- consume half the stack as fuel
            print('Fuel-Level: ' .. turtle.getFuelLevel());
            return
        end
    end
    print('Fuel not found')
end

function checkChest(i)
    local chest = peripheral.find("minecraft:chest")
    local item = chest.getItemDetail(i)
    if not item then return end
        print(("Slot %i:"):format(i))
        print(("  %s (%s)"):format(item.displayName, item.name))
        print(("  Count: %d/%d"):format(item.count, item.maxCount))
        if item.damage then
            print(("  Damage: %d/%d"):format(item.damage, item.maxDamage))
    end
end

for i = 1, 54 do
    checkChest(i)
end