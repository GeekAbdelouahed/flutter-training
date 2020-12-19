class Author {
  final String id;
  final String email;
  final String fullName;

  Author({this.id, this.email, this.fullName});

  factory Author.fromJson(Map<String, dynamic> data) => Author(
        id: data['_id'],
        email: data['email'],
        fullName: data['full_name'],
      );
}
