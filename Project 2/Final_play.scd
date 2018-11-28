//FINAL PLAY
// HOW DO I DESIGN LFO SHAPES TO GET THE DUBSTEP WUB LIKE IN SERUM
// HOW TO CREATE AN IMPACT SOUND
// NEED MORE HARMONICS, PLUCKS OR WHATEVER
// TRY FUCKING AROUND WITH SOUNDIN AND MODIFYING THAT SOUND
// Best way to set panning control?
//NEED TO START SETTING UP MIDI DEVICE > NOT DOING TOUCH OSC because I do not have a large touchscreen device to use and I have a nice midi controller.
//CANT GET HIHAT TO PLAY THROUGH PDEF! WHY TF NOT?
//HOW IS AN LFO DIFFERENT FROM AN ENVELOPE?
// HOW DO I CREATE CUSTOM LFO'S AND IMPLIMENT THEM
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// initalize midi
MIDIClient.init;
MIDIClient.restart;

// connect midi devices to SC
MIDIIn.connectAll


~rateBus = Bus.control();

(
MIDIdef.cc(\bassRate, {
	arg val, nn, chan, src;
	val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;
	~rateBus.set(val/127);


},
(0..127)
))
(
MIDIdef.noteOn(\noteOnTest, {
	arg val, nn, chan, src;
	[val, nn].postln;
	~notes[nn] = Pdef.new(
		\wubalub,
		[
			\freq, nn.midicps,
			\amp, val.linexp(1,127,0.01,0.3),

		]
	);
});

MIDIdef.noteOff(\noteOffTest, {
	arg val, nn;
	~notes[nn].set(\gate,0);
	~notes[nn] = nil;
});

MIDIdef.bend(\bendTest, {
	arg val, chan, src;
	[val, chan, src].postln;
	~bend = val;
	~notes.do{arg synth; synth.set(\bend, val.linlin(0,16383,-2,2))};
}, chan:0);
)
~bend = 8192;
~notes = Array.newClear(128);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

c = TempoClock.default
c.tempo = 80/60
thisProcess.platform.recordingsDir
s.record
s.stopRecording
(// MAYBE INCOPORATE KICK THAT SPEEDS UP?
Pdef(\build,
	Pbind(
		\instrument, \buildUp,
		\dur, Pseq([5], 3), // plays twice >> design impact sound to lay at of of this Pdef
		\db, -2,
))
)
// IMPACT PDEF TO PLAY AT END OF BUILD

//how to combine percussion pdefs so i can play all at once and create different pattern variations

(//HOW TO LINE UP CLAPS WITH KICKS?
Pdef(\deepKickPat,
	Pbind(
		\instrument, \deepKick,
		//\dur, Pseq([1, 1,  0.5, 1.5], inf),
		\dur, Pdef(\kickDur, Pseq([1, 0.5, 1, 0.5, 1], inf)),
		//\freqA, Pseq([440], inf),
		\curve, Pseq([-1], inf),
		\db, -6, // set to controller?
	)
)
)
//Pdef(\kickDur, Prand([0.5, 0.25, 0.125], inf))
(
Pdef(\clapPat,
	Pbind(
		\instrument, \clap,
		//\dur, Pseq([0.5,0.5,0.5,0.5, 1, 0.5, 0.25, 0.25], inf),
		\dur, Pseq([1, 0.5, 1, 0.5, 1], inf),
		//\db, Pseq([ -64, -64, -64, -64, 0 ], inf)
		\db, Pseq([ -64, -64, -4, -4, -4 ], inf)
))
)
(
Pdef(\highHatPat,
	Pbind(
		\instrument, \highHat,
		\dur, Pdef(\highHatDur, Pseq([0.25, 0.25, 0.25, 0.5, 0.25, 0.5], inf)),


		\db, -2,
))
)
//RESOVLED - WHY AM I GETTING FAILURE IN SERVER/ WHAT DO I NEED TO SET THE DONEACTION TO FOR THE NODES - RESOLVED - FOR ENV.PERC DO NOT USE GATE
(
Pdef(\wubalub,
	Pbind(
		\instrument, \wubs3,
		\freq, Pdef(\freq, 43.654),
		\dur, Pseq([23],inf),
		\db, -6,//set to fader or knob
		\vDepth,Pdef(\vDepth, 0.08),
		\vRate, Pdef(\rate, 1),//set to knob or fader w/ values of 0...10
	)
)
)
(
Pdef(\beautPatBuild,
	Pbind(
		\instrument, \beautBuild,
		\dur, Pseq([40],1),
		\db, -4,
	)
)
)
(

Pdef(\beautPatConstant,
	Pbind(
		\instrument, \beautConstant,
		\freq, Pdef(\freqA, 174.61),// set to controller?
		\dur, Pseq([4, 2, 4, 2],inf),
		\db, -6, // set to fader or knob
		\vRate, Pdef(\vRate, 10), // set to controller maybe try setting it same knob or fader that wubalub's rate is set to so they change rates together.
		//\filterFreq, Pdef(\filterFreq, 698.46) // set to controller //filter freq is dependent upon freq so only the freq paramenter needs to be changed to alter the sound
	)
)
)
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
		\test, Pfunc({|ev| ~der = ev})
	)
)
)
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
	)
)
)
Pdef(\build).play;

Pdef(\highHatPat).play;Pdef(\highHatDur, Pseq([0.25, 0.25, 0.25, 0.5, 0.25, 0.5], inf));

Pdef(\clapPat).play;Pdef(\deepKickPat).play;Pdef(\kickDur, Pseq([1, 0.5, 1, 0.5, 1], inf));

Pdef(\highHatPat).pause;

(Pdef(\clapPat).pause;
//Pdef(\deepKickPat).pause;
Pdef(\highHatPat).play;
Pdef(\highHatDur,Pseq([0.25, 0.25,0.25,0.25,0.25, 0.25,0.25,0.25,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,], inf));)



Pdef(\highHatPat).pause;Pdef(\clapPat).play;Pdef(\deepKickPat).play;Pdef(\kickDur, Pseq([0.5, 0.5, 0.25, 0.75], inf));Pdef(\wubalub).play;

Pdef(\clapPat).pause;Pdef(\deepKickPat).pause;Pdef(\wubalub).pause;

Pdef(\wubalub).play;Pdef(\bassHit).play;Pdef(\bassHitDur, Pseq([5, 5, 5, 5, 5], inf));// LINE THIS UP WITH WUBALUB ENV IN BASSNOISE
Pdef(\highHatPat).play;Pdef(\highHatDur, Pseq([0.25], inf));

Pdef(\vDepth, 0.5);Pdef(\rate, 6);// set to controller


// CAN I CREATE ROUTINES OR TASKS TO AUTOMATE THE BREAK
Pdef(\highHatPat).pause;Pdef(\clapPat).pause;Pdef(\deepKickPat).pause;Pdef(\wubalub).pause;
Pdef(\highHatPat).play;Pdef(\clapPat).play;Pdef(\deepKickPat).play;
Pdef(\beautPatBuild).play;
//LIKEWISE CAN I CREATE TASK/ROUTINE TO PLAY THE CONSTANT NEAR THE END OF THE BUILD
Pdef(\beautPatConstant).play;
Pdef(\beautPatBuild).stop;




Pdef(\freqA, 174.61)//set to controller


Pdef(\yeahBass).play;Pdef(\beautPatConstant).stop;
Pdef(\yeahBass).stop;


Pdef(\bassHit).play;