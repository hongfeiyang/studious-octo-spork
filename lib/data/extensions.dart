import 'person.dart';

extension ResponsibilityExtension on Responsibility {
  String toNameString() {
    switch (this) {
      case Responsibility.DevOps:
        return 'DevOps';
      case Responsibility.Accounting:
        return 'Accounting';
      case Responsibility.IT_Support:
        return 'IT Support';
      case Responsibility.Marketing:
        return 'Marketing';
      case Responsibility.Infrastructure:
        return 'Infrastructure';
      case Responsibility.Sales:
        return 'Sales';
    }
  }
}
