import { Transport, context, start as ToneStart } from 'tone';
import connectSequencer from './Sequencer';
import { bassSynth, voiceSynth } from './SynthSetup';

window.addEventListener('DOMContentLoaded', e => {
  let root;

  while (!root) {
    root = document.querySelector('#root');
  }

  root.addEventListener('modal-close', () => {
    ToneStart();

    const keyb = root.querySelector('#keyb');
    const voice = root.querySelector('#voice');
    const bass = root.querySelector('#bass');

    connectSequencer(voice, voiceSynth);
    connectSequencer(bass, bassSynth);

    keyb.addEventListener('changeBpm', e => {
      Transport.bpm.rampTo(e!.detail.newBpm);
    });

    Transport.start();
  });
});

