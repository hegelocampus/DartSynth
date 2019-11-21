import 'dart:html';

class Note {
  bool active = false;
  int seqPos;
  DivElement noteDiv = DivElement();
  num note;

  Note(this.seqPos, this.note) {
    this.noteDiv
      ..classes.add('note-${note}')
      ..classes.add('note-pos-${this.seqPos}')
      ..onMouseDown.listen(clickHandler(note, this.noteDiv));
  }

  Function clickHandler(num note, DivElement noteDiv) => (MouseEvent e) {
    if (!this.active) {
      active = true;
      noteDiv
        ..classes.add('active')
        ..dispatchEvent(CustomEvent("posOn", detail: {
          "pos": this.seqPos,
          "note": note,
          "active": true
        }));
    } else {
      active = false;
      noteDiv
        ..classes.remove('active')
        ..dispatchEvent(CustomEvent("posOff", detail: {
          "pos": this.seqPos,
          "note": note,
          "active": false
        }));
    }
  };
}

class SeqNode {
  int seqPos;
  List<num> notes = const [69, 72, 74, 76, 79];
  DivElement activeKey = null;
  DivElement seqDiv = DivElement();

  SeqNode(this.seqPos) {
    this.seqDiv
      ..className = 'seq-pos-${this.seqPos.toString()}';
    this.addNotes();
  }

  DivElement render() {
    return this.seqDiv;
  }

  void addNotes() {
    notes.forEach((note) => seqDiv.append(Note(this.seqPos, note).noteDiv));
  }
}

