local arg = { ... }

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

function goForward(x)
    x = x or 1
    for i = 1, x do
        turtle.dig();
        turtle.forward();
    end
end
function goBackwards(x)
    x = x or 1
    turn180()
    goForward(x)
end
function goLeft(x)
    x = x or 1
    turtle.turnLeft()
    goForward(x)
end
function goRight(x)
    x = x or 1
    turtle.turnRight()
    goForward(x)
end
function goUp(x)
    x = x or 1
    for i = 1, x do
        turtle.digUp()
        turtle.up()
    end
end
function goDown(x)
    x = x or 1
    for i = 1, x do
        turtle.digDown()
        turtle.down()
    end
end
function turn180()
    turtle.turnRight()
    turtle.turnRight()
end

function grabeGang(x)
    x = x or 1
    for i = 1, x do
        goForward()
        turtle.digDown()
    end
end
function grabeMiningSegmente(x)
    x = x or 1
    for i = 1, x do
        grabeGang(3)
        pos["b"] = pos["b"] + 1
        goLeft(5)
        pos["c"] = -5
        goBackwards(10)
        pos["c"] = 5
        goBackwards(5)
        pos["c"] = 0
        turtle.turnRight()
    end
end

function goHome()
    goBackwards(pos["b"] * 3)
    pos["b"] = 0

    if pos["a"]>0 then
        turtle.turnRight()
        goForward(pos["a"]*12-6)
        turtle.turnLeft()
    elseif pos["a"]<0 then
        turtle.turnLeft()
        grabeGang(pos["a"]*-12-6)
        turtle.turnRight()
    end
    pos["a"] = 0
    turtle.down()
    turtle.forward()
    turn180()
end

local schacht = tonumber(arg[1]) or 1
local segmente = tonumber(arg[2]) or 3
pos = {}
pos["a"] = 0    --Hauptgang, der erste seitliche Gang
pos["b"] = 0    --Mining Schächte, können betreten werden
pos["c"] = 0    --1x1 Strip-Löcher

eat()
goForward()
goUp()

if schacht>0 then
    turtle.turnRight()
    grabeGang(schacht*12-6)
    pos["a"] = schacht
    turtle.turnLeft()
elseif schacht<0 then
    turtle.turnLeft()
    grabeGang(schacht*-12-6)
    pos["a"] = schacht
    turtle.turnRight()
else
    goDown()
    goBackwards()
    turn180()
end

grabeMiningSegmente(segmente)
goHome()
for i = 1, 54 do
    checkChest(i)
end