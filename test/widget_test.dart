import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notes_app/main.dart';

void main() {
  testWidgets('Notes app shows the notes list', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Заметки'), findsOneWidget);
    expect(find.text('Заметок пока нет'), findsOneWidget);
  });
}
