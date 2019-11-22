import { Transport, context }from 'tone';
import startAudioContext from 'startaudiocontext';
import connectSequencer from './Sequencer';
import { bassSynth, voiceSynth } from './synth_setup';


window.addEventListener('DOMContentLoaded', e => {
  startAudioContext(context, 'buttonElement').then(() => {
    const keyb = document.getElementById('keyb');

    keyb.addEventListener('changeBpm', e => {
      Transport.bpm.rampTo(e.detail.newBpm);
    });

    const voice = document.getElementById('voice');
    connectSequencer(voice, voiceSynth);

    const bass = document.getElementById('bass');
    connectSequencer(bass, bassSynth);
    Transport.start();
  });
});

