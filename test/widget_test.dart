// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterworkshop/data_provider.dart';
import 'package:flutterworkshop/edit_page.dart';
import 'package:flutterworkshop/main.dart';
import 'package:flutterworkshop/main_page.dart';
import 'package:preferences/preference_service.dart';
import 'package:provider/provider.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    PrefService.enableCaching();
    PrefService.cache = {};
    PrefService.setStringList(
        'data_map_keys', ['Flutter', 'React', 'Xamarin', 'Ionic']);
    PrefService.setStringList('data_map_values', ['5', '3', '2', '2']);
  });

  testWidgets('Test names', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => DataProvider(), child: MyApp()));

    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('React'), findsOneWidget);
    expect(find.text('Xamarin'), findsOneWidget);
    expect(find.text('Ionic'), findsOneWidget);
  });

  testWidgets('Test navigation', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => DataProvider(), child: MyApp()));

    expect(find.byType(MainPage), findsOneWidget);
    expect(find.byType(EditPage), findsNothing);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.byType(MainPage), findsNothing);
    expect(find.byType(EditPage), findsOneWidget);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.byType(MainPage), findsOneWidget);
    expect(find.byType(EditPage), findsNothing);
  });

  testWidgets('Test editing', (WidgetTester tester) async {
    DataProvider provider = DataProvider();
    Map<String, double> dataMap = provider.dataMap;

    // Test initial values
    expect(dataMap['Flutter'], equals(5));
    expect(dataMap['React'], equals(3));
    expect(dataMap['Xamarin'], equals(2));
    expect(dataMap['Ionic'], equals(2));

    // Edit data
    await tester.pumpWidget(
        ChangeNotifierProvider(create: (context) => provider, child: MyApp()));

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    Finder flutterValueField = find.widgetWithText(TextFormField, '5.0');
    await tester.enterText(flutterValueField, '10');

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Test new values
    expect(dataMap['Flutter'], equals(10));
    expect(dataMap['React'], equals(3));
    expect(dataMap['Xamarin'], equals(2));
    expect(dataMap['Ionic'], equals(2));
  });
}
