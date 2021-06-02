//FM
(
SynthDef(\fm,{|carrfreq = 440 , modfreq=100 , moddepth = 700, amp = 0.6|
	var env , fm1;
	env = EnvGen.kr(Env.perc); //(envelope  για short ηχο)
	fm1 = SinOsc.ar( SinOsc.ar(carrfreq,modfreq,moddepth), 0, amp);//FM Systhesis(modulation την συχνοτητα )
	Out.ar([0,1],env*fm1)
}).play;
)

//RING
(
k = SynthDef(\ring,{|freq = 880 , freqS = 330 , amp = 0.4|
	var env , sod;
	env =  EnvGen.kr(Env.perc);
	sod = SinOsc.ar(freq , 0 , amp) * Saw.ar(freqS , amp); //(πολλαπλασιασμος απευθειας oscillators ταλαντωτων )
	Out.ar(0,env*sod)
}).play;
)
k.free;


//RING
(
SynthDef(\ring2 , {| freq = 440 , amp = 0.6|
	var env , sod ;
	env = EnvGen.ar(Env.adsr); //(envelope για sustained ηχο)
	sod = Saw.ar(freq , amp) * LFNoise2.ar(660 , 0 , 0.4); //(πολλαπλασιασμος απευθειας oscillators ταλαντωτων )
	Out.ar([0,1] , env*sod)
}).play;
)


//ring
(
SynthDef(\ring2,{|freq = 560 , amp = 0.6|
	var env , ring2;
	env = EnvGen.kr(Env.circle([1,0,1] , [0.4 , 0.6 ,0.8]));//(envelope για sustained ηχο)
	ring2 = SinOsc.ar(freq , amp)* LFNoise2.ar(XLine.kr(500, 14000, 5), 0.35);//(πολλαπλασιασμος απευθειας oscillators ταλαντωτων )
	Out.ar([0.1],env*ring2)
}).play;
)
//fm
(
SynthDef(\fm2,{|carrfreq = 900 , moddepth = 4000|
	var env , sodfm;
	env = EnvGen.kr(Env.perc);
	sodfm = SinOsc.ar(Saw.ar(carrfreq , moddepth),0,0.5);//FM(modulation την συχνοτητα )
	Out.ar([0,1],env*sodfm)
}).play;
)

//ph
(
SynthDef(\ph1 , {
	var env , sdph;
	env = EnvGen.kr(Env.dadsr);
	sdph = Impulse.ar(660, SinOsc.ar(440,0,0.4),0.25);//phase (modulation τη φάση)
	Out.ar(0 , env*sdph)
}).play;
)


//fm
(
SynthDef(\fm3 ,{|carrfreq = 700 , modfreq = 1000, amp = 0.4|
	var env , sdfm;
	env = EnvGen.kr(Env.adsr(0.2 ,0.8));
	sdfm = Pulse.ar(LPF.ar(Saw.ar(carrfreq , modfreq)),0.4 , amp);//FM(modulation την συχνοτητα )
	Out.ar([0,1] , env*sdfm)
}).play;
)

//fm-''Like A firework''
(
SynthDef(\am3 , {|carrfreq =880 ,modfreq =0.7 , moddepth =0.7, numharm = 500 , amp =0.7 |
	var env , sdam;
	env = EnvGen.kr(Env.adsr);
	sdam = Blip.ar(LFNoise2.ar(carrfreq , modfreq , moddepth),numharm,amp);//FM(modulation την συχνοτητα )
	Out.ar([0,1],env*sdam)
}).play;
)

//ph
(
SynthDef(\ph2 , {|freq = 440|
	var env , sdph2;
	env = EnvGen.kr(Env.circle([1,2,3,4,5,6,7,8,9],[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]));
	sdph2 = SinOsc.ar(freq , (Lag.ar(0.9 , 0.7 , 0.6)),0.4);//ph(modulation την φαση)
	Out.ar([0,1],env*sdph2)
}).play;
)

//Am
(
SynthDef(\fm , {|freq = 440 , decayt = 0.4 , amp = 0.6|
	var env , sdfm ;
	env = EnvGen.kr(Env.adsr);
	sdfm = Ringz.ar(PinkNoise.ar(0.2),freq,decayt ,SinOsc.ar(XLine.kr(6000,100 , 10),0,amp));//MODULATION την ένταση
	Out.ar([0,1] , env*sdfm)
}).play;
)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


b = Buffer.alloc(s, 512, 1, { |buf| buf.sine1Msg(0.1/[1,2,3,4,5])}); //Buffer(sine1)

(
SynthDef(\bf1 ,{|freq = 440 , amp = 0.5|
	var env , sd;
	env = EnvGen.kr(Env.perc);
	sd = Shaper.ar(b , SinOsc.ar(freq, 0, Saw.ar(220,0.4))+WhiteNoise.ar(0.1), amp);//read buffer
	Out.ar([0,1],env*sd)
}).play;
)

b.free;

b = Buffer.alloc(s , 512 , 1 , { |buf| buf.sine2Msg([200,1000],[4,0.5])});//buffer (sine2)

(
SynthDef(\bf2 , { |freq = 660 , amp = 0.7|
	var env , sdbf3;
	env = EnvGen.kr(Env.adsr);
	sdbf3 = Shaper.ar(b , SinOsc.ar(Pulse.ar(freq , 0.6 , amp),0,0.4));
	Out.ar([0,1],env*sdbf3)
}).play;
)

b.free;


b = Buffer.alloc(s , 512 , 1 ,{ |buf| buf.sine1Msg(0.4/[0.1,0.4,0.6,0.7,0.5])});//(Buffer sine1)

(
SynthDef(\bf3 , {|freq = 320 , amp = 0.7|
	var env , sd3;
	env = EnvGen.kr(Env.perc(0.3,0.6));
	sd3 = Shaper.ar(b , FreeVerb.ar(Decay.ar(SinOsc.ar(freq),0.4,LFCub.ar(500 ,0 , 0.3)),0.5,0.7,0.6));
	Out.ar([0,1],env*sd3)
}).play;
)

(
b = Buffer.alloc(s , 512 , 1 ,{|buf| buf.chebyMsg([1,1,0,1,0,0])}); //(Buffer cheby)
SynthDef(\bf4 , {
	var env , sd4 ;
	env = EnvGen.kr(Env.circle([1,2,3,4,5],[1,2,1,5,0.5]));
	sd4 = Shaper .ar(b , LFCub.ar(350 , 0 , Line.kr(0,0.9,4)),0.5);
	Out.ar([0,1],env*sd4)
}).play;
)

b = Buffer.alloc(s , 512 , 1 , {|buf| buf.sine3Msg([20,40,60],[0.4,0.6,0.7])});//(buffer sine3)
(
SynthDef(\bf5 , { |freq = 300 , amp = 0.7|
	var env , sd5 ;
	env = EnvGen.kr(Env.adsr);
	sd5 = Shaper.ar(b ,(SinOsc.ar(freq, Saw.ar(XLine.kr(5, 3000, 9), pi), amp)));
	Out.ar([0],env*sd5)
}).play;
)



~sig = Signal.sineFill(1025, [1,2,3,4,5] , [1,0.5,0.1,6,0.8]);//signal
~sig.asWavetableNoWrap;//wavetable message
~sig.size;//size of buff
~table = Buffer.loadCollection(s,~sig);

(
SynthDef(\wv1 , {|freq = 440 , amp = 0.4|
	var env , wv;
	env = EnvGen.kr(Env.perc);
	wv =  Shaper.ar(~table , Saw.ar(SinOsc.ar(freq,0,0.02),amp ));
	Out.ar([0,1],env*wv)
}).play;
)


~sig = Signal.sineFill(512 , [0.4,0.9,5] , [1,0.4,0.07]);//signal
~sig.asWavetableNoWrap;
~sig.size;
~table = Buffer.loadCollection(s , ~sig);

(
SynthDef(\wv2 , {|freq = 800 , amp = 0.3|
	var env , wv2;
	env = EnvGen.kr(Env.adsr(0.5 , 0.2));
	wv2 = Shaper.ar(~table , Impulse.ar(MouseX.kr(100 , 6000) , 0 ,MouseY.kr(0.1 ,1 )));
		Out.ar([0,1],env*wv2)
}).play;
)

Env([0.4,0.1,0.9], [0.5,0.5] , [4 , -4]);//env instead signal
~tables = Env([0.4,0.1,0.9] , [0.5,0.5] , [4,-4]).asSignal(1025);
~tables = ~tables.asWavetableNoWrap;
~tableB = Buffer.loadCollection(s , ~tables);//load buuf
(
SynthDef(\wv3 ,{
	var env , wv3;
	env = EnvGen.kr(Env.asr);
	wv3 = Shaper.ar(~tableB ,LFNoise2.ar(440 , XLine.kr(100,500),0.04));
	Out.ar([0,1] , env*wv3)
}).play
)


~sig = Signal.sineFill(1024 , [0.3,0.4,2 , 4] , [0.1,0.4,0.09,0.36]);//signal
~sig.asWavetableNoWrap;
~sig.size;
~table = Buffer.loadCollection(s , ~sig);//load buff

(
SynthDef(\wv4 ,{
	var env , wv4;
	env = EnvGen.kr(Env.adsr);
	wv4 = Shaper.ar(~table ,Ringz.ar(Dust.ar(2.5 , 0.4),XLine.kr(100 , 2000 , 6,0.4) , 0.4 , 0.6));
	Out.ar([0,1] , env*wv4)
}).play
)


Env([0.7,0.06,0.4,0.012,0.7], [1,1] , [-5 , 5]).plot;//env instead signal
~tables2 = Env([0.7,0.06,0.4,0.012,0.7] , [1,1] , [-5,5]).asSignal(1025);
~tables2 = ~tables2.asWavetableNoWrap;
~tableBuf = Buffer.loadCollection(s , ~tables2);
(
SynthDef(\wv5 ,{
	var env , wv5;
	env = EnvGen.kr(Env.adsr);
	wv5 = Shaper.ar(~tableBuf ,Impulse.ar(880 , 0 , 0.4 ) + SinOsc.ar(XLine.kr(70 , 10000,11),0.3));
	Out.ar([0,1] , env*wv5)
}).play
)




