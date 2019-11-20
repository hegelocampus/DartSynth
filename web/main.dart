import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'dart:math';
import './src/keyboard.dart';

Future<Null> main() async {
  StageOptions options = StageOptions()
    ..backgroundColor = Color.Coral
    ..renderEngine = RenderEngine.WebGL;

  var canvas = html.querySelector('#stage');
  var stage = Stage(canvas, width: 1280, height: 800, options: options);

  var renderLoop = RenderLoop();
  renderLoop.addStage(stage);

  var resourceManager = ResourceManager();
  resourceManager.addBitmapData("dart", "images/dart@1x.png");

  await resourceManager.load();

  var keyboard = Keyboard(9, pos: [10, 20]);
  keyboard.renderKeyb();
  stage.addChild(keyboard);
}

