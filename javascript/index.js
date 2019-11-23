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
  document.querySelector('#root').addEventListener('click', () => {
    ToneStart()
    const keyb = document.getElementById('root');

    keyb.addEventListener('changeBpm', e => {
      Transport.bpm.rampTo(e.detail.newBpm);
    });

    const voice = keyb.querySelector('#voice');
    connectSequencer(voice, voiceSynth);

    const bass = document.querySelector('#bass');
    connectSequencer(bass, bassSynth);
    Transport.start();
  });
});

