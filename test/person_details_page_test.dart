import 'package:employees_catalogue/data/api.dart';
import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/person_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employees_catalogue/data/extensions.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_classes.dart';

void main() {
  Component.instance.api = MockApi();
  final api = Component.instance.api;
  final int validPersonId = 1;
  final int invalidPersonId = 111;

  when(() => api.getPerson(any(that: lessThan(invalidPersonId)))).thenAnswer((realInvocation) => Api().getPerson(1));
  when(() => api.getPerson(any(that: greaterThanOrEqualTo(invalidPersonId)))).thenAnswer((realInvocation) => null);

  Widget pageWithId(int personId) {
    return MaterialApp(home: PersonDetailsPage(personId: personId));
  }

  Widget pageWithProperId() {
    return pageWithId(validPersonId);
  }

  Widget pageWithInvalidId() {
    return pageWithId(invalidPersonId);
  }

  testWidgets('shouldFinishWhenPersonWasNotFound', (WidgetTester tester) async {
    await tester.pumpWidget(pageWithInvalidId());

    await tester.pumpAndSettle();

    expect(find.byType(PersonDetailsPage), findsNothing);
  });

  testWidgets('shouldDisplayFullname', (WidgetTester tester) async {
    await tester.pumpWidget(pageWithProperId());

    await tester.pumpAndSettle();

    expect(find.textContaining(api.getPerson(validPersonId)!.fullName), findsOneWidget);
  });

  testWidgets('shouldDisplayResponsibility', (WidgetTester tester) async {
    await tester.pumpWidget(pageWithProperId());

    await tester.pumpAndSettle();

    expect(find.textContaining(api.getPerson(validPersonId)!.responsibility.toNameString()), findsOneWidget);
  });

  testWidgets('shouldDisplayRoom', (WidgetTester tester) async {
    await tester.pumpWidget(pageWithProperId());

    await tester.pumpAndSettle();

    expect(find.textContaining(api.getPerson(validPersonId)!.room), findsOneWidget);
  });

  testWidgets('shouldDisplayPhoneNumber', (WidgetTester tester) async {
    await tester.pumpWidget(pageWithProperId());

    await tester.pumpAndSettle();

    expect(find.textContaining(api.getPerson(validPersonId)!.phone), findsOneWidget);
  });

  testWidgets('shouldDisplayEmailAddress', (WidgetTester tester) async {
    await tester.pumpWidget(pageWithProperId());

    await tester.pumpAndSettle();

    expect(find.textContaining(api.getPerson(validPersonId)!.email), findsOneWidget);
  });
}
