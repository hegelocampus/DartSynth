import { Frequency, Sequence, Draw }from 'tone';

interface Synth {
  triggerAttackRelease(note: string, length: string, time: any);
}

interface CustomEvent extends Event {
  detail: { pos: string, note: string };
}

export default (uiElement: HTMLElement, synth: Synth) => {
  const seq = new Sequence((time, note) => {
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

  uiElement.addEventListener('posOn', (e: CustomEvent) => {
    let freq = Frequency(e.detail.note, 'midi');
    freq.keyEle = e.target;
    seq.at([e.detail.pos], freq);
  })

  uiElement.addEventListener('posOff', (e: CustomEvent) => {
    seq.at([e.detail.pos], null);
  })
}

