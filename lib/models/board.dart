import 'dart:math';

import 'package:flutter/foundation.dart';

import 'cell.dart';

class Board {
  final int rows;
  final int columns;
  final int mines;

  final List<Cell> _cells = [];

  Board({
    @required this.rows,
    @required this.columns,
    @required this.mines,
  }) {
    _createCells();
    _relateNeighbors();
    _randomizeMines();
  }

  void restart() {
    _cells.forEach((cell) => cell.restart());
    _randomizeMines();
  }

  void revealMines() {
    _cells.forEach((cell) => cell.uncover());
  }

  void _createCells() {
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        _cells.add(Cell(row: row, column: column));
      }
    }
  }

  void _relateNeighbors() {
    for (Cell cell in _cells) {
      for (Cell neighbor in _cells) {
        cell.addNeighbor(neighbor);
      }
    }
  }

  void _randomizeMines() {
    int randomizedMines = 0;

    if (mines > rows * columns) {
      return;
    }

    while (randomizedMines < mines) {
      int index = Random().nextInt(_cells.length);

      if (_cells[index].mined) {
        randomizedMines++;
        _cells[index].undermine();
      }
    }
  }

  List<Cell> get cells => _cells;

  bool get resolved => _cells.every((cell) => cell.resolved);
}
