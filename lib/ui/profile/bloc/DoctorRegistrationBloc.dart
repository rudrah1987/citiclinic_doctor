import 'dart:io';

import 'package:city_clinic_doctor/modal/profile/RegistrationResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class DoctorRegistrationBloc extends BaseBloc{
  final _registrationStream = PublishSubject<RegistrationResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<RegistrationResponse> get registrationStream => _registrationStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _registrationStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void doctorRegistration(String accessToken, int userID,
      String regNumber, String regCouncil, String regDate, File regProofFile) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository.doctorRegistration(accessToken, userID, regNumber, regCouncil, regDate, regProofFile).then((value){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _registrationStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}