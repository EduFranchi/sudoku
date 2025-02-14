import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {
  final double sizeBox;
  final double sizeMediumSquare;
  final int value;
  final void Function(int value) callbackClicked;

  const NumberWidget({
    super.key,
    required this.sizeBox,
    required this.sizeMediumSquare,
    required this.value,
    required this.callbackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callbackClicked.call(value);
      },
      child: SizedBox(
        width: sizeMediumSquare,
        height: sizeMediumSquare,
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: sizeMediumSquare / 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
