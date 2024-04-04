import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:employees_catalogue/data/extensions.dart';

class PersonDetailsPage extends StatefulWidget {
  final int? personId;

  const PersonDetailsPage({Key? key, required this.personId}) : super(key: key);

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  Person? person;

  @override
  void initState() {
    super.initState();
    if (widget.personId != null) {
      person = Component.instance.api.getPerson(widget.personId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Person details'), leading: CloseButton()),
        body: Container()); // TODO
  }
}
