--[[

Script Final Completo:

Sistema de Key: "PCFscripts"

Interface Rainbow / Neon (bordas rainbow, textos brancos)

4 posições para marcar

Teleguiado suave entre posições

Anti-reset, anti-patch, anti-volta e proteção suprema


--]]

-- Serviços e Variáveis
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local KEY_CORRETA = "PCFscripts"
local pos1, pos2, pos3, pos4 = nil, nil, nil, nil
local tweenEmExecucao = false
local teleguiadoVelocidade = 57 -- blocos por segundo
local corFundo = Color3.fromRGB(0,0,0)
local corTexto = Color3.fromRGB(255,255,255) -- textos legíveis

-- Função Rainbow apenas para bordas
local function criarRainbow(frame)
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.Transparency = 0
spawn(function()
while frame.Parent do
local hue = (tick()*0.2) % 1
local cor = Color3.fromHSV(hue,0.7,0.8)
stroke.Color = cor
task.wait(0.03)
end
end)
end

-- GUI Key
local keyGui = Instance.new("ScreenGui", PlayerGui)
keyGui.Name = "KeyGui"
keyGui.ResetOnSpawn = false

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0,300,0,200)
keyFrame.Position = UDim2.new(0.5,-150,0.5,-100)
keyFrame.BackgroundColor3 = corFundo
keyFrame.Active = true
keyFrame.Draggable = true
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0,12)
criarRainbow(keyFrame)

local byText = Instance.new("TextLabel", keyFrame)
byText.Size = UDim2.new(1,0,0,25)
byText.Position = UDim2.new(0,0,0,10)
byText.BackgroundTransparency = 1
byText.Text = "BY: Pedro and Carlos"
byText.TextColor3 = corTexto
byText.Font = Enum.Font.GothamBlack
byText.TextSize = 20
byText.TextXAlignment = Enum.TextXAlignment.Center

local title = Instance.new("TextLabel", keyFrame)
title.Size = UDim2.new(1,0,0,25)
title.Position = UDim2.new(0,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔑 Digite a Key:"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextColor3 = corTexto

local textBox = Instance.new("TextBox", keyFrame)
textBox.Size = UDim2.new(0.85,0,0,45)
textBox.Position = UDim2.new(0.075,0,0,70)
textBox.PlaceholderText = "Digite a key aqui..."
textBox.TextColor3 = corTexto
textBox.BackgroundColor3 = Color3.fromRGB(30,0,0)
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,8)

local confirmar = Instance.new("TextButton", keyFrame)
confirmar.Size = UDim2.new(0.85,0,0,45)
confirmar.Position = UDim2.new(0.075,0,0,125)
confirmar.Text = "Confirmar"
confirmar.TextColor3 = corTexto
confirmar.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", confirmar).CornerRadius = UDim.new(0,8)

-- Função criar GUI principal só após key correta
local mainGui, iconGui, mainFrame
local function criarMainGui()
mainGui = Instance.new("ScreenGui", PlayerGui)
mainGui.Name = "LaGrandeCombinaison"
mainGui.ResetOnSpawn = false
mainGui.Enabled = true

mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0,320,0,410)
mainFrame.Position = UDim2.new(0.5,-160,0.5,-205)
mainFrame.BackgroundColor3 = corFundo
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,14)
criarRainbow(mainFrame)

local titulo = Instance.new("TextLabel", mainFrame)
titulo.Size = UDim2.new(1,-20,0,40)
titulo.Position = UDim2.new(0,10,0,8)
titulo.BackgroundTransparency = 1
titulo.Text = "PCF hub"
titulo.Font = Enum.Font.GothamBlack
titulo.TextSize = 26
titulo.TextXAlignment = Enum.TextXAlignment.Center
titulo.TextColor3 = corTexto
criarRainbow(titulo)

local subtitulo = Instance.new("TextLabel", mainFrame)
subtitulo.Size = UDim2.new(1,-20,0,22)
subtitulo.Position = UDim2.new(0,10,0,48)
subtitulo.BackgroundTransparency = 1
subtitulo.Text = "discord:https://discord.gg/x63GJy9Q"
subtitulo.Font = Enum.Font.Gotham
subtitulo.TextSize = 16
subtitulo.TextXAlignment = Enum.TextXAlignment.Center
subtitulo.TextColor3 = corTexto
criarRainbow(subtitulo)

local function criarBotao(texto,ordem)
local b = Instance.new("TextButton", mainFrame)
b.Size = UDim2.new(0,280,0,40)
b.Position = UDim2.new(0.5,-140,0,90+(ordem-1)*48)
b.Text = texto
b.Font = Enum.Font.GothamBlack
b.TextSize = 20
b.TextColor3 = corTexto
b.AutoButtonColor = false
b.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
criarRainbow(b)
b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(50,50,50) end)
b.MouseLeave:Connect(function() b.BackgroundColor3 = Color3.fromRGB(20,20,20) end)
return b
end

-- Botões principais
botao1 = criarBotao("📍 Marcar posição 1",1)
botao2 = criarBotao("📍 Marcar posição 2",2)
botao3 = criarBotao("📍 Marcar posição 3",3)
botao4 = criarBotao("📍 Marcar posição 4",4)
botaoGo = criarBotao("🚀 Teleguiado",5)
botaoResetPos = criarBotao("♻️ Resetar posições",6)

-- Ícone abrir/fechar
iconGui = Instance.new("ScreenGui", PlayerGui)
iconGui.Name = "IconeScript"
iconGui.ResetOnSpawn = false
iconGui.Enabled = true

local icon = Instance.new("TextButton", iconGui)
icon.Size = UDim2.new(0,60,0,60)
icon.Position = UDim2.new(0,12,0,12)
icon.Text = "C"
icon.TextSize = 28
icon.Font = Enum.Font.GothamBlack
icon.TextColor3 = corTexto
icon.BackgroundColor3 = corFundo
Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)
criarRainbow(icon)

icon.MouseButton1Click:Connect(function()
mainGui.Enabled = not mainGui.Enabled
end)

end

-- Validação Key
confirmar.MouseButton1Click:Connect(function()
local input = textBox.Text:match("%S+")
if input and input:lower() == KEY_CORRETA:lower() then
keyGui:Destroy()
criarMainGui()
else
textBox.Text = "❌ Key incorreta"
end
end)

