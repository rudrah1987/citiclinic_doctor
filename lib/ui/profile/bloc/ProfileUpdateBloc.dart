import 'dart:io';

import 'package:city_clinic_doctor/modal/profile/ProfileUpdateResponse.dart';
import 'package:city_clinic_doctor/modal/profile/QualificationResponse.dart';
import 'package:city_clinic_doctor/modal/profile/RegistrationResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class ProfileUpdateBloc extends BaseBloc{
  final _profileUpdateStream = PublishSubject<ProfileUpdateResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<ProfileUpdateResponse> get profileUpdateStream => _profileUpdateStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _profileUpdateStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void profileUpdate(String accessToken, int userID,
      String name, String gender, String dob, String exprience, int specialityID, String hospital_address, String land_mark,
      String availability_for_home_visit, String consultation_type, String city_id, String state_id,
      String country_id, String bank_name, String account_holder_name,String account_number,
      String ifsc_code) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository.doctorProfileUpdate(accessToken, userID, name, gender, dob, exprience, specialityID, hospital_address, land_mark,
        availability_for_home_visit, consultation_type, city_id, state_id, country_id, bank_name, account_holder_name,
        account_number, ifsc_code).then((value){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _profileUpdateStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}