import 'dart:html';
import 'dart:math';
import './sequence_node.dart';

class Keyboard {
  int octave;
  var keyboardDiv = DivElement();

  Keyboard(this.octave);

  DivElement renderKeyb() {
    //this.keyboardDiv.className = 'keyb';
    this.keyboardDiv.id = 'keyb';

    var seqPositions = [0, 1, 2, 3, 4, 5, 6, 7];
    for (var i = 0; i < seqPositions.length; i++) {
      this.keyboardDiv.append(SeqNode(seqPositions[i]).render());
    }
    return this.keyboardDiv;
  }
}

