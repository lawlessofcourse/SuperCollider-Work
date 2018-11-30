(
SynthDef(\wubs4, { //freq is at F2 filterFreq is F4
	arg  freq = 87.307, freqDur = 15, vRate = 3, vDepth= 0.9, amp = 0.707, filterFreq = 0,
	mix = 0.33, room = 0.5, bend = 0;

	var sig, mod, sig2, sig1, env;

	filterFreq = ((freq*2)*2);

	env = Env.linen(0.2, 20, 3,  1, 'lin');
	env = EnvGen.kr(env);

	freq = Env.new([220, 220, 261.63, 261.63, 293.67, 293.67, 220, 196,  196 ]/2,
		           [    4,   1,      5,      1,      5,      1,   4,    4 ], 'lin');// 25 total time
	freq = EnvGen.kr(freq, gate: 1, doneAction: 2);

	mod = Vibrato.kr(DC.ar(1), rate: In.kr(~rateBus), depth:vDepth);

	sig1= SinOsc.ar(freq, 0.1, mul: amp);
	sig2 = Saw.ar(freq, 0.1, mul:amp);
	sig1 = RHPF.ar(
		in: sig1,
		freq: filterFreq, // filterFreq is (freq*2)*2
		rq: 0.05,
		mul: mod,
	);sig2 = RLPF.ar(
		in: sig2,
		freq: 293.67, //D4
		rq: 0.05,
		mul: mod,
	);
	sig = Mix.new([sig1, sig2]);
	sig = FreeVerb.ar(sig, mix: mix, room: room, mul: env);
	sig = Pan2.ar(sig, 0);
	sig = Limiter.ar(sig, 0.7);

	Out.ar(0, sig);
}).add.play;
)
(//original wub3 my favorite that I like to derive new sounds from and mess with. Make a copy of this and change it up. DO NOT CHANGE THIS SYNTH IT IS HERE FOR REFERENCE.
SynthDef(\wubs3, {
	arg  freq = 87.307, freqDur = 15, vRate = 3, vDepth= 0.9, amp = 0.707, filterFreq = 0,
	mix = 0.33, room = 0.5, bend = 0;

	var sig, mod, sig2, sig1, env;

	filterFreq = ((freq*2)*2);

	env = Env.linen(0.2, 20, 3,  1, 'lin');
	env = EnvGen.kr(env);

	freq = Env.new([220, 220, 261.63, 261.63, 293.67, 293.67, 220, 196,  196 ]/2,
		           [    4,   1,      5,      1,      5,      1,   4,    4 ], 'lin');// 25 total time
	freq = EnvGen.kr(freq, gate: 1, doneAction: 2);

	mod = Vibrato.kr(DC.ar(1), rate: In.kr(~rateBus), depth:vDepth);

	sig1= SinOsc.ar(freq, 0.1, mul: amp);
	sig2 = Saw.ar(freq, 0.1, mul:amp);
	sig1 = RHPF.ar(
		in: sig1,
		freq: filterFreq,
		rq: 0.05,
		mul: amp,
	);sig2 = RLPF.ar(
		in: sig2,
		freq: 440,
		rq: 0.05,
		mul: amp,
	);
	sig = Mix.new([sig1, sig2]);
	sig = FreeVerb.ar(sig, mix: mix, room: room, mul: env)*mod;
	sig = Pan2.ar(sig, 0);
	sig = Limiter.ar(sig, 0.7);

	Out.ar(0, sig);
}).add;