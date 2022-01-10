-- libraries
local notifications = loadstring(game:HttpGet(("https://raw.githubusercontent.com/burgs-io/bombies/main/notif.lua"),true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/MarsQQ/Unpatchabomb/master/unpatchabomb_english_words", true))()

-- variables
local used_words = {}
local user_input_service = game:GetService("UserInputService")

-- functions
local function is_used(string)
    for i, v in pairs(used_words) do
        if v == string then return true end
    end
end

local function get_request()
    local text_frame = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Container.GameSpace.DefaultUI.GameContainer.DesktopContainer.InfoFrameContainer.InfoFrame.TextFrame
    local request = ""
    for i, v in pairs(text_frame:GetChildren()) do
        if v.Name == "LetterFrame" then
            request = request..(v.Letter.TextLabel.Text)
        end
    end
    return request
end

local function find_word(word)
    for i, v in pairs(ENGLISH_WORDS) do
        if string.find(v, string.lower(word)) and not is_used(v) then
            table.insert(used_words, v)
            return v
        end
    end
end

local function on_text_box_focused(text_box)
    local hes = _G.hesitance
    if text_box.Name == "Typebox" then
        task.wait(hes)
        local answer = find_word(get_request())
        for v in string.gmatch(answer, "(%w)") do task.wait()
            local let_speed = _G.letter_speed
            text_box.Text = text_box.Text..string.upper(v)
            task.wait(let_speed)
        end
        keypress(0x0D)
    else
        task.wait()
    end
end

-- code
notifications.prompt("Autobomb Executed", "Welcome to Autobomb. Just relax, the game plays itself.")
user_input_service.TextBoxFocused:Connect(on_text_box_focused)
