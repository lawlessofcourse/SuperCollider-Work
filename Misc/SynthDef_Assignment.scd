(
SynthDef(\inputMod,{
	arg freq = 450, delayT = 0.5, decayT = 0.5;
	var in, sig, mod, mod2, mod3, env;

	in = SoundIn.ar(0, 1.0);

	env = Env.new(
		[0.2, 0.2,   5, 0.5, 0.1, 0.1,   0.5, 0.5, 0.75, 0.75 ],
		[  1, 0.5,   5,   3, 2, 0.5, 2, 1,    10  ],
	);
	env = EnvGen.kr(env, timeScale: 1);



	// mod = SinOsc.ar(LFNoise1.kr(5, 400, 300) + in);
	 mod = SinOsc.ar(Vibrato.ar(DC.ar(400.0),LFNoise1.kr(1,3,7),rrand(0.0, 1.0),1.0,1.0,rrand(0.0, 1.0),0.1) );
//	mod = LFTri.ar(Vibrato.kr(50.0, 6.0, 0.5), mul: 1.2);

sig = CombC.ar(
		in,
		maxdelaytime: 10,
		delaytime: env,
		decaytime: env*2,
		mul: 0.707
	) * mod;
	// play with mod, mod2, mod3. multiply or add. Also try using the envelope with different paramenters such as delay time or decay time or agains the mod.


	sig = Limiter.ar( sig, 0.9 );

	Out.ar(0, sig ! 2 );

}).add;
)

Synth(\inputMod)
//////////////////////////////////////////////////////////////////////////
(
SynthDef(\higher, {
	arg freq = 400, depth = 0.05;
	var sig, sig2, sig3, env;

	sig = SinOsc.ar(Vibrato.kr(freq,1,depth));
	sig2= LFSaw.ar(Vibrato.kr(freq/2, 1,depth/2));
	sig2 = CombC.ar(sig, maxdelaytime: 10, delaytime: 1, mul: 1);
	sig = CombC.ar(in: sig, maxdelaytime: 10, delaytime: 1, mul:1);
	sig3 = Mix.new([sig, sig2]);
	Out.ar(0, sig3!2);
}).add;
)
Synth(\higher)


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(
SynthDef(\bassNoise, {
	arg freq = 50, amp = 1, len = 1, freqM = 1;
	var sig, sig2, masterSig, env, env2;

	env = Env.new(
		[ 0,     1,    1,      0,   0,    1,    1,    0, 0,    1, 1, 0],
		[   0.25,  0.5,  0.25,   0,   0.25,  0.5,  0.25, 0, 0.25, 1.25, 0.25 ]*0.3);
	env = EnvGen.kr(env, timeScale: 1);

	env2 = Env.new(
		[50,  50,    60,  60,     40, 40, 0]*freqM,
		[   1,   0.25,  1,    0.25, 1.25, 0.25 ]*0.3);
	env2 = EnvGen.kr(env2, timeScale: 1);

	sig = RLPF.ar(LFSaw.ar(env2, mul: amp), 450)*env;
	sig = FreeVerb.ar(sig, 0.33, 0.5, 0.5);



	Out.ar(0, sig!2);
}).add;
)

Synth(\bassNoise)



(
t.play;
t = Task({

	inf.do({
		var freq, len, amp;
		1.do({ arg i;
			a.set(\freqM, (i + 1));

		});

		Synth(\bassNoise,);

		1.2.wait;
		// len.wait;
	})
})
)

t.stop;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(
SynthDef(\inputMod2,{
	arg freq = 150, rate = 2, amp2 = 1;
	var  sig;

	sig = LFTri.ar(Vibrato.kr(freq: freq, rate: rate, depth: 0.5, delay: 0.2), mul: amp2);
	sig = CombC.ar(sig, 10, 0.2, 1);

	Out.ar(0, sig!2);



}).add;
)

a = Synth(\inputMod2)

a.free;

(
t = Task({
	a = Synth(\inputMod2);
	0.1.wait;

	1.do({ arg i;
		a.set(\rate, (i + 0.25) );
		a.set(\amp, (i - 0.1));

		1.wait;
	});
	// a.free;
});
)
t.start
t.stop
(
h = Task({
	1.do({ arg i;

		//var freq1 = rrand(20, 200);
		a.set(\freq, i - 0.02);
		//Synth(\inputMod2, [\freq, freq1]);
	1.0.wait;
	})
})
)

h.start