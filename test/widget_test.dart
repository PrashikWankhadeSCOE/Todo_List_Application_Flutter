import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_app/2_application/app/basic_app.dart';

void main() {
  testWidgets('Basic app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BasicApp());

    expect(find.text('1'), findsNothing);
  });
}
