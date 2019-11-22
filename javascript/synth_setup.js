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

//const reverb = new Tone.Reverb(1.0).toMaster();
//reverb.wet.value = 0.75;
//const synth = new Tone.FMSynth().connect(reverb);
//pattern.push(Tone.Frequency(e.detail.note, 'midi').transpose((0 - i) * 2));

//vocal effects
const reverb = new Tone.Reverb(2.0).toMaster();
reverb.wet.value = 0.75;

//bass effects
const bitCrush = new Tone.BitCrusher(7);
const bassChorus = new Tone.Chorus();
const bassComp = new Tone.Compressor({
	"threshold" : -20,
	"ratio" : 8,
	"attack" : 0.003,
	"release" : 0.25
}).chain(bitCrush, bassChorus).toMaster();

//Synth Setup
const voiceSynth = new Tone.Synth().connect(reverb);
voiceSynth.oscillator.type = 'fatsine1';
const bassSynth = new Tone.Synth().connect(bassComp);
bassSynth.oscillator.type = 'sine1';

export { bassSynth, voiceSynth };

