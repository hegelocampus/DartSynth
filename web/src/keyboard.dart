import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

import './tonejs.dart';

class Key {
  int note;

  Key(int note);

  void _renderKey(String note) {
  }
}

abstract class Octave implements Key {
  factory Octave(int octave) {

  }
  int get note;
}

class Keyboard implements Octave {
  html.CanvasElement parent;

  Keyboard(html.CanvasElement parent);

}

