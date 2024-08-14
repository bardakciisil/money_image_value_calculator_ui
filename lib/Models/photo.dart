class Photo {
  final int id;
  final String photoName;
  final String photoImage;

  Photo({
    required this.id,
    required this.photoName,
    required this.photoImage,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] as int,
        photoName: json["photoName"] as String,
        photoImage: json["photoImage"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photoName": photoName,
        "photoImage": photoImage,
      };
}
