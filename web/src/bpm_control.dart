import 'dart:html';
import 'package:rxdart/rxdart.dart';

class BpmControl {
  String current = '120';
  DivElement keyboard;
  InputElement inputEle = NumberInputElement();
  DivElement ele = DivElement();

  BpmControl(this.keyboard){
    final change = Observable(inputEle.onChange);

    inputEle
        ..max = '420'
        ..min = '10'
        ..value = current;
    ele
        ..classes.add('bpm-input-container')
        ..append(inputEle)
        ..appendHtml('<label>BPM</label>');
   change
        .map((event) => event.target)
        .whereType<InputElement>()
        .map((inputElement) => (inputElement.value))
        .distinct()
        .where((value) => value.isNotEmpty)
        .debounceTime(const Duration(milliseconds: 200))
        .map((value) => dispatchChange(value))
    //I'm not sure why this listen needs to be here but it breaks without it
        .listen(null);
  }

  Future dispatchChange(String newValue) async {
    //current = inputEle.valueAsNumber;
    keyboard.dispatchEvent(CustomEvent("changeBpm", detail: {
        "newBpm": newValue
      }
    ));
  }
}
