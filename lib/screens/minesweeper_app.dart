import 'package:flutter/material.dart';

import '../components/board_widget.dart';
import '../components/result_widget.dart';
import '../models/board.dart';
import '../models/cell.dart';

class MinesweeperApp extends StatefulWidget {
  @override
  _MinesweeperAppState createState() => _MinesweeperAppState();
}

class _MinesweeperAppState extends State<MinesweeperApp> {
  bool _won;
  Board _board = Board(
    rows: 12,
    columns: 12,
    mines: 3,
  );

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
          won: _won,
          onRestart: _restart,
        ),
        body: Container(
          child: BoardWidget(
            board: _board,
            onOpen: _open,
            onSwitchFlagged: _switchFlagged,
          ),
        ),
      ),
    );
  }
}
