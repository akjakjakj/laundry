import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/authentication/model/registration_request_model.dart';
import 'package:laundry/views/authentication/model/user_model.dart';
import 'package:laundry/views/repo/login_repo.dart';
import 'package:laundry/views/repo/registration_repo.dart';

class AuthProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  LoginRepo loginRepo = sl.get<LoginRepo>();
  RegistrationRepo registrationRepo = sl.get<RegistrationRepo>();
  UserData? userData;
  String? errorMessage;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registrationEmailController = TextEditingController();
  TextEditingController registrationNameController = TextEditingController();
  TextEditingController registrationPasswordController =
      TextEditingController();
  TextEditingController registrationConfirmPasswordController =
      TextEditingController();

  Future<void> login({Function()? onSuccess}) async {
    updateBtnLoaderState(true);
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic?>>? resp;
    if (network) {
      try {
        resp = loginRepo
            .login(
                email: loginEmailController.text.trim(),
                password: loginPasswordController.text.trim(),
                deviceToken: '1')
            .thenRight((right) {
          userData = right;
          updateErrorMessage(null);
          if (onSuccess != null) onSuccess();
          updateBtnLoaderState(false);
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateErrorMessage('Oops..! Something went wrong');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateErrorMessage('Oops..! Something went wrong');
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
      }
    }
  }

  Future<void> register({Function()? onSuccess}) async {
    updateBtnLoaderState(true);
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic?>>? resp;
    if (network) {
      try {
        RegistrationRequestModel registrationRequestModel =
            RegistrationRequestModel(
                password: registrationPasswordController.text.trim(),
                email: registrationEmailController.text.trim(),
                confirmPassword:
                    registrationConfirmPasswordController.text.trim(),
                name: registrationNameController.text.trim(),
                deviceToken: '1');
        resp = registrationRepo
            .register(registrationRequestModel)
            .thenRight((right) {
          userData = right;
          updateErrorMessage(null);
          if (onSuccess != null) onSuccess();
          updateBtnLoaderState(false);
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateErrorMessage('Oops..! Something went wrong');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateErrorMessage('Oops..! Something went wrong');
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
      }
    }
  }

  void updateErrorMessage(String? msg) {
    errorMessage = msg;
    notifyListeners();
  }

  void clearRegistrationControllers() {
    registrationConfirmPasswordController.clear();
    registrationPasswordController.clear();
    registrationNameController.clear();
    registrationEmailController.clear();
    registrationNameController.clear();
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }

  @override
  void updateBtnLoaderState(bool val) {
    btnLoaderState = val;
    notifyListeners();
    super.updateBtnLoaderState(val);
  }
}
