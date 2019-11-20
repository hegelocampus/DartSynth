import 'dart:html';
import 'package:stagexl/stagexl.dart';
import 'dart:math';

class Key extends Sprite{
  num note;
  List pos;
  bool active = false;

  Key(this.note, this.pos)
    : super();

  DisplayObject display() {
    this.graphics
      ..rect(pos[0], pos[1], 60, 300)
      ..strokeColor(Color.Black)
      ..fillColor(Color.White);

    this.name = this.note.toString();
    this.onMouseDown.listen(this.setOn);
    this.onMouseUp.listen(this.setOff);
    this.onMouseOut.listen(this.setOff);
    return this;
  }

  setOn(MouseEvent e) {
    this.active = true;
    var octaveNumber = (this.note / 12).round();
    document.dispatchEvent(CustomEvent("keyOn", detail: {
      "note": this.note,
      "active": true
    }));
  }

  setOff(MouseEvent e) {
    if (this.active) {
      this.active = false;
      document.dispatchEvent(CustomEvent("keyOff", detail: {
        "note": this.note,
        "active": false
      }));
    }
  }
}

class Keyboard extends Sprite {
  List pos = [30, 50];
  int octave;

  Keyboard(this.octave, {this.pos})
    : super();

  Sprite renderKeyb() {
    var startNote = 12 * this.octave;
    var startPos = pos[0];
    var whiteNotes = [0, 2, 4, 5, 7, 9, 11];
    var blackNotes = [0, 1, 3, 0, 6, 8, 10, 0].map((note) {
      if (note > 0) {
        return Key(note + startNote, [1, 1]);
      } else {
        return Key(0, [1, 1]);
      }
    });
    var nextPos = startPos;
    for (var i = 0; i < whiteNotes.length; i++) {
      nextPos = nextPos + 63;
      this.addChild(Key(whiteNotes[i] + startNote, [nextPos, pos[1]]).display());
    }
  }
}

