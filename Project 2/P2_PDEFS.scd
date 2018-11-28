(
Pdef(\wubalub,
	Pbind(
		\instrument, \wubs3,
		\dur, Pseq([30], inf),
		\db, -6,//set to controller
		\vDepth,Pdef(\depth, 0.8),//set to controller
		\vRate, Pdef(\rate, 6),//set to controller
	)
)
)
Pdef(\wubalub).play;
Pdef(\depth, 0.6);
Pdef(\rate, 0.5);

(
Pdef(\beautPat,
	Pbind(
		\instrument, \beaut,
		\dur, Pseq([40],1),
		\db, -4,
	)
).play
)


(
Pdef(\higher,
	Pbind(
		\instrument, \chords,
		\freq, Pseq([440, 392,  349.88], inf),
		\dur, Pseq([5.5, 5.5,  8, 11],inf),
		\db, -16,
		\modFreq, Pseq([880, 783.99, 698.46], inf),
		\test, Pfunc({|ev| ~der = ev})
	)
)
)
(
Pdef(\spurts,
	Pbind(
		\instrument, \synthy,
		\freq, Pseq([440, 392,  349.88], inf),
		\dur, Pseq([0.5, 0.5,  1],inf),
		\db, Pseq([-35, -20, -12], inf),
		\sustain, 0.2,
		\modFreq, Pseq([880, 783.99, 698.46], inf),

	)
)
)

(
Pdef(\yeahBass,
	Pbind(
		\instrument, \bassNoise,
		\freq, Pdef(\note, Pseq([55, 48.999, 61.735], inf)),
		\dur, Pseq([8, 8, 8],inf),
		\db, -12, // knob for volume
		\sustain, 10,
		\modFreq, Pseq([174.61, 220, 146.83], inf),
		\rate, Pdef(\rate, 1), //knob for rate
		\depth, Pdef(\depth, 0.6),
		\test, Pfunc({|ev| ~der = ev})
	)
)
)
(
Pdef(\redBone,
	Pbind(
		\instrument, \synthy,
		\freq, Pseq([293.67, 440, 392, 349.23, 329.63, 261.63, 220, 293.67,
			261.62, 293.67, 349.23, 523.25, 440,
			329.63, 349.23, 392, 349.23
		], inf),

		\dur, Pseq([1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 4/2,
			1/2, 1/2, 1/2, 1/2, 4/2,
			1/2, 1/2, 1/2, 8/2
		],inf),
		\db, 0,
		//\sustain, 2,
		\modFreq, Pseq([174.61, 220, 146.83], inf),
		\test, Pfunc({|ev| ~der = ev})
	)
)
)
Pdef(\redBone).play;
