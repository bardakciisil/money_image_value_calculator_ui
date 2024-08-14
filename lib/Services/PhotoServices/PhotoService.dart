import '../../ApiResponse/mobile_api_response.dart';
import '../../ApiResponse/photo_list_response.dart';
import '../../ApiResponse/photo_response.dart';
import '../api_client.dart';

import 'IPhotoService.dart';

class PhotoService implements IPhotoService {
  final ApiClient _apiClient;

  PhotoService(this._apiClient) {
    _apiClient.onResponseCallback = onResponseCallback;
    _apiClient.onErrorCallback = onErrorCallback;
  }

  @override
  Future<MobileApiResponse> createPhoto(PhotoResponse photoResponse) async {
    try {
      final response = await _apiClient.postRequest("photo/", photoResponse);
      if (response.statusCode == 401) {
        print("UnAuthorized");
      }
      return MobileApiResponse.fromJson(response.data);
    } catch (e) {
      print('Error creating photo: $e');
      rethrow;
    }
  }

  @override
  Future<MobileApiResponse> deletePhoto(int id) async {
    try {
      final response = await _apiClient.deleteById("photo/$id");
      if (response.statusCode == 401) {
        print("UnAuthorized");
      }
      return MobileApiResponse.fromJson(response.data);
    } catch (e) {
      print('Error deleting photo: $e');
      rethrow;
    }
  }

  @override
  Future<Photos> getPhotos() async {
    try {
      final response = await _apiClient.getRequest("photos/");
      if (response.statusCode == 401) {
        print("UnAuthorized");
      }
      return Photos.fromJson(response.data);
    } catch (e) {
      print('Error fetching photos: $e');
      rethrow;
    }
  }

  @override
  void onErrorCallback(MobileApiResponse response) {
    print("Response Error: ${response.errorMessage}");
  }

  @override
  void onResponseCallback(MobileApiResponse response) {
    print("Response Status: ${response.hasError}");
  }

  @override
  String getUploadUrl(String photoImage) {
    return _apiClient.getUploadUrl(photoImage);
  }
}
