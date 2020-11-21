import 'package:flutter/material.dart';
import 'package:minesweeper/models/explosion_exception.dart';

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
    setState(() {
      _won = null;
      _board.restart();
    });
  }

  void _open(Cell cell) {
    if (_won != null) {
      return;
    }

    setState(() {
      try {
        cell.uncover();
        if (_board.resolved) {
          _won = true;
        }
      } on ExplosionException {
        _won = false;
        _board.revealMines();
      }
    });
  }

  void _switchFlagged(Cell cell) {
    if (_won != null) {
      return;
    }

    setState(() {
      cell.switchFlagged();
      if (_board.resolved) {
        _won = true;
      }
    });
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
