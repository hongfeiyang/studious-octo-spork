import 'package:employees_catalogue/data/api.dart';
import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/people_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  initComponent();
  runApp(MyApp());
}

void initComponent() {
  Component.instance.api = Api();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devskiller Employees',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeopleListPage(
        title: 'Employees Catalogue',
      ),
    );
  }
}
