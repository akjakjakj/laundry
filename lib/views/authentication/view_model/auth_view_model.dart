import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/app_config.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/services/shared_preference_helper.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/authentication/model/registration_request_model.dart';
import 'package:laundry/views/authentication/model/user_model.dart';
import 'package:laundry/views/authentication/repo/forgot_password_repo.dart';
import 'package:laundry/views/authentication/repo/login_repo.dart';
import 'package:laundry/views/authentication/repo/registration_repo.dart';

class AuthProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  LoginRepo loginRepo = sl.get<LoginRepo>();
  RegistrationRepo registrationRepo = sl.get<RegistrationRepo>();
  ForgotPasswordRepo forgotPasswordRepo = sl.get<ForgotPasswordRepo>();
  SharedPreferencesHelper sharedPreferencesHelper =
      sl.get<SharedPreferencesHelper>();

  UserData? userData;
  String? errorMessage;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registrationEmailController = TextEditingController();
  TextEditingController registrationMobileNumberController =
      TextEditingController();
  TextEditingController registrationNameController = TextEditingController();
  TextEditingController registrationPasswordController =
      TextEditingController();
  TextEditingController registrationConfirmPasswordController =
      TextEditingController();
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController forgotPasswordOtpController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController resetPasswordConfirmationController =
      TextEditingController();

  FocusNode registerMobileNumberFocusNode = FocusNode();

  Future<void> login({
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    updateBtnLoaderState(true);
    final network = await helpers.isInternetAvailable();
    String deviceToken =
        AppConfig.deviceToken ?? await sharedPreferencesHelper.getDeviceToken();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      try {
        resp = loginRepo
            .login(
                email: loginEmailController.text.trim(),
                password: loginPasswordController.text.trim(),
                deviceToken: deviceToken)
            .thenRight((right) async {
          userData = right;
          updateErrorMessage(null);
          await sharedPreferencesHelper.saveUserToken(userData?.token ?? '');
          await sharedPreferencesHelper.saveLoginStatus(true);
          if (onSuccess != null) onSuccess();
          updateBtnLoaderState(false);
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          updateBtnLoaderState(false);
          if (onFailure != null) onFailure();
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateErrorMessage('Oops..! Something went wrong');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          if (onFailure != null) onFailure();
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateErrorMessage('Oops..! Something went wrong');
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        if (onFailure != null) onFailure();
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> register({Function()? onSuccess, Function()? onFailure}) async {
    updateBtnLoaderState(true);
    final network = await helpers.isInternetAvailable();
    String deviceToken =
        AppConfig.deviceToken ?? await sharedPreferencesHelper.getDeviceToken();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      try {
        RegistrationRequestModel registrationRequestModel =
            RegistrationRequestModel(
                password: registrationPasswordController.text.trim(),
                email: registrationEmailController.text.trim(),
                confirmPassword:
                    registrationConfirmPasswordController.text.trim(),
                name: registrationNameController.text.trim(),
                deviceToken: deviceToken,
                mobileNumber: registrationMobileNumberController.text.trim());
        resp = registrationRepo
            .register(registrationRequestModel)
            .thenRight((right) async {
          userData = right;
          await sharedPreferencesHelper.saveUserToken(userData?.token ?? '');
          await sharedPreferencesHelper.saveLoginStatus(true);
          updateErrorMessage(null);
          if (onSuccess != null) onSuccess();
          updateBtnLoaderState(false);
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          updateBtnLoaderState(false);
          if (onFailure != null) onFailure();
          updateLoadState(LoaderState.error);
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        }).onError((error, stackTrace) {
          updateErrorMessage('Oops..! Something went wrong');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          if (onFailure != null) onFailure();
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateErrorMessage('Oops..! Something went wrong');
        if (onFailure != null) onFailure();
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> requestForgotPasswordOtp({
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    updateBtnLoaderState(true);
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      try {
        resp = forgotPasswordRepo
            .requestForgotPasswordOtp(forgotPasswordEmailController.text.trim())
            .thenRight((right) {
          if (onSuccess != null) onSuccess();
          updateBtnLoaderState(false);
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          updateBtnLoaderState(false);
          if (onFailure != null) onFailure();
          return Left(left);
        }).onError((error, stackTrace) {
          updateErrorMessage('Oops..! Something went wrong');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          if (onFailure != null) onFailure();
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateErrorMessage('Oops..! Something went wrong');
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        if (onFailure != null) onFailure();
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> verifyForgotPasswordOtp(
      {Function()? onSuccess, Function()? onFailure}) async {
    updateBtnLoaderState(true);
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      try {
        resp = forgotPasswordRepo
            .verifyForgotPasswordOtp(forgotPasswordEmailController.text.trim(),
                forgotPasswordOtpController.text.trim())
            .thenRight((right) {
          if (onSuccess != null) onSuccess();
          updateBtnLoaderState(false);
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          updateBtnLoaderState(false);
          if (onFailure != null) onFailure();
          return Left(left);
        }).onError((error, stackTrace) {
          updateErrorMessage('Oops..! Something went wrong');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          if (onFailure != null) onFailure();
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateErrorMessage('Oops..! Something went wrong');
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        if (onFailure != null) onFailure();
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> resetPassword(
      {Function()? onSuccess, Function()? onFailure}) async {
    updateBtnLoaderState(true);
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      try {
        resp = forgotPasswordRepo
            .resetPassword(
                email: forgotPasswordEmailController.text.trim(),
                confirmPassword:
                    resetPasswordConfirmationController.text.trim(),
                password: resetPasswordController.text.trim())
            .thenRight((right) {
          if (onSuccess != null) onSuccess();
          updateBtnLoaderState(false);
          return Right(right);
        }).thenLeft((left) {
          updateErrorMessage(left.message ?? '');
          updateBtnLoaderState(false);
          if (onFailure != null) onFailure();
          return Left(left);
        }).onError((error, stackTrace) {
          updateErrorMessage('Oops..! Something went wrong');
          updateBtnLoaderState(false);
          updateLoadState(LoaderState.error);
          if (onFailure != null) onFailure();
          return Left(ApiResponse(exceptions: ApiExceptions.error));
        });
      } catch (e) {
        updateErrorMessage('Oops..! Something went wrong');
        updateBtnLoaderState(false);
        //'Login $e'.log(name: 'LoginProvider');
        if (onFailure != null) onFailure();
        updateLoadState(LoaderState.error);
      }
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
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
    registrationMobileNumberController.clear();
    notifyListeners();
  }

  void clearLoginControllers() {
    loginEmailController.clear();
    loginPasswordController.clear();
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
