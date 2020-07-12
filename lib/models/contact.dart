class Contact {
  int id;
  String name;
  String email;
  String phoneNumber;
  int favorite = 0;
  String profilepic;

  Contact(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.favorite,
      this.profilepic});

  // Convert a contact into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'favorite': favorite,
      'profilepic': profilepic,
    };
  }
}
