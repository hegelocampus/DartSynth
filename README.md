## DartSynth
DartSynth is an interactive online analog synthesizer simulator that allows users to create digital sound-scapes with ease  
  
[**Link to live site**](https://dartsynth.firebaseapp.com/)
![Screenshot of webpage](/readme_assets/dartsynth.png)
### MVP
- Vocal range sequencer
- Bass range sequencer
- User interface to change the BPM of the sequencers
### Technologies
- `tone.js`
  - The `tone.js` library is a fundamental piece of this project, it provides the base synthesizers and timing that is used in this application.
- `Dart`
  - Dart's similarities to JavaScript allowed me to quickly pick it up throughout the creation of this application
  - Although Dart allows for JavaScript interoperability, I elected to not use it in favor of creating custom events that are triggered by the dart UI elements.
  - Dart is the language that powers flutter, an increasingly popular mobile app framework created by Google, this will allow for me to effortlessly write a mobile port for my completed application
- `JavaScript`
  - I setup event listeners for the custom events in my JavaScript audio components. These event listeners adjusted the sequencers based on information sent through the custom events.
