import 'package:flutter/material.dart';

import '../components/board_widget.dart';
import '../components/result_widget.dart';
import '../models/board.dart';
import '../models/cell.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: true,
          onRestart: () => _restart(),
        ),
        body: Container(
          child: BoardWidget(
            board: Board(
              rows: 15,
              columns: 15,
              mines: 10,
            ),
            onOpen: _open,
            onSwitchFlagged: _switchFlagged,
          ),
        ),
      ),
    );
  }
}
