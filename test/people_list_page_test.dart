import 'package:employees_catalogue/data/api.dart';
import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/people_list_page.dart';
import 'package:employees_catalogue/main.dart';
import 'package:employees_catalogue/person_details_page.dart';
import 'package:employees_catalogue/widget_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:employees_catalogue/data/extensions.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_classes.dart';

void main() {
  Component.instance.api = MockApi();
  final api = Component.instance.api;

  when(() => api.searchPeople(
        query: any(named: 'query'),
        responsibility: any(named: 'responsibility'),
      )).thenAnswer((realInvocation) => Api().searchPeople());

  when(() => api.getPerson(1)).thenAnswer((realInvocation) => Api().getPerson(1));

  test('ResponsibilityTypeToStringNameShouldBeParsedProperly', () {
    expect('IT Support' == (Responsibility.IT_Support.toNameString()), true);
  });

  testWidgets('shouldDisplayTheSameAmountOfPeopleAsInPeopleDataSourceSampleData', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byKey(WidgetKey.listOfPeople), findsOneWidget);

    expect(find.byType(PersonItemWidget), findsNWidgets(api.searchPeople().length));
  });

  testWidgets('shouldDisplayFullnameAndResponsibilityOnListItems', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byKey(WidgetKey.listOfPeople), findsOneWidget);

    api.searchPeople().forEach((element) {
      expect(find.descendant(of: find.byKey(WidgetKey.listOfPeople), matching: find.textContaining(element.fullName)), findsOneWidget);
      expect(find.descendant(of: find.byKey(WidgetKey.listOfPeople), matching: find.textContaining(element.responsibility.toNameString())), findsWidgets);
    });
  });

  testWidgets('shouldLaunchPersonDetailsOnRowClick', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byKey(WidgetKey.listOfPeople), findsOneWidget);

    api.searchPeople().forEach((element) {
      expect(find.descendant(of: find.byKey(WidgetKey.listOfPeople), matching: find.textContaining(element.fullName)), findsOneWidget);
      expect(find.descendant(of: find.byKey(WidgetKey.listOfPeople), matching: find.textContaining(element.responsibility.toNameString())), findsWidgets);
    });

    await tester.tap(find.textContaining(api.getPerson(1)!.fullName));

    await tester.pumpAndSettle();

    expect(find.byType(PersonDetailsPage), findsOneWidget);
  });

  testWidgets('shouldFilterListByResponsibility', (WidgetTester tester) async {
    when(() => api.searchPeople(query: any(named: 'query'), responsibility: any(named: 'responsibility')))
        .thenAnswer((realInvocation) => Api().searchPeople(responsibility: Responsibility.IT_Support));

    await tester.pumpWidget(MyApp());

    expect(find.byKey(WidgetKey.listOfPeople), findsOneWidget);
    expect(find.byKey(WidgetKey.filter), findsOneWidget);

    await tester.tap(find.byKey(WidgetKey.filter));

    await tester.pumpAndSettle();

    expect(find.byType(typeOf<PopupMenuItem<Responsibility>>()), findsNWidgets(6));
    await tester.tap(find.descendant(of: find.byType(typeOf<PopupMenuItem<Responsibility>>()), matching: find.text(Responsibility.IT_Support.toNameString())));

    await tester.pumpAndSettle();

    expect(find.descendant(of: find.byKey(WidgetKey.listOfPeople), matching: find.textContaining(Responsibility.IT_Support.toNameString())), findsOneWidget);
    expect(find.descendant(of: find.byKey(WidgetKey.listOfPeople), matching: find.textContaining(Responsibility.DevOps.toNameString())), findsNothing);
  });

  testWidgets('showPeopleThatNameContainsQuery', (WidgetTester tester) async {
    when(() => api.searchPeople(query: any(that: equals('bur'), named: 'query'), responsibility: any(named: 'responsibility')))
        .thenAnswer((realInvocation) => Api().searchPeople(query: 'bur'));

    await tester.pumpWidget(MyApp());
    await tester.tap(find.byType(LeadingWidget));
    await tester.pump(Duration(milliseconds: 400));
    expect(find.byKey(WidgetKey.search), findsOneWidget);

    await tester.enterText(find.byKey(WidgetKey.search), 'bur');

    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        final Text textWidget = widget;
        if (textWidget.data != null) return textWidget.data!.contains('Bur');
        return textWidget.textSpan?.toPlainText().contains('Bur') ?? false;
      }
      return false;
    }), findsNWidgets(2));
  });
}

Type typeOf<T>() => T;
