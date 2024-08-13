import 'package:money_img_value_calculator_ui/Models/update_photo_dto.dart';

import 'mobile_api_response.dart';

class UpdatePhotoResponse extends MobileApiResponse {
  final UpdatePhotoDto updatePhoto;

  UpdatePhotoResponse({
    required this.updatePhoto,
    super.hasError,
    super.errorMessage,
  });

  factory UpdatePhotoResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePhotoResponse(
        updatePhoto: json["updatePhoto"],
        hasError: json["hasError"],
        errorMessage: json["message"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "updatePhoto": updatePhoto,
        "hasError": hasError,
        "message": errorMessage,
      };
}
