import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/cell.dart';

main() {
  group('Cell Test ->', () {
    test('Should uncover Cell with explosion.', () {
      Cell cell = Cell(row: 0, column: 0);
      cell.undermine();

      expect(cell.uncover, throwsException);
    });

    test('Should uncover Cell without explosion.', () {
      Cell cell = Cell(row: 0, column: 0);
      cell.uncover();

      expect(cell.uncovered, isTrue);
    });

    test('Should add not Neighbor.', () {
      Cell cellOne = Cell(row: 0, column: 0);
      Cell cellTwo = Cell(row: 1, column: 3);
      cellOne.addNeighbor(cellTwo);

      expect(cellOne.neighbors.isEmpty, isTrue);
    });

    test('Should add Neighbor.', () {
      Cell cellOne = Cell(row: 3, column: 3);
      Cell cellTwo = Cell(row: 3, column: 4);
      Cell cellThree = Cell(row: 2, column: 2);
      Cell cellFour = Cell(row: 4, column: 4);

      cellOne.addNeighbor(cellTwo);
      cellOne.addNeighbor(cellThree);
      cellOne.addNeighbor(cellFour);

      expect(cellOne.neighbors.length, 3);
    });

    test('Should detect mines on Neighborhood.', () {
      Cell cellOne = Cell(row: 3, column: 3);

      Cell cellTwo = Cell(row: 3, column: 4);
      cellTwo.undermine();

      Cell cellThree = Cell(row: 2, column: 2);

      Cell cellFour = Cell(row: 4, column: 4);
      cellFour.undermine();

      cellOne.addNeighbor(cellTwo);
      cellOne.addNeighbor(cellThree);
      cellOne.addNeighbor(cellFour);

      expect(cellOne.minesOnNeighborhood, 2);
    });
  });
}
