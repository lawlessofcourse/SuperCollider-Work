-*
(
d = Dictionary.new;
// d.add(\k -> PathName("/Users/mac/Desktop/Sounds/kick").entries.collect({
// 	arg sf;
// 	Buffer.read(s, sf.fullPath);
// 	});
// );
// d.add(\n -> PathName("/Users/mac/Desktop/Sounds/snare").entries.collect({
// 	arg sf;
// 	Buffer.read(s, sf.fullPath);
// 	});
// );
d.add(\b -> PathName("/Users/mac/Desktop/Sounds/bass").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
)


(
SynthDef.new(\sine,{
	arg freq = 440, atk = 0.005, rel = 0.3, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]),doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0,sig);
}).add;

SynthDef.new(\bufplay, {
	arg buf=0, rate=1, amp=1;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, doneAction:2);
	//sig = sig*amp;
	Out.ar(0, sig!2);
}).add;
)

Synth.new(\bufplay, [\buf, d[\b].choose.bufnum]);

(
Pdef(
	\rhythm,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/16], inf),
		\stretch, 1.875,
		\buf, Prand(d[\b], inf),
		\rate, 0.5,
		\amp, 0,
	)
).play;
)

(
Pdef(
	\sinepat,
	Pbind(
		\instrument, \sine,
		\dur, Pwhite(0.05, 0.5, inf),
		\midinote, Pseq([35], inf),
		\harmonic, Pexprand(1, 20, inf).round,
		\atk, Pwhite(2.0, 3.0, inf),
		\rel, Pwhite(5.0, 10.0, inf),
		\amp, Pkey(\harmonica).reciprocal * 0.3,
		\pan, Pwhite(-0.8, 0.8, inf),
	);
)
)
Pdef(\rhythm).play;

/*(
p = Pbind(
	\instrument, \sine,
	\dur, Pseq([0.6, 0.15, 0.15], inf).trace,
	\midinote, Pseq([60, 65, 67, 74], inf).trace,
).play;
)*/


