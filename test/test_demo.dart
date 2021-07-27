import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/component/Test/test_demo.dart';

void main() {
  test("should return hello something", () {
    var greet = ClassTestDemo.greet("水ト桜");
    expect(greet, "hello 水ト桜");
  });

  testWidgets("test hello chip widget", (WidgetTester widgetTester) async {
    //必须放在material Scaffold 里面  不然报错 No Material widget found.
    await widgetTester.pumpWidget(
      MaterialApp(home: Scaffold(body: TestWidgetDemo())),
    );
    final labelText =find.text("hello");
    // expect(labelText, findsNothing);
    // expect(labelText, findsOneWidget);
    expect(labelText, findsNWidgets(1));

    final actionChipTest=find.text("0");

    expect(actionChipTest, findsOneWidget);

    final actionChipWidgetTest=find.byType(ActionChip);
    //模拟cation onTap效果
    await widgetTester.tap(actionChipWidgetTest);
    //小部件的值发生了变化 需要重建
    await widgetTester.pump();

    final actionChipTextAfterTap = find.text("1");

    expect(actionChipTextAfterTap, findsOneWidget);
    //结果已经变成1 0不在了
    expect(actionChipTest, findsNothing);
  });
}
