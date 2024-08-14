import 'package:money_image_value_calculator_ui/Models/photo.dart';
import 'mobile_api_response.dart';

class PhotoResponse extends MobileApiResponse {
  final Photo photo;

  PhotoResponse({
    required this.photo,
    super.hasError,
    super.errorMessage,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => PhotoResponse(
        photo: Photo.fromJson(json["photo"] as Map<String, dynamic>),
        hasError: json["hasError"] as bool? ?? false,
        errorMessage: json["message"] as String? ?? "",
      );

  @override
  Map<String, dynamic> toJson() => {
        "photo": photo.toJson(),
        "hasError": hasError,
        "message": errorMessage,
      };
}
