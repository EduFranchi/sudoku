import 'package:flutter/material.dart';
import 'package:sudoku/square.dart';
import 'package:sudoku/widgets/square_widget.dart';

class BoxWidget extends StatefulWidget {
  final double sizeBox;
  final double sizeMediumSquare;
  final double sizeSmallSquare;
  final List<Square> squareList;
  final void Function(Square square) callbackOnTap;

  const BoxWidget({
    super.key,
    required this.sizeBox,
    required this.sizeMediumSquare,
    required this.sizeSmallSquare,
    required this.squareList,
    required this.callbackOnTap,
  });

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.sizeBox + 8,
      height: widget.sizeBox + 8,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: _getMediumSquareWidget(),
    );
  }

  Widget _getMediumSquareWidget() {
    int indexSquareList = 0;
    List<Widget> rowList = [];
    for (int x = 0; x < 3; x++) {
      List<Widget> columnList = [];
      for (int y = 0; y < 3; y++) {
        columnList.add(
          Container(
            width: widget.sizeMediumSquare + 2,
            height: widget.sizeMediumSquare + 2,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: _getSquareListWidget(x, y, indexSquareList),
          ),
        );
        indexSquareList += 9;
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

  Widget _getSquareListWidget(int xM, int yM, int indexSquareList) {
    List<Widget> rowList = [];
    for (int x = 0; x < 3; x++) {
      List<Widget> columnList = [];
      for (int y = 0; y < 3; y++) {
        Square square = widget.squareList[indexSquareList];
        columnList.add(
          SquareWidget(
            square: square,
            sizeSmallSquare: widget.sizeSmallSquare,
            callbackOnTap: widget.callbackOnTap,
          ),
        );
        indexSquareList++;
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
