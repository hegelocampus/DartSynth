import 'dart:async';
import 'dart:html' as html;
import 'dart:math';
import './src/intro_modal.dart';
import './src/keyboard.dart';
import './src/bpm_control.dart';

Future<Null> main() async {
  var root = html.querySelector('#root');

  var keyboard = Keyboard("voice").render;
  var bpmCtrl = BpmControl(keyboard).ele;

  var header = html.DivElement()
      ..classes.add('main-header')
      ..append(html.HeadingElement.h1()
          ..innerText = 'Dart Synth'
      )
      ..append(bpmCtrl);

  var footer = html.DivElement()
      ..classes.add('footer')
      ..append(html.AnchorElement()
        ..classes.add('personal-site-anchor')
        ..href =  'https://bellis.dev'
        ..append(html.SpanElement()
          ..innerText = 'Created by Bee Ellis'
        )
      )
      ..append(html.AnchorElement()
        ..classes.add('github-anchor')
        ..href =  'https://github.com/hegelocampus/DartSynth'
        ..append(html.SpanElement()
          ..classes.addAll(['fab', 'fa-github'])
        )
      );

  root
      ..append(IntroModal().render)
      ..append(header)
      ..append(keyboard)
      ..append(footer);
}

