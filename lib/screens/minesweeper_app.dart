import 'package:flutter/material.dart';
import 'package:minesweeper/components/cell_widget.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/explosion_exception.dart';

import '../components/result_widget.dart';

class MinesweeperApp extends StatelessWidget {
  void _restart() {
    print('Restarted');
  }

  void _open(Cell cell) {
    print('Opened');
  }

  void _switchFlagged(Cell cell) {
    print('Switched');
  }

  @override
  Widget build(BuildContext context) {
    Cell cell = Cell(row: 0, column: 0);
    Cell neighborOne = Cell(row: 1, column: 0);
    cell.addNeighbor(neighborOne);
    neighborOne.undermine();
    Cell neighborTwo = Cell(row: 1, column: 1);
    cell.addNeighbor(neighborTwo);
    neighborTwo.undermine();

    try {
      // cell.undermine();
      cell.uncover();
    } on ExplosionException {}

    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: true,
          onRestart: () => _restart(),
        ),
        body: Container(
          child: CellWidget(
            cell: cell,
            onOpen: _open,
            onSwitchFlagged: _switchFlagged,
          ),
        ),
      ),
    );
  }
}
