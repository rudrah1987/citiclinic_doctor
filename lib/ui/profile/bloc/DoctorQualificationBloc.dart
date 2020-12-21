import 'dart:io';

import 'package:city_clinic_doctor/modal/profile/QualificationResponse.dart';
import 'package:city_clinic_doctor/modal/profile/RegistrationResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class DoctorQualificationBloc extends BaseBloc{
  final _qualificationStream = PublishSubject<QualificationResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<QualificationResponse> get qualificationStream => _qualificationStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _qualificationStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void doctorQualification(String accessToken, int userID,
      String degree, String university, String passingYear, File regProofFile) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository.doctorQualification(accessToken, userID, degree, university, passingYear, regProofFile).then((value){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _qualificationStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}