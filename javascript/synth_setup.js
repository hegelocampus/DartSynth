import Tone from 'tone'

Tone.context.latencyHint = "playback";

//Master touch-up
const masterCompressor = new Tone.Compressor({
  "threshold" : -6,
  "ratio" : 3,
  "attack" : 0.5,
  "release" : 0.1
});
const lowBump = new Tone.Filter(200, "lowshelf");
Tone.Master.chain(lowBump, masterCompressor);
Tone.Master.volume.value = 0.7;

//vocal effects
const delay = new Tone.FeedbackDelay(0.01, 0.01);
delay.wet.value = 0.01;
const reverb = new Tone.Reverb(0.001)
reverb.wet.value = 0.001;
reverb.generate();
const cheby = new Tone.Chebyshev({
  order: 7,
  oversample: 'none'
}).chain(Tone.Master);
cheby.wet.value = 0.02;

//bass effects
const bitCrush = new Tone.BitCrusher(7);
const bassChorus = new Tone.Chorus();

//Synth Setup
const voiceSynth = new Tone.Synth({
  oscillator: {
    type: 'fatsine1'
  }
}).connect(cheby);

const bassSynth = new Tone.Synth().toMaster();
bassSynth.oscillator.type = 'sine2';

export { bassSynth, voiceSynth };

