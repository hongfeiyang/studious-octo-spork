import 'package:flutter/widgets.dart';

class WidgetKey {
  static ValueKey<String> listOfPeople = ValueKey('listOfPeople');
  static ValueKey<String> filter = ValueKey('filter');
  static ValueKey<String> search = ValueKey('search');
  static ValueKey<String> clearFilter = ValueKey('clearFilter');
}
