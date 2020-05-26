/===========__.__===========//

//last_update@2505

//---------Junction_Setup-----------//

//send and receive through junction "__.__" under Experimental 1
//send and reveive pin: 9090
//p.s. Project name ASCII simulation of waterdrop, any better idea?


//---------Local_Setup-----------//

//normal
s.reboot;

// (//for Line or for others who uses other audio Device
// o = Server.local.options;
// o.outDevice = "Soundflower (2ch)";//or jack audio
// //o.outDevice = "Built-in Output";//back to normal
// o.numOutputBusChannels = 2;
// s.reboot;
// )

(//monitoring
s.scope;
s.meter;
)

//------Shared_variables_Setup--------//

n = NetAddr("127.0.0.1", 57140);

~waitTimeTap = 1;


//----------OSCDefs_Setup------------//

//chatroom
(
OSCdef(\chatroom,{|msg|
	postf("[Chatroom] % to %: %", msg[1],msg[2],msg[3]);
},'/shout');
)


//tap
(
OSCdef(\tap,{|msg|
	{
		 (~waitTimeTap/2).wait;
		// "[ _______________________ ]".postln;
		 (~waitTimeTap/2).wait;
		 ~t_receiv = Process.elapsedTime;
		~trip_time = (~t_receiv - ~t_send).postln;
		~jit_freq = ((~trip_time - ~waitTimeTap) * 900000 + 2000).postln;
		//msg[1..].postln;
		a = Synth(\tap,[\freq, ~jit_freq]);
		n.sendMsg("/tap","___________.___________");
	}.fork;
	~t_send = Process.elapsedTime;
},'/tap');
)


//pingpong(?)
//sine

~waitTimeSynth = 5;

OSCdef(\vib, {|msg|
	{

}.fork
}, '/vib');

//voice
//all OSCDefs should be in the same closure for easier execution



//---------SynthDefs_Setup-----------//

//tap
(
SynthDef(\tap,{
	arg amp= 0.2, freq = 1000;
	var env, sig;
	env = EnvGen.kr(Env([1,0],[0.01]),doneAction:2);
	sig = SinOsc.ar(freq).dup;
	Out.ar(0, sig*env*amp);
}).add;
)

//pingpong(?)
//sine

~waitTimeSynth = 5;

SynthDef(\vib,{
	arg freq=220, ack=2.5, dcy=0, rel=6, amp, gate=1, srtFreq=, endFreq, pan, out
	var env =
	var fenv =
	var mulchl = Mix.ar(SinOsc.ar(freq*[1, 3.33, 6.66, 0.89]))*0.25 * env;
	var sig = RLPF.ar(mulchl,fenv,0.9);
}).add);

// Synth FadeOut time. Not stoping it / how to stop the OSCmsg
// maybe something like this to control {SinOsc.ar(4400, 0, Line.kr(0.1,0,1,doneAction:2))}.play

/////////////////////////////////////////////////////////////

// Envelops
Env([1,0,1],[1,1]).plot // fängt bei 1 an, dauert 1 sek. bis zum 0 und geht nach 1 in 1. sek.
Env.linen(0.03,0.5,0.1).plot // Zeit-steuerte
Env.adsr(0.01, 0.5, 0.5, 0.1, 1, 0).plot // peak level ist Y max-value


({
	Saw.ar(EnvGen.kr(Env([10000,50,25,0],[0.5,1,3])),0.3)
}.play;)

//      https://composerprogrammer.com/teaching/supercollider/sctutorial/3.1%20Envelopes.html

/////////////////////////////////////////////////////////////

//voice
//mixer(?)



//----------Send_Message------------//

//Chat:
n.sendMsg("/shout", "Jia", "all", "Hello!");//"/shout","message from", "message to", "message". No more place!

//tap
(
n.sendMsg('tap',"___________.___________");
//~t_send = Process.elapsedTime;
)

//-----------Visual_Setup------------//

(

)//place holder for Line



//-----------check_out------------//
OSCdef.all