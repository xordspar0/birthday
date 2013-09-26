require("Candle")

NUMCANDLES = 6
FLAMEWIDTH = 32
FLAMEHEIGHT = 32

function love.load()
	background = love.graphics.newImage("backgroud.png")
	flame = love.graphics.newImage("flame.png")

	-- initialize the candle objects with the flame locations
	candles = {
		Candle:new(245, 270),
		Candle:new(290, 255),
		Candle:new(320, 275),
		Candle:new(350, 260),
		Candle:new(370, 275),
		Candle:new(400, 260)
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
		love.graphics.printf("Happy Birthday!", 0, 150, 800, "center")
	end
end

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
end

function love.mousepressed(x, y)
	-- check if the user clicked on a candle flame
	for i in pairs(candles) do
		if candles[i]:isLit() then
			-- note: candle flames are 32px by 32px
			if x - candles[i].x >= 0 and x - candles[i].x <= FLAMEWIDTH and
			y - candles[i].y >= 0 and y - candles[i].y <= FLAMEHEIGHT then
				candles[i].lit = false
				litCandles = litCandles - 1
			end
		end
	end
end
