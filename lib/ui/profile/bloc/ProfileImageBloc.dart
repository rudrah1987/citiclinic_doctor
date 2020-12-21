import 'dart:io';

import 'package:city_clinic_doctor/modal/auth/LoginResponse.dart';
import 'package:city_clinic_doctor/modal/profile/ProfileImageResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class ProfileImageBloc extends BaseBloc {
  final _profileImageStream = PublishSubject<ProfileImageResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<ProfileImageResponse> get profileImageStream => _profileImageStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _profileImageStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void profileORCoverImage(String accessToken, int userID,
      String keyword, File imageFile) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository.profileORCoverImage(accessToken, userID, keyword, imageFile).then((value){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _profileImageStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
     _loadingStream.sink.add(isLoading);
     _errorStream.add(error);
    });
  }
}