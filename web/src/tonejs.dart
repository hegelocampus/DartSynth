@JS('Tone')
library tone.js;

import 'dart:html';
import 'package:js/js.dart';

typedef Func0<R> = R Function();
typedef Func1<A, R> = R Function(A a);
typedef Func1Opt1<A, R> = R Function([A a]);

@JS()
class Tone {
  Tone.fakeConstructor$();
  external factory Tone();
  external Function get Synth;
  external set Synth(Func0<dynamic> v);
}

@JS('Tone.Synth')
class Synth {
  Synth.fakeConstructor$();
  external factory Synth();
  external Function get toMaster;
  external set toMaster(Func0<dynamic> v);

  external void triggerAttack(num note, num time, num velocity);
  external void triggerRelease({num time = null});
  //external Function get triggerAttack;
  //external set triggerAttack(Func1<dynamic, List<dynamic >> v);
  //external Function get triggerRelease;
  //external set triggerRelease(Func1<dynamic, List<dynamic >> v);
}

