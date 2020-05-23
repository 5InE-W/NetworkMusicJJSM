n = NetAddr("127.0.0.1", 57140);
NetAddr.langPort

s.reboot;

n.sendMsg("/timeCall","blue", TempoClock.default.beats);
(
OSCdef(\time,{|msg|
	msg.postln;
},'/timeCall',n)
)


n.sendMsg("/timeResponse","button","blue", TempoClock.default.beats);
(
OSCdef(\time,{|msg|
	msg.postln;
},'/timeResponse',n)
)

//
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
	arg amp= 0.2, freq = 100;
	var env, sig;
	env = EnvGen.kr(Env([1,0],[0.01]),doneAction:2);
	sig = SinOsc.ar(freq).dup;
	Out.ar(0, sig*env*amp);
}).add;
)

(
n.sendMsg('tap',"___________.___________ ");
~t_send = Process.elapsedTime;
)

///////////////////////////////// Variert von Jia_Tap
(OSCdef(\time, {|msg|
	{
		0.5.wait;
		" R E C E I V E ".postln;
		0.5.wait;
		~t_receiv = Process.elapsedTime;
		~travel_time = (~t_receiv - ~t_send).postln;
		~jit = (~trip_time * 0.01).postln;
		// question: if i save the jit in a var, and i could use the jit for later use? for instant, the change of freq.
		msg.postln;
		a = Synth(\syn, [\amp, ~jit]);
		n.sendMsg("/syn");
	}.fork;
	~t_send = Process.elaspsedTime;
}, '/syn');
SynthDef(\syn, {
	arg amp = 0.5, freq = 520;
	var env, sig;
	env = EnvGen.kr(Env.perc(0.01, 2.0), doneAction:2);
	sig = SinOsc.ar(freq).dup;
	Out.ar(0, sig * env * amp);
}).add;
)

(
n.sendMsg('/syn');
~t_send = Process.elapsedTime;
)

//////////////////// Michele

(
OSCdef(\timing, { | msg, time |  // the time argument will get the time-stamp + additional latency

	"recieved at: % \nscheduled at: % \ndelta: % \n\n".postf(Main.elapsedTime, time, time - Main.elapsedTime);  // print time difference (with string formating)

	// let's use an event to play the default Synth at the scheduled time:

	fork{

		(time - Main.elapsedTime).wait;  // wait for scheduling with latency compensation

		(
			\freq: msg[1],
			\dur: msg[2]
		).play;
	};

}, '/time')
)

n.sendBundle(1.0, ['/time', 400, 0.5]);  // use sendBundle to send osc-messages with time-stamps
