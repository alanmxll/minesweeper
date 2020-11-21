import 'package:flutter/material.dart';
import 'package:minesweeper/components/cell_widget.dart';

import '../models/board.dart';
import '../models/cell.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Cell) onOpen;
  final void Function(Cell) onSwitchFlagged;

  const BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onSwitchFlagged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.cells.map<CellWidget>((c) {
          return CellWidget(
            cell: c,
            onOpen: onOpen,
            onSwitchFlagged: onSwitchFlagged,
          );
        }).toList(),
      ),
    );
  }
}
