import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/data/extensions.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:employees_catalogue/widget_keys.dart';
import 'package:flutter/material.dart';

import 'person_details_page.dart';

class PeopleListPage extends StatefulWidget {
  final String title;

  const PeopleListPage({Key? key, required this.title}) : super(key: key);

  @override
  _PeopleListPageState createState() => _PeopleListPageState();
}

class _PeopleListPageState extends State<PeopleListPage> {
  late List<Person> people;
  late TextEditingController _searchController;
  bool _isSearching = false;
  Responsibility? responsibilityFilter;
  String previousQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    people = Component.instance.api.searchPeople();

    _searchController.addListener(() {
      previousQuery = _searchController.text;
      _updatePeopleList();
    });
  }

  void _updatePeopleList() {
    setState(() {
      people = Component.instance.api.searchPeople(
        query: previousQuery,
        responsibility: responsibilityFilter,
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingWidget(
          isSearching: _isSearching,
          onClick: () {
            setState(() {
              // show/hide search bar
              _isSearching = !_isSearching;
            });
          },
        ),
        title: _isSearching
            ? TextField(
                key: WidgetKey.search,
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search employee...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white30),
                ),
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              )
            : Text(widget.title),
        actions: [
          responsibilityFilter != null
              ? InkWell(
                  key: WidgetKey.clearFilter,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('CLEAR'),
                    ),
                  ),
                  onTap: () {
                    responsibilityFilter = null;
                    _updatePeopleList();
                  },
                )
              : PopupMenuButton<Responsibility>(
                  key: WidgetKey.filter,
                  icon: Icon(Icons.filter_list),
                  onSelected: (responsibility) {
                    responsibilityFilter = responsibility;
                    _updatePeopleList();
                  },
                  itemBuilder: (BuildContext context) {
                    return Responsibility.values
                        .map((Responsibility responsibility) {
                      return PopupMenuItem<Responsibility>(
                        value: responsibility,
                        child: Text(responsibility.toNameString()),
                      );
                    }).toList();
                  },
                )
        ],
      ),
      body: ListView.builder(
        key: WidgetKey.listOfPeople,
        itemBuilder: (context, index) {
          final person = people[index];
          return PersonItemWidget(
            id: person.id,
            fullName: person.fullName,
            responsibility: person.responsibility.toNameString(),
          );
        },
        itemCount: people.length,
      ),
    );
  }
}

class LeadingWidget extends StatelessWidget {
  final bool isSearching;
  final Function() onClick;

  const LeadingWidget(
      {Key? key, this.isSearching = false, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isSearching ? const Icon(Icons.clear) : const Icon(Icons.search),
      onPressed: () {
        onClick();
      },
    );
  }
}

class PersonItemWidget extends StatelessWidget {
  final int id;
  final String fullName;
  final String responsibility;

  const PersonItemWidget(
      {Key? key,
      required this.id,
      required this.fullName,
      this.responsibility = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fullName),
      subtitle: Text(responsibility),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PersonDetailsPage(personId: id);
        }));
      },
    );
  }
}
