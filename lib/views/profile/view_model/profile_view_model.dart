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

  Future<void> getProfileDetail() async {
    final network = await helpers.isInternetAvailable();
    Future<Either<ApiResponse, dynamic>>? resp;
    if (network) {
      updateLoadState(LoaderState.loading);
      resp = profileRepo.getProfile().thenRight((right) {
        profileResponse = right;
        updateProfileDetail(profileResponse);
        return Right(right);
      }).thenLeft((left) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    }
  }

  Future<void> deleteProfile(
      {Function()? onSuccess, Function()? onFailure}) async {
    final network = await helpers.isInternetAvailable();
    if (network) {
      updateLoadState(LoaderState.loading);
      profileRepo.deleteProfile().thenRight(
        (right) {
          if (right['success']) {
            if (onSuccess != null) onSuccess();
          } else {
            if (onFailure != null) onFailure();
          }
          updateLoadState(LoaderState.loaded);
          return Right(right);
        },
      ).thenLeft((left) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      }).onError((error, stackTrace) {
        updateLoadState(LoaderState.error);
        return Left(ApiResponse(exceptions: ApiExceptions.error));
      });
    }
  }

  void updateProfileDetail(ProfileModel? profileDetailResponse) {
    if (profileDetailResponse?.user != null) {
      updateLoadState(LoaderState.loaded);
    } else {
      updateLoadState(LoaderState.noData);
    }
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
