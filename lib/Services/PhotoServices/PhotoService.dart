import 'package:money_img_value_calculator_ui/ApiResponse/mobile_api_response.dart';
import 'package:money_img_value_calculator_ui/ApiResponse/photo_list_response.dart';
import 'package:money_img_value_calculator_ui/ApiResponse/photo_response.dart';
import '/ApiResponse/update_photo_response.dart';
import '../api_client.dart';

import 'package:money_img_value_calculator_ui/Services/PhotoServices/IPhotoService.dart';

class PhotoService implements IPhotoService {
  ApiClient? _apiClient;
  PhotoService(ApiClient apiClient) {
    _apiClient = apiClient;
    _apiClient!.onResponseCallback = onResponseCallback;
    _apiClient!.onErrorCallback = onErrorCallback;
  }

  @override
  Future<MobileApiResponse> createPhoto(PhotoResponse photo) {
    // TODO: implement createPhoto
    throw UnimplementedError();
  }

  @override
  Future<MobileApiResponse> deleteAdvert(int id) {
    // TODO: implement deleteAdvert
    throw UnimplementedError();
  }

  @override
  Future<PhotoResponse> getPhoto(int id) {
    // TODO: implement getPhoto
    throw UnimplementedError();
  }

  @override
  Future<Photos> getPhotos() {
    // TODO: implement getPhotos
    throw UnimplementedError();
  }

  @override
  onErrorCallback(MobileApiResponse response) {
    // TODO: implement onErrorCallback
    throw UnimplementedError();
  }

  @override
  onResponseCallback(MobileApiResponse response) {
    // TODO: implement onResponseCallback
    throw UnimplementedError();
  }

  @override
  Future<UpdatePhotoResponse> updatePhoto(int id) {
    // TODO: implement updatePhoto
    throw UnimplementedError();
  }
}
