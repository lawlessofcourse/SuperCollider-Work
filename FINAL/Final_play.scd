//FINAL PLAY
// DONE - HOW DO I DESIGN LFO SHAPES TO GET THE DUBSTEP WUB LIKE IN SERUM - DONE
// DESIGN LFO SHAPES AND APPLY TO BASS SOUNDS
// HOW TO CREATE AN IMPACT SOUND
// NEED MORE HARMONICS, PLUCKS OR WHATEVER
// TRY FUCKING AROUND WITH SOUNDIN AND MODIFYING THAT SOUND
// Best way to set panning control?
//NEED TO START SETTING UP MIDI DEVICE > NOT DOING TOUCH OSC because I do not have a large touchscreen device to use and I have a nice midi controller.
//HOW IS AN LFO DIFFERENT FROM AN ENVELOPE? An envelope plays once an LFO is continuous.
// HOW DO I CREATE CUSTOM LFO'S AND IMPLIMENT THEM
//why do my pdefs sometimes stop working? all I do to get them to work again is by restarting SC(ex. highhat synth executes but pdef wont play)
//MAYBE CONVERT TO A FASTER BPM AND SLOW DOWN PERCUSSION TO MATCH - I LIKE BETWEEN 130 AND 150 BPM
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

c = TempoClock.default
c.tempo = 80/60
thisProcess.platform.recordingsDir
s.record
s.stopRecording
(
(// MAYBE INCOPORATE KICK THAT SPEEDS UP?
Pdef(\build,
	Pbind(
		\instrument, \buildUp,
		\dur, Pseq([5], 3), // plays twice >> design impact sound to lay at of of this Pdef
		\db, -2,
))
);
// IMPACT PDEF TO PLAY AT END OF BUILD
//how to combine percussion pdefs so i can play all at once and create different pattern variations
(//HOW TO LINE UP CLAPS WITH KICKS?
Pdef(\deepKickPat,
	Pbind(
		\instrument, \deepKick,
		//\dur, Pseq([1, 1,  0.5, 1.5], inf),
		\dur, Pdef(\kickDur, Pseq([1, 1.5, 1.5], inf)), //total time: 5s
		//\freqA, Pseq([440], inf),
		\curve, Pseq([-1], inf),
		\db, Pseq([-6], inf), // set to controller?
	).pause
)
);
//Pdef(\kickDur, Prand([0.5, 0.25, 0.125], inf))
(
Pdef(\clapPat,
	Pbind(
		\instrument, \clap,
		//\dur, Pseq([0.5,0.5,0.5,0.5, 1, 0.5, 0.25, 0.25], inf),
		\dur, Pdef(\clapDur, Pseq([1, 0.5, 1, 0.5, 1], inf)), // total time: 4s
		//\db, Pseq([ -64, -64, -64, -64, 0 ], inf)
		\db, Pdef(\clapDb, Pseq([ -64, -64, -2, -64, -2 ], inf)),
))
);
(
Pdef(\highHatPat,
	Pbind(
		\instrument, \highHat,
		\dur, Pdef(\highHatDur, Pseq([0.25, 0.25, 0.25, 0.5, 0.25, 0.5], inf)),


		\db, -16,
))
);
//RESOVLED - WHY AM I GETTING FAILURE IN SERVER/ WHAT DO I NEED TO SET THE DONEACTION TO FOR THE NODES - RESOLVED - FOR ENV.PERC DO NOT USE GATE
(
Pdef(\wubalub,
	Pbind(
		\instrument, \wubs3,
		\freq, Pdef(\freq, 43.654),
		\dur, Pseq([23],inf),
		\db, -6,//set to fader or knob
		//\vDepth,Pdef(\vDepth, 0.08),
		//\vRate, Pdef(\rate, 1),//set to knob or fader w/ values of 0...10
	))
);
(
Pdef(\beautPatBuild,
	Pbind(
		\instrument, \beautBuild,
		\dur, Pseq([40],1),
		\db, -4,
	))
);
(
Pdef(\beautPatConstant,
	Pbind(
		\instrument, \beautConstant,
		\freq, Pdef(\freqA, 174.61),// set to controller?
		\dur, Pseq([4, 2, 4, 2],inf),
		\db, -8, // set to fader or knob
		\vRate, Pdef(\vRate, 10), // set to controller maybe try setting it same knob or fader that wubalub's rate is set to so they change rates together.
		//\filterFreq, Pdef(\filterFreq, 698.46) // set to controller //filter freq is dependent upon freq so only the freq paramenter needs to be changed to alter the sound
	))
);
(
Pdef(\yeahBass,
	Pbind(
		\instrument, \bassNoise,
		\freq, Pdef(\note, Pseq([55, 48.999, 61.735], inf)),
		\dur, Pseq([8, 8, 8],inf),
		\db, -8, // knob for volume
		\sustain, 10,
		\modFreq, Pseq([174.61, 220, 146.83], inf),
		\rate, Pdef(\rate, 1), //knob for rate
		\depth, Pdef(\depth, 0.6),
		\lfoRate, Pdef(\lfoRate, 4),
		\lfoAmpLow, Pdef(\lfoAmpLow, 1),
		\test, Pfunc({|ev| ~der = ev})
	))
);
(
Pdef(\bassHit,
	Pbind(
		\instrument, \bassNoise2,
		\freq, Pdef(\note, Pseq([55, 55, 55], inf)),
		\dur, Pdef(\bassHitDur, Pseq([3],inf)),
		\db, -4, // knob for volume
		\sustain, 1.5,
		\release, 1.5,
		\modFreq, Pseq([440, 392, 493.88], inf),
		//\rate, Pdef(\rate, 1), //knob for rate
		//\depth, Pdef(\depth, 0.6),
		//\test, Pfunc({|ev| ~der = ev})
	))
);
)

Pdef(\build).play;
Pdef(\build).stop;
Pdef(\highHatPat).play;Pdef(\highHatDur, Pseq([0.25, 0.25, 0.25, 0.5, 0.25, 0.5], inf));

Pdef(\clapPat).play;Pdef(\deepKickPat).play;
Pdef(\kickDur, Pseq([1, 0.5, 1, 0.5, 1], inf));

Pdef(\highHatPat).pause;

//Pdef(\clapPat).pause;
//Pdef(\deepKickPat).pause;
Pdef(\highHatPat).play;
Pdef(\highHatDur,Pseq([0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,],inf));


Pdef(\wubalub).stop;
Pdef(\highHatPat).play;
(Pdef(\kickDur, Pseq([0.5, 0.5, 0.25, 0.75], inf));
Pdef(\clapDur, Pseq([0.5, 0.5, 0.3, 0.7], inf));
Pdef(\clapDb, Pseq([-64, -64, -64, -4], inf));)

Pdef(\clapPat).pause;Pdef(\deepKickPat).pause;Pdef(\wubalub).pause;

Pdef(\wubalub).play;Pdef(\bassHit).play;Pdef(\bassHitDur, Pseq([5, 8, 8, 2], inf));// LINE THIS UP WITH WUBALUB ENV IN BASSNOISE
Pdef(\highHatPat).play;Pdef(\highHatDur, Pseq([0.1], inf));

Pdef(\vDepth, 0.5);Pdef(\rate, 6);// set to controller


// CAN I CREATE ROUTINES OR TASKS TO AUTOMATE THE BREAK
Pdef(\highHatPat).pause;Pdef(\clapPat).pause;Pdef(\deepKickPat).pause;Pdef(\wubalub).stop;
Pdef(\highHatPat).play;Pdef(\clapPat).play;Pdef(\deepKickPat).play;Pdef(\beautPatBuild).play;
//LIKEWISE CAN I CREATE TASK/ROUTINE TO PLAY THE CONSTANT NEAR THE END OF THE BUILD
Pdef(\beautPatConstant).play;Pdef(\kickDur, Pseq([2, 2, 2, 2, 2 , 2], inf));
Pdef(\beautPatBuild).stop;




Pdef(\freqA, 174.61)//set to controller


Pdef(\yeahBass).play;
Pdef(\beautPatConstant).stop;
Pdef(\lfoRate, 0.5);
Pdef(\lfoAmpLow, 0);
Pdef(\yeahBass).pause;


Pdef(\bassHit).play;
