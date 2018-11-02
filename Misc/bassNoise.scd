(
SynthDef(\yeah,{
	arg freq = 440, amp = 0.707, gate = 1, sustain = 1, modFreq = 20;
	var sig, env;

	env = Env.adsr(0.01*sustain, 0.3*sustain, amp*0.5, 0.5*sustain);
	env = EnvGen.kr(env, gate, amp, doneAction: 2);

	sig = SinOsc.ar(freq, mul: env);
	sig = sig * SinOsc.ar(modFreq).linlin(-1,1,0,1);

	sig = Pan2.ar(sig, 0);

	Out.ar(0,sig);
}).add;
)

(
a = Pbind(
	\instrument, \yeah,
	\note, Pseq([0, 0, 7, 7, 9, 9, 7], inf),
	\dur, Pseq([1,1,1,1,1,1,2],inf),
	\db, -6,
	\sustain, 0.7,
	\modFreq, Prand([2, 20, 60, 120], inf),
	\test, Pfunc({|ev| ~der = ev})


).play;
)
(
Pdef(\yeahPat,
	Pbind(
		\instrument, \yeah,
		\note, Pdef(\notePat, Pseq([0, 0, 7, 7, 9, 9, 7], inf)),
		\dur, Pseq([1,1,1,1,1,1,2],inf),
		\db, -6,
		\sustain, 0.7,
		\modFreq, Prand([2, 20, 60, 120], inf),
		\test, Pfunc({|ev| ~der = ev})
	)
)
)

Pdef(\yeahPat).play;

Pdef(\notePat, Pseq([9, 11, 0], inf));
//vibrato at 1 Hz, note the use of DC.ar UGen; a constant of 400.0 doesn't work
{SinOsc.ar(Vibrato.ar(DC.ar(200.0),1,0.02) )}.play

//compare: k-rate freq input can be a constant
{SinOsc.ar(Vibrato.kr(400.0,1,0.02))}.play

//control rate and rateVariation
{SinOsc.ar(Vibrato.ar(DC.ar(400.0),MouseX.kr(2.0,100.0),0.1,1.0,1.0,MouseY.kr(0.0,1.0),0.1) )}.play

//control depth and depthVariation
{SinOsc.ar(Vibrato.ar(DC.ar(400.0),LFNoise1.kr(1,3,7),MouseX.kr(0.0,1.0),1.0,1.0,MouseY.kr(0.0,1.0),0.1) )}.play
(
SynthDef(\bassNoise, {
	arg freq = 110, amp = 0.707, gate = 1, sustain = 1, modFreq =174.61, rate = 2, depth = 0.2;
	var sig, env;

	env = Env.adsr(0.01*sustain, 0.3*sustain, amp*0.707, 0.5*sustain);

	env = EnvGen.kr(env, gate, amp, doneAction: 2);

	sig = RLPF.ar(Saw.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env), modFreq, rq: 0.5);
	// sig = sig*Vibrato.ar(DC.ar(modFreq), rate, depth);


	sig = Pan2.ar(sig, 0);

	sig = Limiter.ar(sig, 0.707);

	//sig = sig*env;

	Out.ar(0, sig);
}).add;
)
(
Pdef(\yeahBass,
	Pbind(
		\instrument, \bassNoise,
		\freq, Pseq([55, 48.999, 61.735], inf),
		\dur, Pseq([10, 5, 8],inf),
		\db, 0,
		// \sustain, 10,
		\modFreq, Pseq([110, 174.61, 220, 146.83], inf),
		\test, Pfunc({|ev| ~der = ev})
	)
)
)

Pdef(\yeahBass).play;