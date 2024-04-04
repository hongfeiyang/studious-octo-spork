import 'package:employees_catalogue/data/api.dart';

class Component {
  Component._();

  static final Component _instance = Component._();

  static Component get instance => _instance;

  late Api api;
}
