require("Candle")

NUMCANDLES = 9
FLAMEWIDTH = 32
FLAMEHEIGHT = 32
NAME = "Zachary"

function love.load()
	background = love.graphics.newImage("cake.png")
	flame = love.graphics.newImage("flame.png")

	-- initialize the candle objects with the flame locations
	candles = {
		Candle:new(324, 300),
		Candle:new(352, 298),
		Candle:new(386, 296),
		Candle:new(415, 303),
		Candle:new(435, 315),
		Candle:new(405, 330),
		Candle:new(372, 335),
		Candle:new(335, 330),
		Candle:new(308, 316)
	}
	litCandles = NUMCANDLES

	love.graphics.setNewFont("LinBiolinum_R.otf", 50)
	
	-- streaming the file caused love to hang for some reason, hence "static"
	tune = love.audio.newSource("birthday.ogg", "static")
end

function love.update()
	-- when the candles are all blown out, play the birthday tune
	if litCandles == 0 then
		love.audio.play(tune)
	end
end

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(background)



	-- draw the flames for any candles still lit
	for i in pairs(candles) do
		if candles[i]:isLit() then
			love.graphics.draw(flame, candles[i].x, candles[i].y)
		end
	end
	
	-- print a message
	love.graphics.setColor(0, 0, 0, 255)
	if litCandles > 0 then
		love.graphics.printf("Blow out the candles!", 0, 150, 800, "center")
	else
		love.graphics.printf("Happy Birthday " .. NAME .. "!", 0, 150, 800, "center")
	end
end

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
end

function love.mousepressed(x, y)
	-- check if the user clicked on a candle flame
	blowCandle(x, y)
end

function blowCandle(x, y)
	for i in pairs(candles) do
		if candles[i]:isLit() then
			if x - candles[i].x >= 0 and x - candles[i].x <= FLAMEWIDTH and
			y - candles[i].y >= 0 and y - candles[i].y <= FLAMEHEIGHT then
				candles[i].lit = false
				litCandles = litCandles - 1
			end
		end
	end
end
