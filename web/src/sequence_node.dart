import 'dart:html';

class Note {
  bool active = false;
  int seqPos;
  Function setActiveKey;
  DivElement noteDiv = DivElement();
  num note;

  Note(this.seqPos, this.note, this.setActiveKey) {
    this.noteDiv
      ..classes.add('note-${note}')
      ..classes.add('note-pos-${this.seqPos}')
      ..onMouseDown.listen(clickHandler(note, this.noteDiv));
  }

  Function clickHandler(num note, DivElement noteDiv) => (MouseEvent e) {
    if (!this.active) {
      setActiveKey(this);
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
  Iterable<int> notes;
  Note activeKey = null;
  DivElement seqDiv = DivElement();

  SeqNode(this.seqPos, this.notes) {
    this.seqDiv
      ..className = 'seq-pos-${this.seqPos.toString()}';
    this.notes.forEach((note) => seqDiv
      ..append(Note(this.seqPos, note, setActiveKey).noteDiv));
  }

  void setActiveKey(Note newNote) {
    if (activeKey != null) {
      activeKey
        ..noteDiv.classes.remove('active')
        ..active = false;
    }
    activeKey = newNote;
  }

  DivElement render() {
    return this.seqDiv;
  }
}

