function chinese_to_arabic(chinese)
    local digits = {
        ["零"] = 0,
        ["一"] = 1,
        ["二"] = 2,
        ["三"] = 3,
        ["四"] = 4,
        ["五"] = 5,
        ["六"] = 6,
        ["七"] = 7,
        ["八"] = 8,
        ["九"] = 9,
    }

    local small_units = {
        ["十"] = 10, ["百"] = 100, ["千"] = 1000,
    }

    local big_units = {
        ["万"] = 10000, ["亿"] = 100000000,
    }

    local total = 0
    local section = 0
    local number = 0

    -- Iterate over each Unicode codepoint in the string.
    for _, code in utf8.codes(chinese) do
        local char = utf8.char(code)
        if digits[char] ~= nil then
            -- Set current number (for "零", this will be 0)
            number = digits[char]
        elseif small_units[char] then
            -- If there's no explicit digit before the unit, assume it as 1 (e.g., "十" means 10)
            if number == 0 then
                number = 1
            end
            section = section + number * small_units[char]
            number = 0
        elseif big_units[char] then
            -- Add any pending digit to the section before multiplying
            section = section + number
            total = total + section * big_units[char]
            section = 0
            number = 0
        else
            -- Ignore any unexpected characters.
        end
    end

    -- Add any remaining value
    total = total + section + number
    return total
end

function CnToInt(x)
    print(chinese_to_arabic(x))
end
