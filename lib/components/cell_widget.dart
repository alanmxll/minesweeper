import 'package:flutter/material.dart';

import '../models/cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;
  final void Function(Cell) onOpen;
  final void Function(Cell) onSwitchFlagged;

  const CellWidget({
    @required this.cell,
    @required this.onOpen,
    @required this.onSwitchFlagged,
  });

  Widget _getImage() {
    int _minesOnNeighborhood = cell.minesOnNeighborhood;

    if (cell.uncovered && cell.mined && cell.exploded) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (cell.uncovered && cell.mined) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (cell.uncovered && _minesOnNeighborhood > 0) {
      return Image.asset('assets/images/open_$_minesOnNeighborhood.jpeg');
    } else if (cell.flagged) {
      return Image.asset('assets/images/flag.jpeg');
    } else {
      return Image.asset('assets/images/close.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(cell),
      onLongPress: () => onSwitchFlagged(cell),
      child: _getImage(),
    );
  }
}
