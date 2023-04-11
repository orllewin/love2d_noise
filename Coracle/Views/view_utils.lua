function inBounds(x, y, vX, vY, vWidth, vHeight)
	return x < vX + vWidth/2 and x > vX - vWidth/2 and y > vY - vHeight/2 and y < vY + vHeight/2
end