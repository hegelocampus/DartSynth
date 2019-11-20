import 'dart:html';
//import 'package:stagexl/stagexl.dart';
import 'dart:math';

class Key {
  int seqPos;
  DivElement parentDiv;
  bool active = false;
  var keyDiv = DivElement();

  Key(this.seqPos, this.parentDiv);

  DivElement render() {
    this.keyDiv.className = 'seq-pos-${this.seqPos.toString()}';
    this.keyDiv.onMouseDown.listen(this.onClick);
    //this.onMouseUp.listen(this.setOff);
    //this.onMouseOut.listen(this.setOff);
    return this.keyDiv;
  }

  onClick(MouseEvent e) {
    if (this.active == false) {
      keyDiv.classes.add('active');
      this.active = true;
      this.parentDiv.dispatchEvent(CustomEvent("posOn", detail: {
        "pos": this.seqPos,
        "active": true
      }));
    } else {
      this.active = false;
      keyDiv.classes.remove('active');
      this.parentDiv.dispatchEvent(CustomEvent("posOff", detail: {
        "pos": this.seqPos,
        "active": false
      }));
    }
  }
}


class Keyboard {
  int octave;
  var keyboardDiv = DivElement();

  Keyboard(this.octave);

  DivElement renderKeyb() {
    //this.keyboardDiv.className = 'keyb';
    this.keyboardDiv.id = 'keyb';

    var seqPositions = [0, 1, 2, 3, 4, 5, 6, 7];
    for (var i = 0; i < seqPositions.length; i++) {
      this.keyboardDiv.append(Key(seqPositions[i], this.keyboardDiv).render());
    }
    return this.keyboardDiv;
  }
}

