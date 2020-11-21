import 'package:flutter/material.dart';

import '../components/board_widget.dart';
import '../components/result_widget.dart';
import '../models/board.dart';
import '../models/cell.dart';
import '../models/explosion_exception.dart';

class MinesweeperApp extends StatefulWidget {
  @override
  _MinesweeperAppState createState() => _MinesweeperAppState();
}

class _MinesweeperAppState extends State<MinesweeperApp> {
  bool _won;
  Board _board;

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

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int columns = 15;
      double cellSize = width / columns;
      int rows = (height / cellSize).floor();

      _board = Board(
        rows: rows,
        columns: columns,
        mines: 50,
      );
    }
    return _board;
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
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BoardWidget(
                board: _getBoard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onSwitchFlagged: _switchFlagged,
              );
            },
          ),
        ),
      ),
    );
  }
}
