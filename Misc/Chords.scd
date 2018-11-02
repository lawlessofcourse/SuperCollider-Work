(
SynthDef(\chords, {
	arg freq = 440, amp = 0.707, gate = 1, sustain = 1, modFreq =600, rate = 6, depth = 0.02;
	var sig, env, sig2, masterSig;

	// env = Env.adsr(0.01*sustain, 0.2*sustain, amp*0.707, 0.2*sustain);
	env = Env.new([0,1,1, 0]*amp,[1,2, 1]*0.5, 'sqr' );

	env = EnvGen.kr(env, gate, amp, doneAction: 0);

	sig = RLPF.ar(Saw.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env), modFreq, rq: 0.5);
	// sig = sig*Vibrato.ar(DC.ar(modFreq), rate, depth);




	sig2 = DelayC.ar(sig, 2,1,0.5);

	sig = Limiter.ar(sig, 0.5);

	sig2 = Limiter.ar(sig2, 0.5);
	//sig = sig*env;

	masterSig = Pan2.ar([sig,sig2], 0);

	Out.ar(0, masterSig);

}).add;
Pdef(\higher).play;
)
Pdef(\yeahBass).play;

(
SynthDef(\bassNoise, {
	arg freq = 110, amp = 0.707, gate = 1, sustain = 1, modFreq =174.61, rate = 0.25, depth = 0.05;
	var sig, env;

	env = Env.adsr(0.01*sustain, 0.3*sustain, amp*0.707, 0.5*sustain);

	env = EnvGen.kr(env, gate, amp, doneAction: 2);

	sig = RLPF.ar(Saw.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env), modFreq, rq: 0.5);
	// sig = sig*Vibrato.ar(DC.ar(modFreq), rate, depth);


	sig = Pan2.ar(sig, 0);

	sig = Limiter.ar(sig, 0.707);


	//sig = sig*env;

	Out.ar(0, sig);
}).play;
)
(
Pdef(\higher,
	Pbind(
		\instrument, \chords,
		\freq, Pseq([440, 392,  349.88], inf),
		\dur, Pseq([2, 2,  2],inf),
		\db, 0,
		//\sustain, 1,
		\modFreq, Pseq([880, 783.99, 987.77, 698.46], inf),
		\test, Pfunc({|ev| ~der = ev})
	)
)
)

(
Pdef(\yeahBass,
	Pbind(
		\instrument, \bassNoise,
		\freq, Pseq([55, 48.999, 61.735]*2, inf),
		\dur, Pseq([8, 4, 4],inf),
		\db, 0,
		// \sustain, 10,
		\modFreq, Pseq([110, 174.61, 220, 146.83]*2, inf),
		\test, Pfunc({|ev| ~der = ev})
	)
)
)
Pdef(\higher).play;
Pdef(\yeahBass).play;
Pdef(\freq, Pseq([2, 2, 1], inf));