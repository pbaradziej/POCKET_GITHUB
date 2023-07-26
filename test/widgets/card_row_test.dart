import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_github/widgets/card_row.dart';

void main() {
  late MaterialApp materialApp;

  setUp(() {
    materialApp = const MaterialApp(
      home: Scaffold(
        body: CardRow(
          name: 'test_name',
          text: 'test_text',
        ),
      ),
    );
  });

  testWidgets('Widget loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(materialApp);
    final Finder type = find.byType(CardRow);
    expect(type, findsOneWidget);
  });

  testWidgets('Widget renders card row texts', (WidgetTester tester) async {
    await tester.pumpWidget(materialApp);
    final Finder name = find.text('test_name');
    expect(name, findsOneWidget);
    final Finder text = find.text('test_text');
    expect(text, findsOneWidget);
  });

  testWidgets('Widget renders empty card row', (WidgetTester tester) async {
    materialApp = const MaterialApp(
      home: Scaffold(
        body: CardRow(
          name: '',
          text: '',
        ),
      ),
    );

    await tester.pumpWidget(materialApp);
    final Finder name = find.text('test_name');
    expect(name, findsNothing);
    final Finder text = find.text('test_text');
    expect(text, findsNothing);
    final Finder sizedBox = find.byType(SizedBox);
    expect(sizedBox, findsOneWidget);
  });
}
