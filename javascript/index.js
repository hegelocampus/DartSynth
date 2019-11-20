import Tone from 'tone';
import startAudioContext from 'startaudiocontext';
Tone.context.latencyHint = "balanced";

const { Transport } = Tone;

window.addEventListener('DOMContentLoaded', e => {
  startAudioContext(Tone.context, 'buttonElement').then(() => {
    //const reverb = new Tone.Reverb(1.0).toMaster();
    //reverb.wet.value = 0.75;
    //const synth = new Tone.FMSynth().connect(reverb);
    const synth = new Tone.Synth().toMaster();
    synth.oscillator.type = 'sine';
    synth.sync();
    const stage = document.getElementById('stage');

    let queue = null;
    const loop = new Tone.Loop(time => {
      console.log('loop');
      if (queue == null) {
        queue.start(time);
        let next = queue.pop();
        synth.triggerAttackRelease(next, "4n");
      }
    }, "1:0:0").start(0);
    Transport.start();

    //Transport.schedule(time => {
    //  if (currPattern) {
    //    currPattern.start(time);
    //  }
    //});

    document.addEventListener('keyOn', e => {
      let pattern = [];
      for (let i = 0; i < 4; i++) {
        queue.push(Tone.Frequency(e.detail.note).transpose((0 - i) * 2));
      }
      console.log(pattern);
      //current = new Tone.Pattern(
      //  (time, note) => {
      //    console.log(note);
      //    synth.triggerAttackRelease(note, "4n");
      //  },
      //  pattern
      //);
      //current.playbackRate = 2;
      //current.interval = "4n";
      //current.iterations = pattern.length;
      //Transport.schedule(time => current.start(time));
    })

    //TODO: Transition this over to use queue instead of current
    document.addEventListener('keyOff', e => {
      console.log(current);
      if (current) {
        current.stop();
        Transport.schedule(time => {
          (time, note) => synth.triggerRelease();
        });
      }
    })
  });
});

