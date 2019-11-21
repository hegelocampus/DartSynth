import Tone from 'tone';
import startAudioContext from 'startaudiocontext';
Tone.context.latencyHint = "playback";

const { Transport } = Tone;
const masterCompressor = new Tone.Compressor({
	"threshold" : -6,
	"ratio" : 3,
	"attack" : 0.5,
	"release" : 0.1
});
const lowBump = new Tone.Filter(200, "lowshelf");
Tone.Master.chain(lowBump, masterCompressor);
const synth = new Tone.Synth().toMaster();
//synth.voice0.oscillator.type = 'sawtooth2';
//synth.voice1.oscillator.type = 'fatsine';
//synth.harmonicity.value = -2;
//synth.vibratoRate.value = 1;
//synth.virbatoAmount = 0.5;
synth.oscillator.type = 'fatsine1';
//synth.sync();
//synth.oscillator.type = 'triangle';

const seq = new Tone.Sequence((time, note, i) => {
  if (note != null) {
    Tone.Draw.schedule(() => {
      let keyEle = note.keyEle;
      keyEle.classList.add("on");
      setTimeout(() => {
        keyEle.classList.remove("on");
      }, 200);
    }, time);
    synth.triggerAttackRelease(note, "4n", time);
  }
},
  [null, null, null, null, null, null, null, null],
  '4n'
)

seq.loop = true;
seq.start(0);
Transport.start();

//new Tone.Loop((time) => {
//  console.log(seq);
//  seq.start(0)
//},
//  '1m'
//);

window.addEventListener('DOMContentLoaded', e => {
  startAudioContext(Tone.context, 'buttonElement').then(() => {
    const keyb = document.getElementById('keyb');
    //const reverb = new Tone.Reverb(1.0).toMaster();
    //reverb.wet.value = 0.75;
    //const synth = new Tone.FMSynth().connect(reverb);
    //pattern.push(Tone.Frequency(e.detail.note, 'midi').transpose((0 - i) * 2));

    keyb.addEventListener('posOn', e => {
      let freq = Tone.Frequency(e.detail.note, 'midi');
      freq.keyEle = e.target;
      seq.at([e.detail.pos], freq);
    })

    keyb.addEventListener('posOff', e => {
      seq.at([e.detail.pos], null);
    })
  });
});

