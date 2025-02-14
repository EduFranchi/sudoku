import 'package:flutter/material.dart';
import 'package:sudoku/square.dart';

class SquareWidget extends StatelessWidget {
  final Square square;
  final double sizeSmallSquare;
  final void Function(Square square) callbackOnTap;

  const SquareWidget({
    super.key,
    required this.square,
    required this.sizeSmallSquare,
    required this.callbackOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: square.fixValue == null ? _onTap : null,
      child: Container(
        width: sizeSmallSquare,
        height: sizeSmallSquare,
        decoration: BoxDecoration(
          color: _getColor(),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Center(
          child: Text(
            _getText(),
            style: TextStyle(
              fontSize: sizeSmallSquare / 1.5,
              fontWeight: square.fixValue != null ? FontWeight.bold : null,
              color: _getFontColor(),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (square.selected) {
      return Colors.grey;
    } else {
      return Colors.transparent;
    }
  }

  Color? _getFontColor() {
    if (square.fixValue == null && square.isWrong) {
      return Colors.red;
    } else {
      return null;
    }
  }

  String _getText() {
    if (square.fixValue != null) {
      return square.fixValue!.toString();
    } else if (square.value != null) {
      return square.value!.toString();
    } else {
      return '';
    }
  }

  void _onTap() {
    callbackOnTap.call(square);
  }
}
