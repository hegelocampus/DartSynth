import 'dart:html';
import 'dart:math';
import './sequence_node.dart';

class Keyboard {
  String type;
  List<int> basePentatonic = const [9, 12, 14, 16, 19];
  //List<int> voiceNotes = const [69, 72, 74, 76, 79];
  //List<int> bassNotes = const [33, 36, 38, 40, 43];
  //List<int> bassNotes = const [21, 24, 26, 28, 31];

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
    print(bassNotes);
    print(voiceNotes);

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

