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

c = TempoClock.new(1, 4, 1, 256);
c.tempo = 120/60
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
	)
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
		\dur, Pdef(\highHatDur, Pseq([0.25], inf)),


		\db, -16,
))
);
//RESOVLED - WHY AM I GETTING FAILURE IN SERVER/ WHAT DO I NEED TO SET THE DONEACTION TO FOR THE NODES - RESOLVED - FOR ENV.PERC DO NOT USE GATE
(
Pdef(\wubalub,
	Pbind(
		\instrument, \wubs3,
		//\freq, Pdef(\freq, 43.654),
		\dur, Pseq([20],inf),
		\db, 0,//set to fader or knob
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
		//\freq, Pdef(\note, Pseq([55, 48.999, 61.735], inf)),
		\dur, Pseq([8, 8, 8],inf),
		\db, -8, // knob for volume
		//\sustain, 10,
		//\modFreq, Pseq([174.61, 220, 146.83], inf),
		\rate, Pdef(\rate, 1), //knob for rate
		\depth, Pdef(\depth, 0.6),
		\lfoRate, Pdef(\lfoRate, 4),
		\lfoAmpLow, Pdef(\lfoAmpLow, 1),
		\test, Pfunc({|ev| ~der = ev})
	))
);
(
Pdef(\yeahBass2,
	Pbind(
		\instrument, \bassNoise,
		\dur, Pseq([1.5], 1),
		\freq, Pseq([55], 5),
	))
);
(
Pdef(\bassHit,
	Pbind(
		\instrument, \bassHit,
		\freq, Pdef(\note, Pseq([55, 55, 55], inf)),
		\dur, Pdef(\bassHitDur, Pseq([4],inf)),
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

Pdef(\build).play;Pdef(\wubalub).play; // FADE IN WUB TO BUILD
Pdef(\build).stop; //EXECUTE AFTER

Pdef(\wubalub).stop; //HIT THIS THEN ONCE IT STOPS EXECUTE NEXT BLOCK OF CODE

//PLAY ADD IN HIHAT NEAR END AND FADE OUT WUB
Pdef(\wubalub).play;Pdef(\bassHit).play;Pdef(\bassHitDur, Pseq([6, 10, 10, 10, 4], inf));Pdef(\deepKickPat).play;Pdef(\kickDur, Pseq([2, 1, 2, 1, 2], inf));Pdef(\highHatPat).play;// LINE THIS UP WITH PSEQ IN WUBALUB




// CAN I CREATE ROUTINES OR TASKS TO AUTOMATE THE BREAK
Pdef(\deepKickPat).pause;
Pdef(\beautPatBuild).play;
Pdef(\bassHit).pause;

Pdef(\beautPatConstant).play;Pdef(\bassHit).play;Pdef(\bassHitDur, Pseq([4], inf));Pdef(\beautPatBuild).stop;

Pdef(\deepKickPat).play;Pdef(\kickDur, Pseq([2], inf));

Pdef(\beautPatConstant).pause;Pdef(\bassHitDur, Pseq([2], inf));
Pdef(\deepKickPat).pause;

b = Synth(\bassNoise);
b.pause;
b.free;

Pdef(\lfoAmpLow, 0.5);




