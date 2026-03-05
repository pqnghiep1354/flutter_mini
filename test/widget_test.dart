import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_articles/myapp.dart';

void main() {
  testWidgets('App should render HomeScreen with Articles Hub title',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify that the app title is shown
    expect(find.text('Articles Hub'), findsWidgets);
  });
}
