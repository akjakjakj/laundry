import 'package:get_it/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/http_req.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/authentication/repo/forgot_password_repo.dart';
import 'package:laundry/views/authentication/repo/login_repo.dart';
import 'package:laundry/views/authentication/repo/registration_repo.dart';
import 'package:laundry/views/eco_dry_clean/repo/eco_dry_clean_repo.dart';
import 'package:laundry/views/main_screen/home_screen/repo/home_screen_repo.dart';
import 'package:laundry/views/main_screen/past_orders/repo/past_orders_repo.dart';
import 'package:laundry/views/manage_address/repo/manage_address_repo.dart';

GetIt sl = GetIt.instance;

void setUpLocator() {
  sl.registerLazySingleton(() => Helpers());
  sl.registerLazySingleton(() => HttpReq());
  sl.registerLazySingleton(() => Validator());
  sl.registerLazySingleton(() => LoginRepo());
  sl.registerLazySingleton(() => RegistrationRepo());
  sl.registerLazySingleton(() => ForgotPasswordRepo());
  sl.registerLazySingleton(() => SharedPreferencesHelper());
  sl.registerLazySingleton(() => HomeRepo());
  sl.registerLazySingleton(() => EcoDryCleanRepo());
  sl.registerLazySingleton(() => PastOrdersRepo());
  sl.registerLazySingleton(() => ManageAddressRepo());
}
