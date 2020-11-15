import 'package:flutter/foundation.dart';

import 'explosion_exception.dart';

class Cell {
  final int row;
  final int column;
  final List<Cell> neighbors = [];

  bool _uncovered = false;
  bool _flagged = false;
  bool _mined = false;
  bool _exploded = false;

  Cell({@required this.row, @required this.column});

  void addNeighbor(Cell neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void uncover() {
    if (_uncovered) {
      return;
    }

    _uncovered = true;

    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbors.forEach((n) => n.uncover());
    }
  }

  void revealMine() {
    if (_mined) {
      _uncovered = true;
    }
  }

  void undermine() {
    _mined = true;
  }

  void switchFlagged() {
    _flagged = !_flagged;
  }

  void restart() {
    _uncovered = false;
    _flagged = false;
    _mined = false;
    _exploded = false;
  }

  bool get mined => _mined;

  bool get exploded => _exploded;

  bool get uncovered => _uncovered;

  bool get flagged => _flagged;

  bool get resolved {
    bool minedAndFlagged = mined && flagged;
    bool safeAndUncovered = !mined && uncovered;

    return minedAndFlagged || safeAndUncovered;
  }

  bool get safeNeighborhood => neighbors.every((n) => !n._mined);

  int get minesOnNeighborhood => neighbors.where((n) => n.mined).length;
}
