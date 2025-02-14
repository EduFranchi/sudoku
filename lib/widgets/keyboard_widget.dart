import 'package:flutter/material.dart';
import 'package:sudoku/widgets/number_widget.dart';

class KeyboardWidget extends StatelessWidget {
  final double sizeBox;
  final double sizeMediumSquare;
  final void Function(int value) callbackClicked;

  const KeyboardWidget({
    super.key,
    required this.sizeBox,
    required this.sizeMediumSquare,
    required this.callbackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeBox,
      height: sizeBox,
      child: _getNumbersWidget(),
    );
  }

  Widget _getNumbersWidget() {
    List<Widget> rowList = [];
    int count = 0;
    for (int x = 0; x < 3; x++) {
      List<Widget> columnList = [];
      for (int y = 0; y < 3; y++) {
        count++;
        columnList.add(
          NumberWidget(
            sizeBox: sizeBox,
            sizeMediumSquare: sizeMediumSquare,
            value: count,
            callbackClicked: callbackClicked,
          ),
        );
      }

      rowList.add(
        Row(
          children: columnList,
        ),
      );
    }

    return Column(
      children: rowList,
    );
  }
}
