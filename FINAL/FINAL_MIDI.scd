// MIDI CONNECTION
// initalize midi
MIDIClient.init;

// connect midi devices to SC
MIDIIn.connectAll
~bank = Array.newClear(127);
~bassVol = Bus.control();
~beautVol = Bus.control();
~wubVol = Bus.control();
~hatVol = Bus.control();
~lfoBus = Bus.control();
~rateBus = Bus.control();
~constVol = Bus.control();
~rateBus2 = Bus.control();


(
MIDIdef.cc(\bassRate, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127*20).ceil;
	~rateBus.set(val);
	["Vibrato Rate", val].postln;
},
(21) // <- the midi number you want to target
);

MIDIdef.cc(\lfoRate, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127*20).ceil;
	~lfoBus.set(val);
	["LFO Rate", val].postln;

},
(22) // <- the midi number you want to target
);

MIDIdef.cc(\bassRate2, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127*10).ceil;
	~rateBus2.set(val);
	["WubsConst Rate", val].postln;
},
(23) // <- the midi number you want to target
);

MIDIdef.cc(\wubVol, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127);
	~wubVol.set(val);
	["Wubalub Volume", val].postln;
},
(41) // <- the midi number you want to target
);

MIDIdef.cc(\bassVol, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127);
	~bassVol.set(val);
	["BassNoise Volume", val].postln;
},
(42) // <- the midi number you want to target
);
MIDIdef.cc(\beautVol, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127);
	~beautVol.set(val);
	["Beaut Const. Volume", val].postln;
},
(43) // <- the midi number you want to target
);
MIDIdef.cc(\wubsConstVol, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127); //.floor so it is either on or off
	~constVol.set(val);
	["WubsConst", val].postln;
},
(44) // <- the midi number you want to target
);
MIDIdef.cc(\hiHatVol, {
	arg val, nn, chan, src;
	//val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;

	val = (val/127).floor; //.floor so it is either on or off
	~hatVol.set(val);
	["HiHat Volume", val].postln;
},
(45) // <- the midi number you want to target
);



MIDIdef.noteOn(\noteOn, {
	arg ...args;
	var note, val;
	args.postln;

	note = args[1];
	~bank[note] = Synth(\bassNoise, [\freq, note.midicps]);

},
(0..127)// set to accept all note numbers
);


MIDIdef.noteOff(\noteOff, {
	arg ...args;
	var note, val;
	args.postln;

	note = args[1];

	if(~bank[note] != nil, {
		~bank[note].free;
		~bank[note] = nil;
	});

},
(0..127)// set to accept all note numbers
);
)









