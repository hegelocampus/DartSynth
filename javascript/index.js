import { Transport, context, start as ToneStart }from 'tone';
import startAudioContext from 'startaudiocontext';
import connectSequencer from './Sequencer';
import { bassSynth, voiceSynth } from './synth_setup';


const waitForLoad = async () => {
  if ((!document.getElementById('voice')) && (!document.getElementById('bass'))) {
    await window.requestAnimationFrame(waitForLoad);
  }else {
    return;
  }
}

window.addEventListener('DOMContentLoaded', e => {
  document.querySelector('#root').addEventListener('modal-close', () => {
    ToneStart();

    const keyb = document.getElementById('root');
    const voice = keyb.querySelector('#voice');
    const bass = document.querySelector('#bass');

    connectSequencer(voice, voiceSynth);
    connectSequencer(bass, bassSynth);

    keyb.addEventListener('changeBpm', e => {
      Transport.bpm.rampTo(e.detail.newBpm);
    });

    Transport.start();
  });
});

