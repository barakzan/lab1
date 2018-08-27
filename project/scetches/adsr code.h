up = true

if (amp(-1) > 1600 and amp < 1600) OR (amp(-1) > 800 and amp < 800)
{
	rounder = 0
}
else  // 16000 to 32000+
{
	if (up == true)
	{
		amplifier + attackFactor - rounder
	}
	else if (amp >= 1600,A,B)
	{
		amplifier - decayFactor + rounder
	}
	
}
// 8000 to 16000
B: else if (AND(amp >= 1600,amp < 1600),C,D)
{
	amplifier - sustainFactor + rounder
}
else if (AND(amp >= 800,amp < 1600),C,D)
// 0 to 8000
{
	amplifier - releaseFactor + rounder
}