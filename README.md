## DartSynth
DartSynth is an interactive online analog synthesizer simulator that allows users to create digital sound-scapes with ease  
  
[**Link to live site**](https://dartsynth.firebaseapp.com/)
![Screenshot of webpage](/readme_assets/populated.png)
### Features
- Vocal range sequencer
- Bass range sequencer
- User interface to change the BPM of the sequencers without causing jarring audio transitions
### Technologies
- `tone.js`
  - The [`tone.js`](https://github.com/Tonejs/Tone.js) library is a fundamental piece of this project, it provides the base synthesizers and timing that is used in this application.
- `Dart`
  - Dart's similarities to JavaScript allowed me to quickly pick it up throughout the creation of this application
  - Although Dart allows for JavaScript interoperability, I elected to not use it in favor of creating custom events that are triggered by the dart UI elements.
  - Dart is the language that powers flutter, an increasingly popular mobile app framework created by Google, this will allow for me to effortlessly write a mobile port for my completed application
- `JavaScript`
  - I setup event listeners for the custom events in my JavaScript audio components. These event listeners adjusted the sequencers based on information sent through the custom events.
### Code Snippets
#### Keyboard Class Component
Using Dart made for incredibly intuitive construction of HTML components. In this section a div is created to act as the main sequencer container and then a grid is rendered that holds values deduced from the pentatonic scale, ensuring that almost combination of notes will sound good together. This functions to make it significantly easier for someone with no music making experience to make a great beat, while still creating something usable for experienced musicians.
```dart
class Keyboard {
  String type;
  List<int> basePentatonic = const [9, 12, 14, 16, 19];
  List<int> seqPositions = const [0, 1, 2, 3, 4, 5, 6, 7];
  DivElement keyboardDiv = DivElement();
  DivElement voiceDiv = DivElement();
  DivElement bassDiv = DivElement();

  Keyboard(this.type) {
    voiceDiv
      ..classes.add('sequencer')
      ..id = 'voice';

    bassDiv
      ..classes.add('sequencer')
      ..id = 'bass';

    Iterable<int> bassNotes = parseNotes(0);
    Iterable<int> voiceNotes = parseNotes(5);

    seqPositions.forEach((pos) {
      voiceDiv.append(SeqNode(pos, voiceNotes).render());
      bassDiv.append(SeqNode(pos, bassNotes).render());
    });

    keyboardDiv
      ..id = 'keyb'
      ..append(voiceDiv)
      ..append(bassDiv);
  }

  Iterable<int> parseNotes(int o) {
    return basePentatonic.map((n) => n + (12 * o - 1));
  }

  DivElement renderKeyb() {
    return keyboardDiv;
  }
}
```
#### Interface Between Dart and Tone.js Library
On of the challenges that had to be overcome while making this app was trying to integrate the incredibly robust [`tone.js`](https://github.com/Tonejs/Tone.js) library into a Dart application. To make the integration of this third party library possible, an interface between the Tone.js library and Dart components was engineered through dispatching custom DOM events with Dart, and intercepting them with JavaScript, expediting application development through bypassing the pricey alternative of porting the Tone.js library to Dart.

In the following snippet, a callback is being assigned to the `onMouseDown` event listener that will dispatch the custom `posOn` event that contains the sequence position in the synthesizer and the midi value of the note that should be triggered.
```dart
class Note {
  bool active = false;
  int seqPos;
  Function setActiveKey;
  DivElement noteDiv = DivElement();
  num note;

  Note(this.seqPos, this.note, this.setActiveKey) {
    this.noteDiv
      ..classes.add('note-${note}')
      ..classes.add('note-pos-${this.seqPos}')
      ..onMouseDown.listen(clickHandler(note, this.noteDiv));
  }

  Function clickHandler(num note, DivElement noteDiv) => (MouseEvent e) {
    if (!this.active) {
      setActiveKey(this);
      active = true;
      noteDiv
        ..classes.add('active')
        ..dispatchEvent(CustomEvent("posOn", detail: {
          "pos": this.seqPos,
          "note": note
        }));
    } else {
      active = false;
      noteDiv
        ..classes.remove('active')
        ..dispatchEvent(CustomEvent("posOff", detail: {
          "pos": this.seqPos,
          "note": note
        }));
    }
  };
}
```
In order to intercept that custom event the following event listener is added to each of the independent sequencers (e.g., the bass and voice sequencers). This event listener has a callback where a `Frequency` object is constructed with the desired midi value, and then a custom property of `keyEle` is attached to the frequency. The later step is likely an unintended use of the `Frequency` object as it was constructed by the author of the `Tone.js` library. But, this was required in this instance in order to append the `active` class onto the HTML element, which would have been otherwise impossible to deduce within the `Sequence` callback, which lacks an index parameter.
```dart
export default (uiElement, synth) => {
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

  uiElement.addEventListener('posOn', e => {
    let freq = Frequency(e.detail.note, 'midi');
    freq.keyEle = e.target;
    seq.at([e.detail.pos], freq);
  })

  uiElement.addEventListener('posOff', e => {
    seq.at([e.detail.pos], null);
  })
}
```

