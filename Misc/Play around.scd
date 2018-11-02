

a = Pbind().play;

a.dump
a.stop;

c = TempoClock.default
c.tempo = 140/60


//
a = Pbind(\freq, 200).play;
a = Pbind(\midinote, 80).play;
a = Pbind(\note, 0).play;

a = Pbind(\note, 0, \octave, 4).play;
a = Pbind(\note, 0, \ctranspose, 8).play;

a = Pbind(\note, Pseq([0 ,0, 7, 7, 9, 9, 7, 7, 5, 5, 3, 3, 2, 2, 0, 0], inf)).play;


(
a = Pbind(
	\note,Pseq([0 ,0, 7, 7, 9, 9, 7, 7, 5, 5, 3, 3, 2, 2, 0, 0], inf),
	\octave, Pseq([0, 2], inf)

).play;
)

a = Pbind(\note, Pseq([[0,7], [0,5],[0,1]], inf)).play;

(
SynthDef(\help_battrack2, { |out|
    var trackb, trackh, trackq, tempo;
    var source;
    var bsound, hsound, qsound;

    source = SoundIn.ar(0);

    #trackb, trackh, trackq, tempo = BeatTrack.kr(FFT(LocalBuf(1024)));

    bsound = Pan2.ar(LPF.ar(WhiteNoise.ar * Decay.kr(trackb, 0.05), 1000), 0.0);

    hsound = Pan2.ar(BPF.ar(WhiteNoise.ar * Decay.kr(trackh, 0.05), 3000, 0.66), -0.5);

    qsound = Pan2.ar(HPF.ar(WhiteNoise.ar * Decay.kr(trackq, 0.05),5000), 0.5);

    Out.ar(out, bsound + hsound + qsound);
}).play;
)