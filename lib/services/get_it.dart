import 'package:get_it/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/repo/login_repo.dart';
import 'package:laundry/views/repo/registration_repo.dart';

GetIt sl = GetIt.instance;

void setUpLocator() {
  sl.registerLazySingleton(() => Helpers());
  sl.registerLazySingleton(() => HttpReq());
  sl.registerLazySingleton(() => Validator());
  sl.registerLazySingleton(() => LoginRepo());
  sl.registerLazySingleton(() => RegistrationRepo());
}
