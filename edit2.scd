n = NetAddr("127.0.0.1", 57140);
NetAddr.langPort

//
s.reboot
s.scope
s.meter
//

q = "Shu"

(OSCdef(\bass,{|msg|
{
		1.wait;
		msg.postln;
		a = Synth(\bass);
		{if(q == "Mei",{"just recieving".postln;},{n.sendMsg("/bass2"); "Mei".postln;})};
	}.fork
}, '/bass');


SynthDef(\bass,{|freq=840.5,ackT=0.55,relsT=5.3,srtFrq=746.648,endFreq=210,amp=0.25, pan=([-0.33,0.33])|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(SinOsc.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)

//OSCdef(\test).add( { "-- i'm the output of another function --".postln } );
////////////////////////////////////////////////

(OSCdef(\bass2,{|msg|
{
		1.wait;
		msg.postln;
		a = Synth(\bass2);
		{if(q == "Jia",{"just recieving".postln;},{n.sendMsg("/bass3"); "Jia".postln;})};
	}.fork
}, '/bass2');

SynthDef(\bass2,{|freq=842,ackT=0.26,relsT=6.5876,srtFrq=747.71464,endFreq=233.65732,amp=0.05, pan=([-0.5,0.5])|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(SinOsc.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)

////////////////////////////////////////////////

(OSCdef(\bass3,{|msg|
{
		1.wait;
		msg.postln;
		a = Synth(\bass3);
		{if(q == "Line",{"just recieving".postln;},{n.sendMsg("/bass4"); "Line".postln;})};
	}.fork
}, '/bass3');

SynthDef(\bass3,{|freq=842.4,ackT=0.975,relsT=7.95,srtFrq=753.58116,endFreq=235.49058,amp=0.05, pan=([-0.66,0.66])|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(SinOsc.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)

///////////////////////////////////////////////

(OSCdef(\bass4,{|msg|
{
		1.wait;
		msg.postln;
		a = Synth(\bass4);
		{if(q == "Shu",{"just recieving".postln;},{n.sendMsg("/bass"); "Shu".postln;})};
	}.fork
}, '/bass4');

SynthDef(\bass4,{|freq=840,ackT=1.84,relsT=6.1752,srtFrq=749.3146,endFreq=234.1573,amp=0.15, pan=([-1,0])|

	var env = EnvGen.ar(Env.perc(ackT,relsT),doneAction:2);
	var fenv = XLine.ar(srtFrq,endFreq,relsT/2);
	var sig = Mix.ar(SinOsc.ar(freq*[1,1.01,0.997]))*0.33333 * env;
	sig = RLPF.ar(sig, fenv, 0.9);
	Out.ar(0,Pan2.ar(sig, pan)*amp);
}).add;
)

//////////////////////////////////////////////

n.sendMsg('/bass');
n.sendMsg('/bass2');
n.sendMsg('/bass3');
n.sendMsg('/bass4');
