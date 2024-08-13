import 'package:get_it/get_it.dart';
import '../Services/PhotoServices/PhotoService.dart';
import '../Services/api_client.dart';

GetIt getIt = GetIt.instance;
void configureInjection() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<PhotoService>(
      () => PhotoService(getIt<ApiClient>()));
}
