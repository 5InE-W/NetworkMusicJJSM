/==========Tap_Demonstration_Jia============//
n = NetAddr("127.0.0.1", 57140);
NetAddr.langPort
/////
s.reboot
s.scope
s.meter
/////
////////////Step1_setup_tap
(OSCdef(\tap,{|msg|
	{
	0.5.wait;
	"[ /tap, _______________________  ]".postln;
	0.5.wait;
	~t_receiv = Process.elapsedTime;
	~trip_time = (~t_receiv - ~t_send).postln;
	~jit = (~trip_time - 1 * 900000 + 2000).postln;
	msg.postln;
	a = Synth(\tap,[\freq, ~jit]);
	n.sendMsg("/tap","___________.___________ ");
	}.fork;
	~t_send = Process.elapsedTime;
},'/tap');
SynthDef(\tap,{
	arg amp= 0.2, freq = 1000;
	var env, sig;
	env = EnvGen.kr(Env([1,0],[0.01]),doneAction:2);
	sig = SinOsc.ar(freq).dup;
	Out.ar(0, sig*env*amp);
}).add;
)
////////////Step2_drop the first water drop
(
n.sendMsg('tap',"___________.___________ ");
~t_send = Process.elapsedTime;
)
////////////Step3_take away the wait time and "listen" to jitter
(OSCdef(\tap,{|msg|
	{
	~t_receiv = Process.elapsedTime;
	~trip_time = (~t_receiv - ~t_send).postln;
	~jit = (~trip_time * 10000000+2000).postln;
	msg.postln;
	a = Synth(\tap,[\freq, ~jit]);
	n.sendMsg("/tap","___________.___________ ");
	}.fork;
	~t_send = Process.elapsedTime;
},'/tap');
SynthDef(\tap,{
	arg amp= 0.2, freq = 1000;
	var env, sig;
	env = EnvGen.kr(Env([1,0],[0.01]),doneAction:2);
	sig = SinOsc.ar(freq).dup;
	Out.ar(0, sig*env*amp);
}).add;
)