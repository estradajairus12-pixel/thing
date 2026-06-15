--[[
    Quiz System v2.2
    Features:
    - Rayfield UI
    - Filter System: Calm -> Worried -> Skip
    - Wrong Answer Global Cooldown: 3 Seconds (Anti-Spam)
    - "Starting [Quiz Name]" Notification
    - No Custom Quiz System Tab
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")

-- Configuration
local QUIZ_VERSION = "v2.2"
local WRONG_ANSWER_COOLDOWN = 3 -- Seconds
local MAX_WRONG_BEFORE_SKIP = 5 -- Triggers "Worried" then "Skip"

-- State
local currentQuiz = nil
local currentQuestionIndex = 0
local isQuizActive = false
local wrongAnswerCount = 0
local lastWrongMessageTime = 0
local filterStage = "Calm" -- Calm, Worried, Skip

-- Quiz Data (Example Structure - Replace with your actual quizzes)
local Quizzes = {
    {
        Name = "General Knowledge",
        Questions = {
            {
                Question = "What is the capital of France?",
                Answers = {"London", "Berlin", "Paris", "Madrid"},
                Correct = 3
            },
            {
                Question = "Which planet is known as the Red Planet?",
                Answers = {"Earth", "Mars", "Jupiter", "Venus"},
                Correct = 2
            }
        }
    },
    {
        Name = "Roblox Trivia",
        Questions = {
            {
                Question = "Who founded Roblox?",
                Answers = {"Notch", "David Baszucki", "Elon Musk", "Mark Zuckerberg"},
                Correct = 2
            },
            {
                Question = "What currency is used in Roblox?",
                Answers = {"V-Bucks", "Coins", "Robux", "Gold"},
                Correct = 3
            }
        }
    }
}

-- Rayfield Library (Ensure this is loaded correctly in your environment)
-- Assuming Rayfield is required or loaded via loadstring in your actual execution environment
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/RayfieldUI/Rayfield/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Quiz System " .. QUIZ_VERSION,
    LoadingTitle = "Quiz System",
    LoadingSubtitle = "by YourName",
    Theme = "Dark",
    Options = {
        Key = Enum.KeyCode.RightShift,
        HideMenus = false
    }
})

local MainTab = Window:CreateTab("Quizzes", "ui-icon-home")
local SettingsTab = Window:CreateTab("Settings", "ui-icon-settings")

-- Variables for UI
local QuizDropdown
local StartButton
local StatusLabel

-- Initialize UI
MainTab:CreateLabel("Select a quiz to begin:"):SetDividers(false)

QuizDropdown = MainTab:CreateDropdown({
    Name = "Select Quiz",
    Options = {},
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "QuizSelector",
    Callback = function(Current)
        -- Selection logic handled by button
    end,
})

-- Populate Dropdown
local quizOptions = {}
for i, quiz in ipairs(Quizzes) do
    table.insert(quizOptions, quiz.Name)
end
QuizDropdown:SetOptions(quizOptions)

StatusLabel = MainTab:CreateLabel("Status: Idle")

StartButton = MainTab:CreateButton({
    Name = "Start Quiz",
    Callback = function()
        local selected = QuizDropdown.CurrentOption
        if not selected or #selected == 0 then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please select a quiz first.",
                Duration = 5,
                Image = 39
            })
            return
        end
        
        local quizName = selected[1]
        for _, q in ipairs(Quizzes) do
            if q.Name == quizName then
                currentQuiz = q
                break
            end
        end
        
        if currentQuiz then
            StartQuiz(currentQuiz)
        end
    end
})

-- Settings Tab
SettingsTab:CreateLabel("Filter System Settings"):SetDividers(false)
SettingsTab:CreateParagraph({
    Title = "How it works",
    Content = "The system progresses through stages: Calm -> Worried -> Skip based on wrong answers."
})

-- Helper Functions
local function FilterMessage(text)
    -- Simple mock filter, replace with actual Roblox ChatService filtering if needed
    -- In a real server script, use ChatService:FilterStringAsync
    return text 
end

local function SendMessage(message)
    -- Logic to send message to chat or UI
    -- For this example, we just print or notify
    print("[QUIZ] " .. message)
    
    -- Optional: Send to all players via a remote event if this were a server script
    -- ReplicatedStorage:FindFirstChild("QuizMessage"):FireAllClients(message)
end

local function GetFilterStage()
    if wrongAnswerCount < 3 then
        return "Calm"
    elseif wrongAnswerCount < MAX_WRONG_BEFORE_SKIP then
        return "Worried"
    else
        return "Skip"
    end
end

local function HandleWrongAnswer()
    local currentTime = tick()
    
    -- Global Cooldown Check
    if (currentTime - lastWrongMessageTime) < WRONG_ANSWER_COOLDOWN then
        return -- Suppress message due to cooldown
    end
    
    lastWrongMessageTime = currentTime
    wrongAnswerCount = wrongAnswerCount + 1
    
    local stage = GetFilterStage()
    filterStage = stage
    
    local message = ""
    
    if stage == "Calm" then
        message = "Someone got it wrong! Don't worry, keep trying."
    elseif stage == "Worried" then
        message = "Too many wrong answers! The system is getting worried..."
    elseif stage == "Skip" then
        message = "Skipping question due to excessive wrong answers!"
        -- Logic to skip question would go here
        NextQuestion(true) -- Force skip
        return
    end
    
    SendMessage(message)
    
    -- Notify UI
    Rayfield:Notify({
        Title = "Wrong Answer (" .. stage .. ")",
        Content = message,
        Duration = 4,
        Image = 40
    })
end

function StartQuiz(quiz)
    isQuizActive = true
    currentQuestionIndex = 0
    wrongAnswerCount = 0
    filterStage = "Calm"
    lastWrongMessageTime = 0
    
    StatusLabel:SetText("Status: Running - " .. quiz.Name)
    
    -- THE REQUESTED NOTIFICATION
    local startMsg = "Starting " .. quiz.Name .. "!"
    SendMessage(startMsg)
    Rayfield:Notify({
        Title = "Quiz Started",
        Content = startMsg,
        Duration = 5,
        Image = 1
    })
    
    NextQuestion()
end

function NextQuestion(forceSkip)
    if not isQuizActive then return end
    
    if forceSkip then
        wrongAnswerCount = 0 -- Reset count on skip
        filterStage = "Calm"
    end
    
    currentQuestionIndex = currentQuestionIndex + 1
    
    if currentQuestionIndex > #currentQuiz.Questions then
        EndQuiz()
        return
    end
    
    local qData = currentQuiz.Questions[currentQuestionIndex]
    
    -- Update UI to show question (In a real implementation, you'd update buttons/text here)
    StatusLabel:SetText("Question " .. currentQuestionIndex .. "/" .. #currentQuiz.Questions)
    
    Rayfield:Notify({
        Title = "New Question",
        Content = qData.Question,
        Duration = 10,
        Image = 10
    })
    
    -- Here you would normally enable answer buttons in the UI
    -- For this script structure, we assume the UI handles button clicks calling CheckAnswer()
end

function CheckAnswer(answerIndex)
    if not isQuizActive then return end
    
    local qData = currentQuiz.Questions[currentQuestionIndex]
    
    if answerIndex == qData.Correct then
        -- Correct
        Rayfield:Notify({
            Title = "Correct!",
            Content = "Great job!",
            Duration = 3,
            Image = 18
        })
        NextQuestion()
    else
        -- Wrong
        HandleWrongAnswer()
    end
end

function EndQuiz()
    isQuizActive = false
    currentQuiz = nil
    StatusLabel:SetText("Status: Completed")
    
    SendMessage("Quiz Completed!")
    Rayfield:Notify({
        Title = "Quiz Finished",
        Content = "Thanks for playing!",
        Duration = 5,
        Image = 24
    })
end

-- Mocking Answer Buttons for the UI (You would connect these to your actual UI buttons)
-- Since we removed the custom tab, we assume the main quiz interface exists elsewhere or 
-- this script is meant to be the backend logic connected to existing GUI buttons.
-- If you need buttons generated here, let me know, but usually, quiz scripts rely on 
-- the place's existing GUI or a dedicated screenGui.

-- For demonstration, adding a dummy section to simulate answer checking if needed
MainTab:CreateParagraph({
    Title = "Control Panel",
    Content = "Use the Start button above. Answer checking is integrated into the game logic."
})

print("Quiz System " .. QUIZ_VERSION .. " Loaded Successfully")
print("Features: Calm/Worried/Skip Filter, 3s Cooldown, No Custom Tab")
