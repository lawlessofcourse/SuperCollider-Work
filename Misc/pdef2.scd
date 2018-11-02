(
SynthDef.new(\sine,{
	arg freq = 440, atk = 0.005, rel = 0.3, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]),doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0,sig!2);
}).add;
)

(
SynthDef(\bassNoise, {
	arg freq = 50, amp = 1, len = 1, freqM = 1, rate1 = 0.2,atk = 0.005, rel = 0.3;
	var sig, sig2, masterSig, env, env2;

	env = EnvGen.kr(Env.new([0,1,0], [atk, rel],[1,-1]), doneAction:2);
/*	sig = SinOsc.ar(
		Vibrato.kr(
			freq:DC.ar(env2*2),
			rate:2,
			depth:0.2,
			delay:1,
			onset: 0,
			rateVariation: 0.04,
			depthVariation: 0.1
	)*Saw.ar(60, 0.7), mul: env);*/
	sig = RLPF.ar(Saw.ar(freq, mul: amp), 300);
	//sig = FreeVerb.ar(sig, 0.33, 0.5, 0.5);
	sig = sig*env;


	Out.ar(0, sig!2);
}).add;
)

(
	p = Pbind(
	\instrument, \sine,
	\dur, Pseq([0.5, 0.5, 0.5], inf),
	\midinote, Pseq([80, 60, 55], inf),
).play;
)
b = Pbind(
	\instrument, \bassNoise,
	\dur, Pseq([0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25], inf),
	\freq, Pseq([80, 60, 90, 50, 60, 70, 70, 65], inf),
).play;
)