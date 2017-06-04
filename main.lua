-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- Resumo: Aplicativo teste para aprendizado da linguagem Lua. Tarefa
-- sugerida no grupo PET - LAMIF do IF Sudeste MG - Câmpus Rio Pomba
--
-- Data: 10 de fevereiro de 2013
--
-- Versão: 1.1
--
-- Autor: @Tamtuza
--
-- Demonstrações:
-- 		Demonstra o uso de 'physics' nos objetos.
--		Movimenta objetos com 'physics' através do toque do usuário.
--		Demonstra o uso de áudio em aplicativos.
--
-- Dependências do arquivo:
--
-- Dispositivo alvo: Android
--
-- Limitações:
--
-- Histórico de atualição:
--
-- Comentários: Foi implementado um contador de toques que exibe na tela
-- a quantidade de vezes que os balões foram tocados, mas deixei os códigos
-- comentados pois na versão final do projeto achei o uso desnecessário
--
---------------------------------------------------------------------------------------

--> Permite detectar vários toques na tela ao mesmo tempo
system.activate("multitouch")

--> Adiciona faixa de áudio
local soundFile = audio.loadSound("leekspin.mp3")
audio.play(soundFile, {loops = -1, fadein = 500})

-- local tapCount = 0

local background = display.newImage("background.png")
--> Posiciona a imagem de background no centro da tela
background.x = display.contentCenterX
background.y = display.contentCenterY

local clouds = display.newImageRect("clouds.png", 500, 350)
clouds.x = display.contentCenterX
clouds.y = display.contentCenterY-120

local grass = display.newImageRect("grass.png", 900, 150)
grass.x = display.contentCenterX
grass.y = display.contentHeight+10

--> (Valor a ser exibido, posição X, posição Y, tipo da fonte, tamanho da fonte)
-- local tapText = display.newText(tapCount, display.contentCenterX, 20, native.systemFont, 40)
-- tapText:setFillColor( 0, 0, 0 )

--> Cria paredes para limitar o movimento dos balões à tela
local ceiling = display.newRect(display.contentCenterX, 0, display.contentWidth, 1)
local floor = display.newRect(display.contentCenterX, display.contentHeight, display.contentWidth, 50)
local leftWall = display.newRect(0, display.contentCenterY, 1, display.contentHeight)
local rightWall = display.newRect(display.contentWidth, display.contentCenterY, 1, display.contentHeight)

--> Aplica transparência aos retângulos reduzindo sua opacidade
ceiling.alpha = 0.0
floor.alpha = 0.0
leftWall.alpha = 0.0
rightWall.alpha = 0.0

--> Cria e posiciona os balões
local leftBalloon = display.newImageRect("balloon.png", 75, 100)
leftBalloon.x = display.contentWidth-50
leftBalloon.y = display.contentCenterY

local midBalloon = display.newImageRect("balloon.png", 75, 100)
midBalloon.x = display.contentCenterX
midBalloon.y = display.contentCenterY

local rightBalloon = display.newImageRect("balloon.png", 75, 100)
rightBalloon.x = display.contentWidth-270
rightBalloon.y = display.contentCenterY

--> Inicializa a propriedade física
local physics = require("physics")
physics.start()
--> Valor default (simula gravidade da terra)
physics.setGravity(0, 9.8)

-->  Adiciona física nos elementos necessários
physics.addBody(ceiling, "static")
physics.addBody(floor, "static")
physics.addBody(leftWall, "static")
physics.addBody(rightWall, "static")
physics.addBody(leftBalloon, "dynamic", {{bounce = 0.2, radius = 50, friction = 1.0}})
physics.addBody(midBalloon, "dynamic", {{bounce = 0.3, radius = 50, friction = 1.0}})
physics.addBody(rightBalloon, "dynamic", {{bounce = 0.2, radius = 50, friction = 1.0}})

--> Função que executa movimento do balão após toque do usuário
local function pushBalloon(event)
  local balloon = event.target
  --> Os dois primeiros parâmetros do applyLinearImpulse são as forças
  --> horizontais e verticais (respectivamente) a serem aplicadas no balão.
  --> Os dois últimos indicam as posições onde essa força será aplicada (x,y)
  balloon:applyLinearImpulse( 0.1, -0.75, event.x, event.y)
  -- tapCount = tapCount + 1
  -- tapText.text = tapCount
end

--> Cria evento de interação com toque do usuário
leftBalloon:addEventListener("touch", pushBalloon)
midBalloon:addEventListener("touch", pushBalloon)
rightBalloon:addEventListener("touch", pushBalloon)
