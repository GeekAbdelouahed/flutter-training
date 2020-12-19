class Cover {
  final String imageName;
  final String imageUrl;

  Cover({this.imageName, this.imageUrl});

  factory Cover.fromJson(Map<String, dynamic> data) => Cover(
        imageName: data['image_name'],
        imageUrl: data['image_url'],
      );
}
