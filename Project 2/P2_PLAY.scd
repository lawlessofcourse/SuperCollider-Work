
c = TempoClock.default
c.tempo = 80/60

Pdef(\yeahBass).play;
Pdef(\higher).play;
Pdef(\spurts).play; //Server fails after running for more than 30 seconds... why?
Pdef(\redBone).play;
Pdef(\wubalub).play;
Pdef(\rate, 6);



//Why does this keep happening?
/*FAILURE IN SERVER /s_new alloc failed, increase server's memory allocation (e.g. via ServerOptions)
FAILURE IN SERVER /n_set Node 5016 not found*/

//How do I fade out a SynthDef or Pdef externally? For example, I want to play the synth then choose when to fade it out on command. Basically: External Synth Control such as task routine or pdef/pbind.