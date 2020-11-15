import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/board.dart';

main() {
  test('Should win the game', () {
    Board board = Board(rows: 2, columns: 2, mines: 0);

    board.cells[0].undermine();
    board.cells[3].undermine();

    board.cells[0].switchFlagged();
    board.cells[1].uncover();
    board.cells[2].uncover();
    board.cells[3].switchFlagged();

    expect(board.resolved, isTrue);
  });
}
