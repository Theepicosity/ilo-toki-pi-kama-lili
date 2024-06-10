-- the reverse of toki_nasin.lua
-- setup!
local input = io.open("nimi_toki_pona.txt", "rb")
word_table = {}
for i in input:lines() do
    table.insert(word_table, i)
end
input:close()

-- read!
local input = io.open("open.txt", "rb")
local ta = {}
for i in input:lines() do
    for b, j, p in i:gmatch("(%p*)(%w+)(%p*)") do
        if b ~= "" then table.insert(ta, "fsm") end
        table.insert(ta, b)
        table.insert(ta, j)
        table.insert(ta, p)
    end
    table.insert(ta, "\n")
end
input:close()

-- encode! (the hard part)
local function in_table(table, value)
    if value == " " then return 1
    elseif value == "\n" then return 2
    elseif value == "fsm" then return 182 end
    for i, v in ipairs(table) do
        if v == value then
            return i
        end
    end
    if value ~= "" then return 179 end
    return 0
end

local tb = {}
for i, v in ipairs(ta) do
    if in_table(word_table, v) == 179 then
        table.insert(tb, 179)
        for j=1, #v do
            table.insert(tb, string.byte(v,j))
        end
        table.insert(tb, 180)
    elseif in_table(word_table, v) > 1 then table.insert(tb, in_table(word_table, v)) end
end

-- write!
local output = io.open("insa.toki", "wb")
output:write(string.char(table.unpack(tb, i)))
output:close()
