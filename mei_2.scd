//Make A Random Poem From five different recordings.


s.boot // Boot the server, if you need to

// each one of us choose a file to play. read a whole sound into memory
b = Buffer.read(s,"/Users/s/Downloads/rikkyboy__the-poem-02.wav"); //change the path with the recording you choose
//b.play;

//Synthdefs for the recordings with effects
(
SynthDef(\echo_PlayBuf, {| out = 0, bufnum = 0 maxdelaytime = 0.2 , delaytime = 0.5, decaytime = 2 |
    Out.ar(out,
		CombN.ar(PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum), 1, 0, inf, doneAction: Done.freeSelf), maxdelaytime, delaytime,decaytime)
    )
}).add//(s, [\out, 0, \bufnum, b]);
)


(
SynthDef(\vary_PlayBuf, {| out = 0, bufnum = 0 rate = -1|
    Out.ar(out,
		   PlayBuf.ar(2,
			          bufnum,
			          BufRateScale.kr(bufnum)* rate ,  //varying playback speed by rate, multiply with 2, slow the speed.  multiply with negative number, reverse it
			          1,
			          0,
			          inf,
			          doneAction: Done.freeSelf)
    )
}).add//(s, [\out, 0, \bufnum, b]);
)

//x = Synth(\echo_PlayBuf);
//y = Synth(\vary_PlayBuf);



n = NetAddr ( "127.0.0.1" , 57140);
NetAddr.langPort


OSCFunc.trace(true)




(
OSCdef.new(
	\makeEcho,
	{ arg msg;
		//msg[1]:maxdelaytime, msg[2]:delaytime ,msg[3]:decaytime
		Synth.new(\echo_PlayBuf,
			[\maxdelaytime, msg[1],
				\delaytime, msg[2],
				\decaytime, msg[3],
				\bufnum, b,
			]);
}, '/makeEcho');
// )
//
// n.sendMsg('/makeEcho', 0.2, 0.5, 0.9);  // change the arg here to change the delay time
//
//
// (
OSCdef.new(
	\varySpeed,
	{ arg msg;
		//msg[1]:maxdelaytime, msg[2]:delaytime ,msg[3]:decaytime
		Synth.new(\vary_PlayBuf,
			[\rate, msg[1],
			 \bufnum, b,
			]);
}, '/varySpeed')
)

n.sendMsg('/varySpeed', -1);  // change the speed here, can be reversed with negative numbers.