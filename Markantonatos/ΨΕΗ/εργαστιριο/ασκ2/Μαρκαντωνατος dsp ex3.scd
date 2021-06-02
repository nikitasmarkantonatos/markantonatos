//echo
(
{CombN.ar(LFNoise2.ar(500.rrand(2000), 0.2) * Line.kr(1, 0,0.1),0.6,0.4,3)}.play;
)

//resonator
{ CombN.ar(Saw.ar(900,0.4), 0.2, Line.kr(0.0001, 0.1, 10), 0.3) }.play;

//reverb
({
	var v , x , a;
	v = Mix.ar(Array.fill(10,{Resonz.ar(Dust.ar(0.9, 20),50 + 3000, 0.008)}));
	x = DelayN.ar(v,0.2);
	a = Mix.ar(Array.fill(10,{CombL.ar(x,0.7,LFNoise1.kr(0.7,0.09,0.09),5)}));

v+(0.2*a)
}.play;
)
