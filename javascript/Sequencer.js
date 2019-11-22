import { Frequency, Sequence, Draw }from 'tone';

export default (uiElement, synth) => {
  const seq = new Sequence((time, note, i) => {
    if (note != null) {
      Draw.schedule(() => {
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

  uiElement.addEventListener('posOn', e => {
    let freq = Frequency(e.detail.note, 'midi');
    freq.keyEle = e.target;
    seq.at([e.detail.pos], freq);
  })

  uiElement.addEventListener('posOff', e => {
    seq.at([e.detail.pos], null);
  })
}

