(
SynthDef(\wubsExperiment, {
	arg  freq = 174.61, freqDur = 15, vRate = 2, vDepth= 0.5, amp = 0.707, filterFreq = 0;
	var sig, mod, sig2, outSig, sig1, sigMix, env;

	//env = Env.new([0.0,    1,   1,    0.0],
	//	          [     0.5,  8,   0.5     ], 'lin');
	//env = EnvGen.kr(env);
	//env = XLine.kr(0.01, 1, 2);
	//freq = XLine.kr(freqA, freqB, freqDur, doneAction: 0);
	//filterFreq = XLine.kr(8000, 440 ,freqDur);
	filterFreq = ((freq*2)*2);
	mod = Vibrato.kr(DC.ar(1), rate: vRate, depth:vDepth);

	sig1= LFTri.ar(LFTri.kr(15, 0, freq/2, freq/2), 0.1, iphase: 0, mul: amp);

	//sig2 = LFSaw.ar(LFSaw.kr(0.06, 2, freq/4, freq/2), mul: mod, add: 0);
	//sig2 = sig2*env;

	//sigMix = Mix.new([ sig2]);
	//sigMix = sigMix*mod;

	sig = RLPF.ar(
		in: sig1,
		freq: filterFreq,
		rq: 0.25,
		mul:amp,
	);

	//sig = DelayC.ar(sig, 2, 2, amp);
	//sig = Resonz.ar(in: sig1, freq: 88, bwr: MouseY.kr(0.001, 20).poll, mul: amp, add: 0.5);

	//sig = FreeVerb.ar(sig, mix: 0.33, room:0.5, mul: env);
	sig = Pan2.ar(sig, 0);
	sig = Limiter.ar(sig, amp);

	Out.ar(0, sig);
}).add.play;
)
(
SynthDef(\wubs4, {
	arg  freq = 110, vRate = 2, vDepth= 0.8, amp = 0.707, sustain = 1;
	var sig, mod, sig2, outSig, sig1, sigMix, env;

	env = Env.new([1,amp,amp,0], [1, 8, 6], 'lin');
	env = EnvGen.kr(env, gate: 1, doneAction: 2);
	freq = Env.new([220, 261.63, 293.67, 220, 196, 110, 55 ], [1, 2, 1, 1, 2], 'lin');
	freq = EnvGen.kr(freq, gate: 1, doneAction: 2);
	mod = Vibrato.kr(DC.ar(1), rate: vRate, depth:vDepth);
	sig1 = LFSaw.ar(LFSaw.kr(1, 0, freq*2, (freq/2)/2), mul: amp, add: 0);
	sig2 = LFSaw.ar(LFSaw.kr(1, 0, freq, ((freq/2)/2)/2), mul: amp, add: 0);
sigMix = Mix.new([sig1, sig2]);
		sig = RHPF.ar(
		in: sigMix,
		freq: 110,
		rq: 0.5,
		mul:amp,
	);
	sig = Pan2.ar(sig, 0);
	sig = Limiter.ar(sig, amp);

	Out.ar(0, sig);
}).add.play;
)
s.record;
s.stopRecording;
(
SynthDef(\wubs4, {
	arg  freq = 0, vRate = 6, vDepth= 0.02, amp = 0.707, sustain = 1;
	var sig, mod, sig2, outSig, sig1, sigMix, env, sig3;

	freq = Env.new([220, 261.63, 293.67, 220, 196 ], [4, 5, 5, 4], 'lin');
	freq = EnvGen.kr(freq, gate: 1, doneAction: 2);
	//mod = Vibrato.kr(DC.ar(1), rate: vRate, depth:vDepth);
	sig1 = LFSaw.ar(Vibrato.kr(freq, vRate, vDepth), mul: amp*0.2, add: 0);
	sig2 = LFTri.ar(Vibrato.kr(freq, vRate*2, vDepth/2), mul: amp, add: 0);
	sig3 = SinOsc.ar(Vibrato.kr(freq/2, vRate*0.5, vDepth*2), mul: amp*0.5, add:0);
	sigMix = Mix.new([sig1, sig2, sig3]);
	/*sig = RHPF.ar(
		in: sigMix,
		freq: freq*2,
		rq: 0.5,
		mul:amp,
	);*/

	sig = Pan2.ar(sigMix, 0);
	sig = Limiter.ar(sig, amp);

	Out.ar(0, sig);
}).add.play;
)
(
Pdef(\wuba,
	Pbind(
		\instrument, \wubs4,
		\freq, Pseq([174.61, 220, 110], 2),
		\dur, Pseq([5, 5, 5], 2),
		\db, -20,
		\sustain, 0.2,
		\vDepth,Pdef(\depth, 0.5),
		\vRate, Pdef(\rate, 1),
	)
)
)

Pdef(\wuba).play;

{ Impulse.ar(4, [0, MouseX.kr(0, 1)], 0.2) }.play;
{LFSaw.ar(110, 0, 0.1)}.play;

{ SinOsc.ar(LFTri.kr(0.1, 0, 220, 440), 0, 1) }.play
698.46/6