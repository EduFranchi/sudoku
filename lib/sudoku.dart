import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sudoku/square.dart';
import 'package:sudoku/widgets/box_widget.dart';
import 'package:sudoku/widgets/keyboard_widget.dart';

class Sudoku extends StatefulWidget {
  const Sudoku({super.key});

  @override
  State<Sudoku> createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  late double _sizeBox;
  late double _sizeMediumSquare;
  late double _sizeSmallSquare;
  List<Square> _squareList = [];
  int? _indexSquareSelected;

  @override
  void initState() {
    super.initState();
    _constructSquareList();
  }

  Future<void> _constructSquareList() async {
    int initialX = 0;
    int initialY = 0;
    List<Square> list = [];
    for (int xM = 0; xM < 3; xM++) {
      for (int yM = 0; yM < 3; yM++) {
        for (int x = 0 + initialX; x < 3 + initialX; x++) {
          for (int y = 0 + initialY; y < 3 + initialY; y++) {
            list.add(
              Square(
                mediumSquareRow: xM,
                mediumSquareColumn: yM,
                row: x,
                column: y,
                fixValue: Random().nextInt(9) + 1,
              ),
            );
          }
        }
        initialY += 3;
      }
      initialY = 0;
      initialX += 3;
    }
    List<Square> list2 = _checkNumberIsCorrect(list);
    if (list2.isNotEmpty) {
      //await _constructSquareList();
    } else {
      _squareList = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    _sizeBox = (MediaQuery.of(context).size.width / 3) * 2;
    _sizeMediumSquare = _sizeBox / 3;
    _sizeSmallSquare = _sizeMediumSquare / 3;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoxWidget(
              sizeBox: _sizeBox,
              sizeMediumSquare: _sizeMediumSquare,
              sizeSmallSquare: _sizeSmallSquare,
              squareList: _squareList,
              callbackOnTap: _selectSquare,
            ),
            const SizedBox(height: 20),
            KeyboardWidget(
              sizeBox: _sizeBox,
              sizeMediumSquare: _sizeMediumSquare,
              callbackClicked: _callbackClicked,
            ),
          ],
        ),
      ),
    );
  }

  void _selectSquare(Square square) {
    for (int i = 0; i < _squareList.length; i++) {
      bool sameSquare = _checkSameSquare(_squareList[i], square);
      if (sameSquare) {
        _indexSquareSelected = i;
      }
      _squareList[i] = Square(
        mediumSquareRow: _squareList[i].mediumSquareRow,
        mediumSquareColumn: _squareList[i].mediumSquareColumn,
        row: _squareList[i].row,
        column: _squareList[i].column,
        fixValue: _squareList[i].fixValue,
        value: _squareList[i].value,
        selected: sameSquare,
        isWrong: _squareList[i].isWrong,
      );
    }

    setState(() {});
  }

  void _callbackClicked(int value) {
    if (_indexSquareSelected != null) {
      _squareList[_indexSquareSelected!] = Square(
        mediumSquareRow: _squareList[_indexSquareSelected!].mediumSquareRow,
        mediumSquareColumn:
            _squareList[_indexSquareSelected!].mediumSquareColumn,
        row: _squareList[_indexSquareSelected!].row,
        column: _squareList[_indexSquareSelected!].column,
        fixValue: _squareList[_indexSquareSelected!].fixValue,
        value: value,
        selected: _squareList[_indexSquareSelected!].selected,
        isWrong: _squareList[_indexSquareSelected!].isWrong,
      );

      List<Square> wrongIndexList = _checkNumberIsCorrect(_squareList);

      for (int i = 0; i < _squareList.length; i++) {
        bool isWrong = false;
        for (Square square in wrongIndexList) {
          if (_checkSameSquare(_squareList[i], square)) {
            isWrong = true;
            break;
          }
        }
        _squareList[i] = Square(
          mediumSquareRow: _squareList[i].mediumSquareRow,
          mediumSquareColumn: _squareList[i].mediumSquareColumn,
          row: _squareList[i].row,
          column: _squareList[i].column,
          fixValue: _squareList[i].fixValue,
          value: _squareList[i].value,
          selected: _squareList[i].selected,
          isWrong: isWrong,
        );
      }

      setState(() {});
    }
  }

  bool _checkSameSquare(Square square, Square square2) {
    return square.mediumSquareRow == square2.mediumSquareRow &&
        square.mediumSquareColumn == square2.mediumSquareColumn &&
        square.row == square2.row &&
        square.column == square2.column;
  }

  List<Square> _checkNumberIsCorrect(List<Square> listSquare) {
    List<Square> list = [];
    for (int i = 0; i < listSquare.length; i++) {
      for (int i2 = 0; i2 < listSquare.length; i2++) {
        if (i != i2) {
          if ((listSquare[i].mediumSquareRow ==
                      listSquare[i2].mediumSquareRow &&
                  listSquare[i].mediumSquareColumn ==
                      listSquare[i2].mediumSquareColumn) ||
              listSquare[i].row == listSquare[i2].row ||
              listSquare[i].column == listSquare[i2].column) {
            if (listSquare[i].value != null &&
                (listSquare[i].value == listSquare[i2].value ||
                    listSquare[i].value == listSquare[i2].fixValue)) {
              list.add(listSquare[i]);
            }
          }
        }
      }
    }
    return list;
  }
}
