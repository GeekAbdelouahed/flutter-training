import 'cover.dart';

class Author {
  final String id;
  final String email;
  final String fullName;
  final Cover image;

  Author({this.id, this.email, this.fullName, this.image});

  factory Author.fromJson(Map<String, dynamic> data) => Author(
        id: data['_id'],
        email: data['email'],
        fullName: data['full_name'],
        image: Cover.fromJson(data['profile_image']),
      );
}
