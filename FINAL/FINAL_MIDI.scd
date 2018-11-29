// MIDI CONNECTION
// initalize midi
MIDIClient.init;
MIDIClient.restart;

// connect midi devices to SC
MIDIIn.connectAll


~rateBus = Bus.control();
~vRate = Array.newClear(127);

(
MIDIdef.cc(\bassRate, {
	arg val, nn, chan, src;
	val.postln;
	nn.postln;
	// nn is the knob/fader location ex fader 1 is 41 and knob 1 is 21
	//I want to specifically say use nn 21 for rate control.
	"".postln;
	~rateBus.set(val/127*10).postln;//STILL GOES UP TO 127 ??
	// I CANT GET THIS TO WORK... ARRRGAAGAAAAAA
},
(21) // <- the midi number you want to target
);
MIDIdef.cc(\changeModRate, {
	// arg val, num, chan, src;


	// num.postln;
	// chan.postln;
	// src.postln;
	// "".postln;

	arg ...args;


	var val = args[0];
	val.postln;
	~vRate.do({
		arg synth, i;
		if(synth.notNil, {
			synth.set(\vRate, ((val/127)*10)); //STILL GOES UP TO 127 ??
		})
	})

},
(22)
))








