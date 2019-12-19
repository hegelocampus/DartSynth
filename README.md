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
  - The `tone.js` library is a fundamental piece of this project, it provides the base synthesizers and timing that is used in this application.
- `Dart`
  - Dart's similarities to JavaScript allowed me to quickly pick it up throughout the creation of this application
  - Although Dart allows for JavaScript interoperability, I elected to not use it in favor of creating custom events that are triggered by the dart UI elements.
  - Dart is the language that powers flutter, an increasingly popular mobile app framework created by Google, this will allow for me to effortlessly write a mobile port for my completed application
- `JavaScript`
  - I setup event listeners for the custom events in my JavaScript audio components. These event listeners adjusted the sequencers based on information sent through the custom events.
### Code Snippets
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
