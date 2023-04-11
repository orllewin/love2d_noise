function rgb(hexColour)
			return {tonumber("0x"..hexColour:sub(2,3))/255, tonumber("0x"..hexColour:sub(4,5))/255, tonumber("0x"..hexColour:sub(6,7))/255, 1}
end

function rgba(hexColour)
			return {tonumber("0x"..hexColour:sub(2,3))/255, tonumber("0x"..hexColour:sub(4,5))/255, tonumber("0x"..hexColour:sub(6,7))/255, tonumber("0x"..hexColour:sub(8,9))/255}
end

function white()
	return 255, 255, 255
end

function whiteAlpha(alpha)
	return 255, 255, 255, alpha
end

function black()
	return 0, 0, 0
end