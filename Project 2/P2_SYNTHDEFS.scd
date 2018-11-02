(
SynthDef(\chords, {
	arg freq = 440, amp = 0.707, gate = 1, sustain = 1, modFreq =600, rate = 6, depth = 0.02;
	var sig, env, sig2, masterSig, combDelay;

	// env = Env.adsr(0.01*sustain, 0.2*sustain, amp*0.707, 0.2*sustain);
	env = Env.new([0,1,1, 0]*amp,[1,2, 1]*0.5, 'sqr' );

	env = EnvGen.kr(env, gate, amp, doneAction: 0);

	sig = RLPF.ar(Saw.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env), modFreq, rq: 0.5);
	// sig = sig*Vibrato.ar(DC.ar(modFreq), rate, depth);






	sig = Limiter.ar(sig, 0.5);


	//sig = sig*env;

	sig = Pan2.ar(sig, 0);


	Out.ar(0, sig);

}).add;
)


(
SynthDef(\bassNoise, {
	arg freq = 55, amp = 0.707, gate = 1, sustain = 1, modFreq = 440, rate = 0.75, depth = 0.05;
	var sig, env, rateEnv;

	env = Env.adsr(0.01*sustain, 0.3*sustain, amp*0.707, 0.5*sustain);

	env = EnvGen.kr(env, gate, amp, doneAction: 2);

	rateEnv = EnvGen.kr(Env.new([0.25, 0.5,  0.5, 1, 1, 2, 2, 4, 4, 6, 6],
		                        [     1,   2,    1, 2, 1, 4, 1, 4, 1, 4 ], curve: 'lin'));
	sig = RLPF.ar(Saw.ar(Vibrato.kr(DC.ar(freq), rateEnv, depth), mul: env), modFreq, rq: 0.5);
	// sig = sig*Vibrato.ar(DC.ar(modFreq), rate, depth);
	//sig =Saw.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env);

	sig = Pan2.ar(sig, 0);

	sig = Limiter.ar(sig, 0.707);

	sig = sig*Crackle.kr(0.1, amp);
	//sig = sig*env;

	Out.ar(0, sig);
}).play;
)
(
SynthDef(\synthy, {
	arg freq = 440, amp = 0.707, gate = 1, sustain = 1, modFreq = 880, rate = 2, depth = 0.25;
	var sig, env, sig2, masterSig;
	env = Env.adsr(0.01*sustain, 0.2*sustain, amp*0.707, 0.2*sustain);


	env = EnvGen.kr(env, gate, amp, doneAction: 0);

	sig = RLPF.ar(Saw.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env), modFreq, rq: 0.5);
	// sig = sig*Vibrato.ar(DC.ar(modFreq), rate, depth);

	sig2 = RLPF.ar(SinOsc.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env), modFreq, rq: 0.5);


	masterSig = Pan2.ar(Mix.new([sig, sig2]), 0);
	//masterSig = FreeVerb.ar(masterSig, 0.2, mul: amp);
	masterSig = Limiter.ar(masterSig, amp);

	Out.ar(0, masterSig);

}).add;
)
{SinOsc.ar( 110)*Crackle.kr(1.5, 0.5) }.play;

(SynthDef(\wubs2, {
	arg  freq = 110, inSigFreq = 440, freqA =698.46, freqB = 43.625, freqDur = 10, vRate = 2, vDepth= 2, amp = 0.707;
	var sig, mod, sig2, outSig, sig1, sigMix, env;

	//env = EnvGen.kr(Env.new([0,0.7,0.7,0], [5, 20, 5], 'sqr', 2));
	//env = XLine.kr(0.01, 1, 2);
	freq = XLine.kr(freqA, freqB, freqDur, doneAction: 0);

	mod = Vibrato.kr(DC.ar(1), rate: vRate, depth:vDepth, delay:2, onset:3, rateVariation: 0.0, depthVariation:0);

	sig1= SinOsc.ar(freq, 0.1, mul: amp);

	sig2 = Saw.ar(freq, 0.1, mul:amp);

	sigMix = Mix.new([sig1, sig2]);
	sigMix = sigMix*mod;

	sig = RLPF.ar(
		in: sigMix,
		freq: XLine.kr(8000,1000,freqDur),
		rq: 0.05,
		mul: amp//XLine.kr(1, 0.01, 20, amp, doneAction: 2),
	);

	sig = FreeVerb.ar(sig, mix: 0.33, room:0.5, mul: 0.2);
	sig = Pan2.ar(sig, 0);
	sig = Limiter.ar(sig, 0.7);

	Out.ar(0, sig);
}).add;
)
Synth(\wubs2);


(SynthDef(\beaut, {
	arg  freq = 110, freqDur = 15, vRate = 6, vDepth= 0.2, amp = 0.707, filterFreq = 0;
	var sig, mod, sig2, outSig, sig1, sigMix, env;

	//env = EnvGen.kr(Env.new([0,0.7,0.7,0], [5, 20, 5], 'sqr', 2));
	//env = XLine.kr(0.01, 1, 2);
	//freq = XLine.kr(freqA, freqB, freqDur, doneAction: 0);
env =	XLine.kr(1, 0.01, 30, doneAction: 1);
	filterFreq = XLine.kr(8000, 440 ,freqDur);
	mod = Vibrato.kr(DC.ar(1), rate: vRate, depth:vDepth);

	sig1= SinOsc.ar(freq, 0.1, mul: amp);

	sig2 = Saw.ar(freq, 0.1, mul:amp);

	sigMix = Mix.new([sig1, sig2]);
	sigMix = sigMix*mod;

	sig = RLPF.ar(
		in: sigMix,
		freq: filterFreq,
		rq: 0.05,
		mul: env
	);

	sig = FreeVerb.ar(sig, mix: 0.33, room:0.5, mul: amp);
	sig = Pan2.ar(sig, 0);
	sig = Limiter.ar(sig, 0.7);

	Out.ar(0, sig);
}).play;
)
Synth(\beaut);
(SynthDef(\wubs3, {
	arg  freq = 87.307, freqDur = 15, vRate = 3, vDepth= 0.09, amp = 0.707, filterFreq = 0;
	var sig, mod, sig2, outSig, sig1, sigMix, env;

	env = Env.new([0.01,1,1,0.01], [0.1, 1.8, 0.1], 'lin');
	env = EnvGen.kr(env);
	//env = XLine.kr(0.01, 1, 2);
	//freq = XLine.kr(freqA, freqB, freqDur, doneAction: 0);
	//filterFreq = XLine.kr(8000, 440 ,freqDur);
	filterFreq = ((freq*2)*2);
	mod = Vibrato.kr(DC.ar(1), rate: vRate, depth:vDepth);

	sig1= SinOsc.ar(freq, 0.1, mul: amp);

	sig2 = Saw.ar(freq, 0.1, mul:amp);

	sigMix = Mix.new([sig1, sig2]);
	sigMix = sigMix*mod;

	sig = RLPF.ar(
		in: sigMix,
		freq: filterFreq,
		rq: 0.05,
		mul: env,
	);

	sig = FreeVerb.ar(sig, mix: 0.33, room:0.5, mul: env);
	sig = Pan2.ar(sig, 0);
	sig = Limiter.ar(sig, 0.7);

	Out.ar(0, sig);
}).add;
)
(
Pdef(\wubalub,
	Pbind(
		\instrument, \wubs3,
		\freq, Pseq([87.307, 82.407, 73.416], inf),
		\dur, Pseq([4.5, 4.5, 4.5], inf),
		\db, -12,
		\vDepth,Pdef(\depth, 0.8),
		\vRate, Pdef(\rate, 6),
	)
)
)
Pdef(\wubalub).play;
Pdef(\depth, 0.8);
Pdef(\rate, 10);

(SynthDef(\buildUp, {
	var env, sig, sig2, outSig;
	env = EnvGen.kr(Env.new([0,1,1,0], [2, 10, 3]));
	sig = RLPF.ar(
		in: Saw.ar(XLine.kr(50, 200, 10),0.1),
		freq: XLine.kr(8000,400,5),
		rq: 0.05,
		mul: env
	);
	sig2 = RLPF.ar(
		in: Saw.ar(XLine.kr(start: 40, end: 150, dur: 10), 0.1),
		freq: SinOsc.ar(XLine.kr(0.7, 300, 20), 0, 3600, 4000),
		mul: env
	);
	outSig = Mix.new([sig, sig2]);
	outSig= Limiter.ar(outSig, 1);
	Out.ar(0, outSig!2);
}).play;
)


















