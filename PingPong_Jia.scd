/// Step 0 send & receiv in OSC junction

// *Receive* from Junction
// Adress: 127.0.01
// Port: 57120 (NetAddr.langPort)
// *Send* to Junction
// Port: 57140 (leave Reply-Address and Reply-Port empty)

n = NetAddr("127.0.0.1", 57140);
NetAddr.langPort

///
s.reboot
s.scope
s.meter
///

///////////Step1_setup_ping
(OSCdef(\ping,{|msg|
	{
	1.wait;
	msg.postln;
	a = Synth(\ping);
	n.sendMsg("/pong","          _")
	}.fork;
},'/ping');
SynthDef(\ping,{
	arg amp= 0.5;
	var env, sig;
	env = EnvGen.kr(Env([1,0],[0.01]),doneAction:2);
	sig = SinOsc.ar(1000);
	Out.ar(0, sig*env*amp);
}).add;
)
////////////Step2_setup_pong
(OSCdef(\pong,{|msg|
	{
	1.wait;
	msg.postln;
	a = Synth(\pong);
	n.sendMsg("/ping","_          ")
	}.fork;
},'/pong');
SynthDef(\pong,{
	arg amp= 0.5;
	var env, sig;
	env = EnvGen.kr(Env([1,0],[0.01]),doneAction:2);
	sig = SinOsc.ar(800);
	Out.ar(0, sig*env*amp);
}).add;
)
////////////Step3_los!
n.sendMsg('ping',"_          ")

////////////Step4_delete the wait time to hear how quick it could really be!
(OSCdef(\ping,{|msg|
	msg.postln;
	a = Synth(\ping);
	n.sendMsg("/pong","pong")
},'/ping');
//
SynthDef(\ping,{
	arg amp= 0.5;
	var env, sig;
	env = EnvGen.kr(Env([1,0],[0.01]),doneAction:2);
	sig = SinOsc.ar(1000);
	Out.ar(0, sig*env*amp);
}).add;
)