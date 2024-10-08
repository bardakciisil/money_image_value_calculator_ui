import '../../ApiResponse/photo_list_response.dart';
import '../../ApiResponse/mobile_api_response.dart';
import '../../ApiResponse/photo_response.dart';

import '../ibase_service.dart';

abstract class IPhotoService implements IBaseService {
  Future<Photos> getPhotos();
  Future<MobileApiResponse> createPhoto(PhotoResponse photo);
  Future<MobileApiResponse> deletePhoto(int id);
  String getUploadUrl(String photoImage);
}
