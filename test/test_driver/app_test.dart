import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("App", () {
    late FlutterDriver driver;

    final actionChip = find.byValueKey("actionChipTest");
    final actionChipLabelTest = find.byValueKey("actionChipLabelTest");

    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null)
        driver.close();
    });

    test('start at 0', () async {
      expect(await driver.getText(actionChipLabelTest), "0");
    });

    test('add th counter', () async {
      await driver.tap(actionChip);
      expect(await driver.getText(actionChip), "1");
    });
  });
}