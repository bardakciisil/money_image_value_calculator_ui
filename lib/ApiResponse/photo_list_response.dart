import '../Models/photo.dart';

class Photos {
  Photos({
    required this.data,
    this.hasError,
    this.message,
  });

  List<Photo> data;
  bool? hasError;
  String? message;

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        data: List<Photo>.from(json["data"].map((x) => Photo.fromJson(x))),
        hasError: json["hasError"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "hasError": hasError,
        "message": message,
      };
}
