# Employees catalogue
## Introduction
The project is a simple app that displays a search with a list of people responsible for different areas in the company, for example, IT, Payroll, etc. It should allow for checking where selected employees sit, their phone number or their email address.

You can find two Pages in the project: `PeopleListPage` and `PersonDetailsPage`. When an employee is selected in the `PeopleListPage`, the user is taken to the `PersonDetailsPage`.

## Problem Statement
As the project is not finished and the deadline is coming, you are now responsible for finishing the application. The pages are already created, the `Api` class contains data, but getters are not implemented. The `PersonDetailsPage` contains only the constructor and the Scaffold.

You need to implement the `itemBuilder` for the `ListView` and edit the `PeopleListPage`, so that it searches for and displays a list of people from the `Api`, as well as an ability to filter it. The `PersonItemWidget` should open the `PersonDetailsPage`. Then, you have to handle the input data in the `PersonDetailsPage` and create a layout with the data of a selected employee.

1. Implement `toNameString` for `ResponsibilityExtension` to have a well formatted string for Responsibility, e.g., `Responsibility.IT_Support` -> `IT Support`.
2. Implement the `itemBuilder` for the `ListView` and the `PersonItemWidget`. The `PersonItemWidget` has to display the person’s full name and his/her responsibility with an extension. All items should be visible on the screen for testing purposes.
3. Implement `onClick` for the `LeadingWidget` to show and hide the search `TextField`. Update the list when the query is typed.
4. When some of the filters are selected, filter the list by this responsibility.
5. When the `PersonItemWidget` is clicked, navigate to the `PersonDetailsPage` and pass the selected item ID.
6. Implement the `PersonDetailsPage` to show all details of the selected person.
7. If the item ID is not given on the `PersonDetailsPage`, close the page immediately.

## Note

Please be careful when editing `pubspec.yaml` in your project. This task does not require any changes in it. It is generally accepted to add new packages, but changing or removing existing packages or configuration can cause the project and the verification tests function in an unexpected way and give an unreliable score.
