//short ηχος σε SynthDef με μια γεννητρια Saw στα 440 Hz και ενταση 0.7
(
SynthDef(\short1, {|freq = 440 , amp =0.7|
	var env , str;
	env = EnvGen.kr(Env.perc);
	str = Saw.ar(freq , amp);
	Out.ar([0,1],str*env)
}).play;
)
// short ηχος με μια γεννητρια Θορυβου βγαζοντας τον ηχο μονο απο το δεξι ηχειο
(
SynthDef(\short2)
{
	var env , lfn;
	env = EnvGen.kr(Env.perc);
	lfn = LFNoise1.ar(1500,0.7);
	Out.ar([1],env*lfn)
}.play;
)
//short ηχος
(
SynthDef(\short3)
{
	var k, r ,w, t;
	k = SinOsc.ar(660 , 0 ,0.5);
    r = WhiteNoise.ar(0.4);
    w = Saw.ar(XLine.kr(200 , 13000 , 7) , 0.5 ,0.4);
    x = k + r + w;// προσθεση γεννητριων
    t = EnvGen.kr(Env.perc(1, 5));//attack time = 1, release time = 5
	Out.ar([0,1] , t*x)
}.play;
)


//short ηχος
(
SynthDef(\lfnoise4 ,{|freq1 = 880 , amp = 0.6 , freq2 = 900 ,amp2 =0.3|
	var env , lf;
   env =  EnvGen.kr(Env.perc( 0.5, 0.7, 0.2, 0.6,),Impulse.kr(freq2,0,amp2));
	lf = LFNoise2.ar(freq1, amp);//πολλαπλασιασμος με LFNoise
	Out.ar(0, env*lf)
}).play;
)


//Short ηχος
(
SynthDef(\short5 , {|amp = 0.6|
	var env , envel , sour;
	envel = Env.perc(0.4 , 0.7);//attack time ,release time
	env = EnvGen.kr(envel , doneAction:2);
	sour = Mix.fill(10, {SinOsc.ar(XLine.kr(500 , 10000 , 0.7) , 0 ,amp)});// αθροισμα καναλιων σε ενα
	Out.ar(0 , sour * env)
}).play;
)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------//Sustained--------------------------------------------------------------------------------------------
//sustained ηχος

(
SynthDef(\NOIS, { | freq = 880 ,gate = 0, amp = 0.2 | //ενα Synth
	var x = EnvGen.kr(Env.adsr, gate) * (LFNoise0.ar(freq , amp ) + Saw.ar(XLine.kr(500 , 8000,8),0.3));// το Saw χειριζεται ενα XLine που ξεκινά απο τα 500 και σταματα στα 8000 με 8 sec διαρκεια
	Out.ar([0,1], x)
}).add;
)

a = Synth(\NOIS);//το Synth πηγαινει στην μεταβλητη α


// ανοιγμα
a.set(\gate, 1);// Οταν το gate γινεται 1  to synth paizei

// κλεισιμο
a.set(\gate, 0);//Οταν γινεται 0 σταματαει


//sustained ηχος
(
SynthDef(\sustained2, {|freq = 5800, gate = 1, amp = 0.6|
    var env, sour, envel;
	envel = Env([0.7, 0.5, 0.4, 0.6, 0.1, 1.0, 0.4, 0.6], [0.05, 0.1, 0.01, 1.0, 1.5, 0.7, 0.3]);//sustained
    env = EnvGen.kr(envel, doneAction:2);
    sour = SinOsc.ar(freq, 0, amp);
	Out.ar([0,1], sour*env)
}).play;
)


//sustained ηχος
(
SynthDef(\sustained3, {
    var in, chain, chain2,  env, sound;
    in = SinOsc.ar(880, 0, 0.5);
	env = EnvGen.kr(Env.adsr(0.4,0.6), doneAction:2);
    chain = FFT(LocalBuf(2048), in);//δημιουργια buffer
    chain2 = PV_RectComb(chain, WhiteNoise.ar(0.5));//δημιουργια μια σειρα κενον
    sound = (in*env + chain2);
    Out.ar(0, IFFT(sound))
}).play;
)


//sustainrd ηχος
(
SynthDef(\sustained4,{|freq = 550 , amp = 0.6|
			var env , sour , envel;
	env = Env.circle([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,] , [0.01, 0.5, 0.2, 0.4, 0.5 ,0.7, 0.3, 0.5, 0.09, 0.1, 0.4]);//δημιουργει ενα 'κυκλικο' envelope
			envel = EnvGen.kr(env);
			sour = SinOsc.ar(freq+59 , amp);
			Out.ar([0,1],envel*sour)
		}).play;
	)

(
SynthDef(\sustained5 , {|freq = 440 ,amp =0.7|
	var env ,sour , envelope;
	env = Env.adsr([0.5, 0.6, 0.7, 0.2, 0.5],[0.1,0.02,0.9,0.023,0.46]);
	envelope = EnvGen.kr(env,Dust.kr(1));//κοντρολαρει το gate
	sour = SinOsc.ar(freq,0 ,amp);
	Out.ar([0,1],envelope*sour)
}).play;
)


