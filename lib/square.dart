class Square {
  final int mediumSquareRow;
  final int mediumSquareColumn;
  final int row;
  final int column;
  final int? fixValue;
  final int? value;
  final bool selected;
  final bool isWrong;

  const Square({
    required this.mediumSquareRow,
    required this.mediumSquareColumn,
    required this.row,
    required this.column,
    this.fixValue,
    this.value,
    this.selected = false,
    this.isWrong = false,
  });
}
