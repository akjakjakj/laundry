import 'package:country_picker/country_picker.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry/services/api_reponse.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/profile/model/profile_model.dart';
import 'package:laundry/views/profile/repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier with ProviderHelperClass {
  Helpers helpers = sl.get<Helpers>();
  ProfileRepo profileRepo = sl.get<ProfileRepo>();

  ProfileModel? profileResponse;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: '971',
    countryCode: 'AE',
    e164Key: '971-AE',
    name: 'United Arab Emirates',
    e164Sc: 0,
    geographic: true,
    level: 0,
    example: '',
    displayName: '',
    displayNameNoCountryCode: '',
  );

  Future<void> getProfileDetail() async {
    final network = await helpers.isInternetAvailable();
    if (network) {
      updateLoadState(LoaderState.loading);
      profileRepo.getProfile().thenRight((right) {
        profileResponse = right;
        updateProfileDetail(profileResponse);
        assignValuesToTextFields(profileResponse);
        return Right(right);
      }).thenLeft((left) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> updateProfile(
      {Function()? onSuccess, Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    if (network) {
      updateBtnLoaderState(true);
      profileRepo
          .updateProfile(
              email: emailTextEditingController.text.trim(),
              phoneNumber: phoneTextEditingController.text.trim(),
              name: nameTextEditingController.text.trim())
          .fold((left) {
        updateBtnLoaderState(false);
        if (onFailure != null) onFailure();
      }, (right) {
        profileResponse = right;
        updateProfileDetail(profileResponse);
        updateBtnLoaderState(false);
        if (onSuccess != null) onSuccess();
      }).onError((error, stackTrace) {
        updateBtnLoaderState(false);
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  Future<void> deleteProfile(
      {Function()? onSuccess, Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    if (network) {
      updateBtnLoaderState(true);
      profileRepo.deleteProfile().thenRight(
        (right) {
          if (right['status']) {
            if (onSuccess != null) onSuccess();
          } else {
            if (onFailure != null) onFailure();
          }
          updateBtnLoaderState(false);
          return Right(right);
        },
      ).thenLeft((left) {
        if (onFailure != null) onFailure();
        updateLoadState(LoaderState.error);
        updateBtnLoaderState(false);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        updateBtnLoaderState(false);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    } else {
      helpers
          .errorToast('Network Error... Please check your internet connection');
    }
  }

  void updateProfileDetail(ProfileModel? profileDetailResponse) {
    if (profileDetailResponse?.user != null) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }
  }

  void assignValuesToTextFields(ProfileModel? profileModel) {
    nameTextEditingController.text = profileModel?.user?.name ?? '';
    emailTextEditingController.text = profileModel?.user?.email ?? '';
    phoneTextEditingController.text = profileModel?.user?.phone ?? '';
    if (profileModel?.user?.country != null) {
      selectedCountry = profileModel!.user!.country!;
    }
  }

  void updateCountryData(Country country) {
    selectedCountry = country;
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
