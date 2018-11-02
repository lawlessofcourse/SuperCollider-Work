//Project 1 WorkPage


/* TO DO'S
1) Percussion - high sounds
2) Youtube pbinds and pdefs - create harmonic pdef
3) Create cool SoundIn modifier to use with guitar and record that and impliment into project
4) Go Over play buffer and busses in notes/github
5) Create distinct sounds using controlllers such as MouseX
6) use busses to map to controller?

*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////// PLAY AREA: LIVE PREFORMANCE OR RECORDING ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
thisProcess.platform.recordingsDir
s.record
s.stopRecording


Synth(\buildUp);
Synth(\soundIn);
Synth(\wubs);

Pdef(\kick).play;
Pdef(\bassLine).play;

//////////////////////////////////////////////////////////////////////////////////
///////////////////////////SynthDef's GO HERE/////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
(
SynthDef(\soundIn, {
	var sig, in, mod;
	in = SoundIn.ar(0);
	/*sig = CombC.ar(
		in: sig,
		maxdelaytime: 5,
		delaytime: 0.2,
		decaytime: 1.5,
		mul: 1,
		add: 0);*/
	sig = RLPF.ar( in, SinOsc.ar(20, phase: 0, mul: 3600, add: 4000), rq: 0.02, mul: 0.2)*SinOsc.ar(Vibrato.kr(500.0,1,0.02));
	sig = CombC.ar(
		in: sig,
		maxdelaytime: 5,
		delaytime: 0.5,
		decaytime: 3,
		mul: 0.5,
		add: 0
	);//*SinOsc.ar(Saw.kr(200), 0.7);
	//sig = FreeVerb.ar(sig, 0.33, 0.5,0.5, 1, 0);
	sig = Limiter.ar(sig, 0.707);
	Out.ar(0, Mix([sig, sig]!2));
}).add;
)

(SynthDef(\wubs, {
	arg freqA = 200, freqB = 60;
	var sig;

	sig = SinOsc.ar(
		Vibrato.kr(
			freq:DC.ar(freqA),
			rate:2,
			depth:2,
			delay:1,
			onset: 0
	)*RLPF.ar(Saw.ar([50,150],0.1), XLine.kr(8000,400,20), 0.05));
	sig = sig*FreeVerb.ar(sig, mix: 0.66, room:0.7, damp:0.6);
	sig = Limiter.ar(sig, 0.4);
	Out.ar(0, sig!2);
}).add;)

(SynthDef(\buildUp, {
	var env, sig, sig2, outSig;
	sig = RLPF.ar(
		in: Saw.ar(XLine.kr(50, 200, 10),0.1),
		freq: XLine.kr(8000,400,5),
		rq: 0.05,
		mul: XLine.kr(1.0, 0.001, 20, doneAction: 2)
	);
	sig2 = RLPF.ar(
		in: Saw.ar(XLine.kr(start: 40, end: 150, dur: 10), 0.1),
		freq: SinOsc.ar(XLine.kr(0.7, 300, 20), 0, 3600, 4000),
		mul: XLine.kr(1.5, 0.01, 20)
	);
	outSig = Mix.new([sig, sig2]);
	outSig= Limiter.ar(outSig, 0.9);
	Out.ar(0, outSig!2);
}).add;
)
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
	sig = RLPF.ar(
		in: Saw.ar(freq, mul: 1),
		freq: 600,
		rq: 0.2,
		mul: 1
	);
	//sig = FreeVerb.ar(sig, 0.33, 0.5, 0.5);
	sig = sig*env;


	Out.ar(0, sig!2);
}).add;
)
//////////////////////////////////////////////////////////////////////////////////
///////////////////////////  Pdef's GO HERE  /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

(
Pdef(\kick,
	Pbind(
	\instrument, \sine,
	\dur, Pseq([0.5, 0.5, 0.5], inf),
	\freq, Pseq([70, 60, 55], inf)
	);
);
Pdef(\bassLine,
	Pbind(
	\instrument, \bassNoise,
	\dur, Pseq([0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25], inf),
	\freq, Pseq([80, 60, 90, 50, 60, 70, 70, 65], inf),
	);
);
)

//////////////////////////////////////////////////////////////////////////////////
///////////////////////////WORK AREA - RANDOM/////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
{ Pulse.ar(XLine.kr(40, 4000, 6), 0.1, 0.2) }.play;

({
Saw.ar(
		Vibrato.kr(100, 2, 0.05), 0.6
)}.play)



