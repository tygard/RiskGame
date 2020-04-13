import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:risk/gameLayer/GameBoard.dart';
import 'package:flutter/material.dart';
import 'package:risk/models/gameStateObjects/gameBoard.dart' as gb;
import 'package:risk/models/gameStateObjects/tile.dart' as t;
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';

// ignore: must_be_immutable
class MockBoard extends Mock implements GameBoard {
  int dimensions = new Random().nextInt(9) + 7;
  @override
  // ignore: missing_return
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    super.toString();
  }
}

class BackendBoard extends Mock implements gb.GameBoard
{

  int dimensions;
  List<MockTile> squares = new List();

  BackendBoard(this.dimensions) {
    createsquares();
  }

  void createsquares() {
    for (int x = 0; x < this.dimensions; x++) {
      for (int y = 0; y < this.dimensions; y++) {
        squares.add(new MockTile(x, y));
      }
    }
  }
}

class MockTile extends Mock implements t.Tile {
  int x;
  int y;
  MockTile(int a, int b) {
    x = a;
    y = b;
  }
  int power = 10;
  int ownership = -1;
  @override
  // ignore: missing_return
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    super.toString();
  }
}

void main() {
  testWidgets('Dimensions render correctly', (WidgetTester tester) async {
    MockBoard board = new MockBoard();
    expect(board.dimensions, inInclusiveRange(7, 16));
  });

  testWidgets('Render board correctly', (WidgetTester tester) async {
    MockBoard board = new MockBoard();
    BackendBoard game = new BackendBoard(board.dimensions);
    game.dimensions = board.dimensions;
    expect(game.squares.length, board.dimensions * board.dimensions);
    expect(game.squares[1].ownership, -1);
    expect(game.squares[1].power, 10);
  });

  testWidgets('Render players', (WidgetTester tester) async {
    MockBoard board = new MockBoard();
    BackendBoard game = new BackendBoard(board.dimensions);
    game.dimensions = board.dimensions;
    int dim = board.dimensions;
    game.squares[0].power = 20;
    game.squares[0].ownership = 0;
    game.squares[dim - 1].power = 20;
    game.squares[dim - 1].ownership = 3;
    game.squares[dim * dim - 1].power = 20;
    game.squares[dim * dim - 1].ownership = 1;
    game.squares[dim * dim - dim ].power = 20;
    game.squares[dim * dim - dim ].ownership = 2;
    expect(game.squares[0].ownership, 0);
    expect(game.squares[dim * dim - 1].ownership, 1);
    expect(game.squares[dim * dim - dim].ownership, 2);
    expect(game.squares[dim - 1].ownership, 3);
  });


}
