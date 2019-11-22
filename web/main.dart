import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'dart:math';
import './src/keyboard.dart';

Future<Null> main() async {
  var root = html.querySelector('#root');

  var keyboard = Keyboard("voice").renderKeyb();
  var header = html.HeadingElement.h1()
    ..innerText = 'Dart Synth'
    ..classes.add('main-header');
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

