import 'dart:html';

class IntroModal {
  final DivElement contentSection = DivElement();
  final DivElement modalScreen = DivElement();

  IntroModal() {
    contentSection
        ..classes.add('modal-content-section')
        ..append(HeadingElement.h2()
            ..innerText = 'Click on a tile to add its corresponding note to the sequencer'
            ..classes.addAll(['modal-inst', 'tile-inst'])
        )
        ..append(HeadingElement.h3()
            ..innerText = 'Click anywhere to continue'
            ..classes.addAll(['modal-inst', 'modal-continue'])
        );
    modalScreen
        ..append(contentSection)
        ..classes.addAll(['modal-screen', 'modal-open'])
        ..onMouseDown.listen(clickHandler());
  }

  Function clickHandler() => (MouseEvent e) {
    e.stopPropagation();
    modalScreen
        ..classes.remove('modal-open')
        ..dispatchEvent(CustomEvent('modal-close', detail: {
          "start": true
        }));
  };

  DivElement get render {
    return modalScreen;
  }
}

