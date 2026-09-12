import 'package:flutter_test/flutter_test.dart';
import 'package:nusatrip/main.dart';

void main() {
  testWidgets('NusaTrip smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NusaTripApp());
    expect(find.text('NusaTrip'), findsWidgets);
  });
}
