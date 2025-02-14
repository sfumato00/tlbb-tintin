local DIGITS = {
    ["零"] = 0,
    ["一"] = 1,
    ["二"] = 2,
    ["三"] = 3,
    ["四"] = 4,
    ["五"] = 5,
    ["六"] = 6,
    ["七"] = 7,
    ["八"] = 8,
    ["九"] = 9
}

local UNITS = {
    ["十"] = 10, ["百"] = 100, ["千"] = 1000, ["万"] = 10000
}

local function utf8_char_iter(s)
    local i = 1
    local function iter()
        if i > #s then
            return nil
        end

        local byte = string.byte(s, i)
        local char_len = 1

        -- Determine the number of bytes in the UTF-8 character based on the first byte
        if byte >= 0xF0 then
            char_len = 4 -- 4-byte character
        elseif byte >= 0xE0 then
            char_len = 3 -- 3-byte character (Chinese characters)
        elseif byte >= 0xC0 then
            char_len = 2 -- 2-byte character
        end

        -- Extract the character
        local char = string.sub(s, i, i + char_len - 1)
        i = i + char_len
        return char
    end
    return iter
end

local function ChineseToInteger(chinese_number)
    local result = 0
    local current_selection = 0
    local current_number = 0
    local unit_value = 1

    for ch in utf8_char_iter(chinese_number) do
        if DIGITS[ch] then
            current_number = DIGITS[ch]
        elseif UNITS[ch] then
            unit_value = UNITS[ch]
            if current_number == 0 and ch == "十" then
                current_number = 1
            end
            current_selection = current_selection + current_number * unit_value
            current_number = 0
        elseif ch == "零" then
            current_number = 0
        end
    end

    result = result + current_selection + current_number
    return result
end

function CnToInt(x)
    print(ChineseToInteger(x))
end