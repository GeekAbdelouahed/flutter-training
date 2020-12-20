class Category {
  final String id;
  final String name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(
      id: data['_id'],
      name: data['name'],
    );
  }
}
