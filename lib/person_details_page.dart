import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:flutter/material.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.personId == null) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Person details'), leading: CloseButton()),
      body: person != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${person!.fullName}'),
                  Text('Responsibility: ${person!.responsibility}'),
                  Text('Email: ${person!.email}'),
                  Text('Phone: ${person!.phone}'),
                  Text('Room: ${person!.room}'),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
