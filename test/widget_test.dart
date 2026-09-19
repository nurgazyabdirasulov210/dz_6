import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notes_app/data/app_database.dart';
import 'package:notes_app/main.dart';

void main() {
  testWidgets('Notes app shows the notes list', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      MyApp(database: AppDatabase.forTesting(NativeDatabase.memory())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Заметки'), findsOneWidget);
    expect(find.text('Заметок пока нет'), findsOneWidget);
  });
}
