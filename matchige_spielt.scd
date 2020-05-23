n = NetAddr("127.0.0.1", 57140);
NetAddr.langPort

//
s.reboot
s.scope
s.meter
//

(OSCdef(\bass,{|msg|

		msg.postln;
		a = Synth(\bass);
		n.sendMsg("/bass2")

}, '/bass');


SynthDef(\bass,{|freq=240,ackT=0.05,relsT=5.3,srtFrq=502,endFreq=120,amp=0.1, pan=0|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(Saw.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)
////////////////////////////////////////////////

(
OSCdef(\bass2,{|msg|

		msg.postln;
		a = Synth(\bass2);
		n.sendMsg("/bass3")

}, '/bass2');

SynthDef(\bass2,{|freq=240.2,ackT=6.2,relsT=12.8,srtFrq=450,endFreq=150,amp=0.1, pan=1|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(SinOsc.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)

////////////////////////////////////////////////

(
OSCdef(\bass3,{|msg|

		msg.postln;
		a = Synth(\bass3);
		n.sendMsg("/bass4")

}, '/bass3');

SynthDef(\bass3,{|freq=240.3,ackT=5.04,relsT=10,srtFrq=100,endFreq=250,amp=0.1, pan=0|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(SinOsc.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)

///////////////////////////////////////////////

(
OSCdef(\bass4,{|msg|

		msg.postln;
		a = Synth(\bass4);
		n.sendMsg("/bass")

}, '/bass4');

SynthDef(\bass4,{|freq=240.5,ackT=2.01,relsT=4.2,srtFrq=200,endFreq=80,amp=0.1, pan=1|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(SinOsc.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)

//////////////////////////////////////////////

n.sendMsg('/bass');