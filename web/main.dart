import 'dart:async';
import 'dart:html' as html;
import 'dart:math';
import './src/keyboard.dart';
import './src/bpm_control.dart';

Future<Null> main() async {
  var root = html.querySelector('#root');

  var keyboard = Keyboard("voice").renderKeyb();
  var bpmCtrl = BpmControl(keyboard).ele;
  var header = html.DivElement()
      ..classes.add('main-header')
      ..append(html.HeadingElement.h1()
          ..innerText = 'Dart Synth'
          )
      ..append(bpmCtrl);
  var footer = html.AnchorElement()
    ..classes.add('footer')
    ..href =  'https://github.com/hegelocampus/DartSynth'
    ..append(html.SpanElement()
        ..innerText = 'Created by Bee Ellis'
    );

  root
    ..append(header)
    ..append(keyboard)
    ..append(footer);
}

