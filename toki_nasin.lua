-- the reverse of nasin_toki.lua
-- setup!
local input = io.open("nimi_toki_pona.txt", "rb")
word_table = {}
for i in input:lines() do
    table.insert(word_table, i)
end
input:close()

-- read!
local input = io.open("insa.toki", "rb")
local ta = {}
for i in input:lines(1) do
    table.insert(ta, i)
end
input:close()


-- decode! (the hard part) �
local tb = {}
local unicode_read_mode = false
local front_space = false
for i=1, #ta do
    if string.byte(ta[i]) == 180 then unicode_read_mode = false
    elseif unicode_read_mode then table.insert(tb, ta[i])
    elseif string.byte(ta[i]) == 2 then table.insert(tb, "\n")
    elseif string.byte(ta[i]) == 179 then
        unicode_read_mode = true
        if i-2 > 0 and string.byte(ta[i-2]) ~= 182 and string.byte(ta[i-1]) ~= 2 and not string.match(ta[i+1], "%p+") then table.insert(tb, " ") end
    elseif string.byte(ta[i]) == 182 then
        front_space = true
        if string.byte(ta[i-1]) ~= 2 then table.insert(tb, " ") end
    else table.insert(tb, word_table[string.byte(ta[i])])
    end
    if not unicode_read_mode and not front_space and i < #ta and string.byte(ta[i]) ~= 2 then
        if word_table[string.byte(ta[i+1])] then
            if not string.match(word_table[string.byte(ta[i+1])], "%p+") then table.insert(tb, " ") end
        elseif string.byte(ta[i+1]) == 179 then table.insert(tb, " ") end
    elseif front_space and string.byte(ta[i]) ~= 182 then front_space = false
    end
        --if unicode_read_mode then table.insert(tb, " ") end
end

-- write!
local output = io.open("pini.txt", "wb")
output:write(table.unpack(tb, i))
output:close()
