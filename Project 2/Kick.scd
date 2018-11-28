(//CREDIT YOUTUBE CHANNEL SOUND ENGRAVER
SynthDef.new(\kick, {
	arg freqA = 1000, freqB = 50, freqC = 10, freqDur1=0.01, freqDur2=0.2, freqC1 = 1, freqC2 = (-1),
	atk=0.01, rel=1, c1=1, c2=(-12), amp=0.707, pan=0, out=0;
	var sig, env, freqSweep;
	freqSweep = Env([freqA, freqB, freqC], [freqDur1, freqDur2], [freqC1, freqC2]).ar;
	env = Env([0,1,0], [atk, rel], [c1, c2]).kr(2);
	sig = SinOsc.ar(freqSweep, pi/2);
	sig = sig*env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}).add;
)

x = Synth.new(\kick, [\freqA, 880, \amp,1, \freqDur1, 0.02]);

(// MY OWN KICK BASED OFF OF SOUND ENGRAVER'S KICK
SynthDef(\deepKick, {
	arg freqA = 174.61, freqB = 55, freqC = 43.654, freqDur1=0.02, freqDur2=0.75, freqC1 = 1, freqC2 = (-1),
	atk=0.01, rel=0.8, curve=(-1), amp=0.707, pan=0, out=0, gate = 1;

	var sig, env, freqEnv;

	freqEnv = EnvGen.kr(Env.new([freqA, freqB, freqC], [freqDur1, freqDur2], [freqC1, freqC2]), gate);

	env = EnvGen.kr(Env.perc(atk, rel, 1, -2), gate: 1, doneAction: 0);

	sig = SinOsc.ar(freqEnv, pi/2, env);

	sig = Pan2.ar(sig, pan, amp);

	Out.ar(out, sig);
}).add;
)
(// MY OWN KICK BASED OFF OF SOUND ENGRAVER'S KICK
SynthDef(\kick2, {
	arg freqA = 440, freqB = 55, freqC = 27.5, freqDur1=0.02, freqDur2=0.75, freqC1 = 1, freqC2 = (-1),
	atk=0.05, rel=0.8, curve=(-1), amp=0.707, pan=0, out=0, gate = 1;

	var sig, env, freqEnv;

	freqEnv = EnvGen.kr(Env.new([freqA, freqB, freqC], [freqDur1, freqDur2], [freqC1, freqC2]), gate);

	env = EnvGen.kr(Env.perc(atk, rel, 1, -1), gate: 1, doneAction: 0);

	sig = SinOsc.ar(freqEnv, pi/2, env);

	sig = Pan2.ar(sig, pan, amp);

	Out.ar(out, sig);
}).add.play;
)

Env.perc(0.05, 0.8, 1, -1).plot;



(
Pdef(\kickPat,
	Pbind(
		\instrument, \kick2,
		\dur, Pseq([1, 1,  0.5, 1], inf),
		//\freqA, Pseq([440], inf),
		\curve, Pseq([-1], inf),
		\db, Pseq([-1], inf)
	);
).play;
)
(
SynthDef(\bassNoise, {
	arg freq = 55, amp = 0.707, gate = 1, sustain = 1, modFreq = 220, rate = 0.5, depth = 0.05;
	var sig, env, rateEnv;

	env = Env.adsr(0.01*sustain, 0.3*sustain, amp*0.707, 0.5*sustain);

	env = EnvGen.kr(env, gate, amp, doneAction: 2);

	rateEnv = EnvGen.kr(Env.new([0.25, 0.5,  0.5, 1, 1, 2, 2, 4, 4, 6, 6],
		                        [     1,   2,    1, 2, 1, 4, 1, 4, 1, 4 ], curve: 'lin'));
	sig = RLPF.ar(VarSaw.ar(LFTri.kr(Vibrato.kr(DC.ar(freq), rate, depth)), mul: env), modFreq, rq: 0.5);
	// sig = sig*Vibrato.ar(DC.ar(modFreq), rate, depth);
	//sig =Saw.ar(Vibrato.ar(DC.ar(freq), rate, depth), mul: env);

	sig = Pan2.ar(sig, 0);

	sig = Limiter.ar(sig, 0.707);

	sig = sig*Crackle.kr(0.1, amp);
	//sig = sig*env;

	Out.ar(0, sig);
}).play;
)





























