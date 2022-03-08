(
  SynthDef(\sample, { |out=0 buf, amp = 1, rate = 1, start = 0, finish = 1 atk = 0.01 rel = 0.01 pan=0|
			var sig;
			var pos = BufFrames.kr(buf) * start;
			var casCeleho = BufFrames.kr(buf) / 44100;
			var casFragmentu = (finish - start) * casCeleho;
			var env = EnvGen.kr(Env( [ 0,1,1,0 ], [ atk, casFragmentu-atk-rel, rel ],[3,0,-3]   ), doneAction:2);
			sig = PlayBuf.ar(1, buf, rate, startPos: pos);
			sig = sig * env * amp;
			Out.ar(out, Pan2.ar(sig, pan) );
	}).add;
)
