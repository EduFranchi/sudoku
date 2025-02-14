import 'package:flutter/material.dart';
import 'package:sudoku/sudoku.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Sudoku(),
    ),
  );
}
