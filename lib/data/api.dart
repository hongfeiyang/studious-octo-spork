import 'dart:core';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:employees_catalogue/data/person.dart';

class Api {
  static List<Person> _sampleData = [
    Person(1, "John Brown", Responsibility.DevOps, "101", "+1 123456", "jbrown@example.com"),
    Person(2, "Janet Doe", Responsibility.Accounting, "145", "+1 145001", "jdoe@example.com"),
    Person(3, "Greg Jackson", Responsibility.IT_Support, "200", "+1 200123", "gjackson@example.com"),
    Person(4, "Zoe Cox", Responsibility.Marketing, "205", "+1 205456", "zcox@example.com"),
    Person(5, "Samuel Burton", Responsibility.Infrastructure, "206", "+1 206789", "sburton@example.com"),
    Person(6, "Natalie Smith", Responsibility.Sales, "108", "+1 108112", "nsmith@example.com"),
    Person(7, "Clementine Sheehan", Responsibility.DevOps, "101", "+1 534545", "csheehan@example.com"),
    Person(8, "Felix Ingram", Responsibility.Accounting, "200", "+1 421532", "fingram@example.com"),
    Person(9, "Jess Jimenez", Responsibility.Sales, "108", "+1 532564", "jjimenez@example.com"),
    Person(10, "Seren Burton", Responsibility.Infrastructure, "206", "+1 206789", "seburton@example.com"),
  ];

  Person? getPerson(int? id) {
    return _sampleData.firstWhereOrNull((element) => element.id == id);
  }

  List<Person> searchPeople({String? query, Responsibility? responsibility}) {
    return _sampleData
        .where((element) => element.fullName.toLowerCase().contains(query ?? ''))
        .where((element) => responsibility == null || element.responsibility == responsibility)
        .toList();
  }
}
