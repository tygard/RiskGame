import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:risk/models/gameStateObjects/active.dart';
import 'package:risk/models/gameStateObjects/tile.dart';
import 'package:risk/src/utils/serviceProviders.dart';

class MockActive extends Mock implements Active {}

Active mockActive;
Tile t;

void main() {
  registerServices();
  group('all:', () {
    group('purchasing:', () {
      setUp(() {
        mockActive = MockActive();
        t = new Tile(0, 0);
      });
      test('purchase actives', () {
        verifyZeroInteractions(mockActive);
        t.purchaseActive(mockActive);
      });

      test('add actives to activesList', () {
        verifyZeroInteractions(mockActive);
        expect(t.activesList.length == 0, true);

        t.purchaseActive(mockActive);
        expect(t.activesList.length == 1, true);
      });
    });
    group('selling:', () {
      setUp(() {
        mockActive = MockActive();
        t = new Tile(0, 0);
        t.purchaseActive(mockActive);
      });
      test('sell actives', () {
        t.sellActive(mockActive);
      });

      test('remove actives from activesList', () {
        expect(t.activesList.length == 1, true);

        t.sellActive(mockActive);
        expect(t.activesList.length == 0, true);
      });
    });
  });
}
