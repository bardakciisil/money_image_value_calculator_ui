import 'package:money_img_value_calculator_ui/Models/photo.dart';
import 'mobile_api_response.dart';

class PhotoResponse extends MobileApiResponse {
  final Photo photo;

  PhotoResponse({
    required this.photo,
    super.hasError,
    super.errorMessage,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => PhotoResponse(
        photo: json["photo"],
        hasError: json["hasError"],
        errorMessage: json["message"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "photo": photo,
        "hasError": hasError,
        "message": errorMessage,
      };
}
