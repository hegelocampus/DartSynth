import 'dart:html';
import 'dart:math';
import './sequence_node.dart';

class Keyboard {
  int octave;
  List<int> seqPositions = const [0, 1, 2, 3, 4, 5, 6, 7];
  var keyboardDiv = DivElement();

  Keyboard(this.octave) {
    keyboardDiv.id = 'keyb';
    keyboardDiv.classes.add('sequencer');

    for (var i = 0; i < seqPositions.length; i++) {
      keyboardDiv.append(SeqNode(seqPositions[i]).render());
    }
  }

  DivElement renderKeyb() {
    return keyboardDiv;
  }
}

