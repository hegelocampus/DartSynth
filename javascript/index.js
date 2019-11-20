import Tone from 'tone';
import startAudioContext from 'startaudiocontext';
Tone.context.latencyHint = "playback";

const { Transport } = Tone;

const synth = new Tone.DuoSynth().toMaster();
synth.voice0.oscillator.type = 'sawtooth2';
synth.voice1.oscillator.type = 'triangle';
synth.harmonicity.value = -2;
synth.vibratoRate.value = 1;
synth.virbatoAmount = 0.5;
//synth.sync();
//synth.oscillator.type = 'triangle';

const seq = new Tone.Sequence((time, note, i) => {
  console.log(time);
  console.log(note);
  if (note != null) {
    synth.triggerAttackRelease(note, "8n", time);
    Tone.Draw.schedule(() => {
    }, time);
  }
},
  [null, null, null, null, null, null, null, null],
  '8n'
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
      console.log('clicked');
      seq.at([e.detail.pos], Tone.Frequency(62, 'midi'));
      console.log(seq);
    })

    keyb.addEventListener('posOff', e => {
      seq.at([e.detail.pos], null);
    })
  });
});

