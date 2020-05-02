class User {
  int userId;
  String firstName;
  String lastName;

  User(this.userId, this.firstName, this.lastName);

  static List<User> getusers() {
    return <User>[
      User(1, "glory", "Agat"),
      User(2, "Justin", "obi"),
      User(3, "Israel", "Akpan"),
      User(4, "Asu", "David"),
      User(5, "Daniel", "John"),
    ];
  }
}
