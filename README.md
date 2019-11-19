## DartSynth
DartSynth is an interactive online analog synthesizer simulator that allows users to create digital sound-scapes with ease
## Technologies
- `Dart`
  - Dart very similar to `JS` so picking it up will be a breeze
  - It also allows for JavaScript interoperability, so if there is anyplace where I am unable to figure out how to write something in Dart I can easily just do so in `JavaScript` and then import it into the main Dart files
  - Dart is the language that powers flutter, an increasingly popular mobile app framework created by Google, this will allow for me to effortlessly write a mobile port for my completed application
  - When creating a production web app dart provides the `dart2js` tool to quickly and easily compile my project into web-optimized vanilla JavaScript code
- `Canvas`
  - Canvas manipulation in Dart is nearly identical with how it is done in `JS`, all you need to do is import the core `html` Dart library and then construct a Canvas element like so: `var canvas = html.CanvasElement();`
- `tone.js`
  - This library allows for me to render components that interactively manipulate sounds, this library will be a fundamental piece of this project

