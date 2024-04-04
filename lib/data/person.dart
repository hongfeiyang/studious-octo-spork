class Person {
  final int id;
  final String fullName;
  final Responsibility responsibility;
  final String room;
  final String phone;
  final String email;

  Person(this.id, this.fullName, this.responsibility, this.room, this.phone, this.email);
}

enum Responsibility { DevOps, Accounting, IT_Support, Marketing, Infrastructure, Sales }
