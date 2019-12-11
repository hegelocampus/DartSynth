import 'dart:html';
import './sequence_node.dart';

class Keyboard {
  String type;
  List<int> basePentatonic = const [9, 12, 14, 16, 19];
  List<int> seqPositions = const [0, 1, 2, 3, 4, 5, 6, 7];
  DivElement keyboardDiv = DivElement();
  DivElement voiceDiv = DivElement();
  DivElement bassDiv = DivElement();

  Keyboard(this.type) {
    voiceDiv
      ..classes.add('sequencer')
      ..id = 'voice';

    bassDiv
      ..classes.add('sequencer')
      ..id = 'bass';

    Iterable<int> bassNotes = parseNotes(0);
    Iterable<int> voiceNotes = parseNotes(5);

    seqPositions.forEach((pos) {
      voiceDiv.append(SeqNode(pos, voiceNotes).render());
      bassDiv.append(SeqNode(pos, bassNotes).render());
    });

    keyboardDiv
      ..id = 'keyb'
      ..append(voiceDiv)
      ..append(bassDiv);
  }

  Iterable<int> parseNotes(int o) {
    return basePentatonic.map((n) => n + (12 * o - 1));
  }

  DivElement renderKeyb() {
    return keyboardDiv;
  }
}

