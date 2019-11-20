import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'dart:math';
import './src/keyboard.dart';

Future<Null> main() async {
  var renderLoop = RenderLoop();

  var root = html.querySelector('#root');
  var keyboard = Keyboard(6);
  root.append(keyboard.renderKeyb());
}

