import '../ApiResponse/mobile_api_response.dart';

abstract class IBaseService {
  onResponseCallback(MobileApiResponse response);
  onErrorCallback(MobileApiResponse response);
}
