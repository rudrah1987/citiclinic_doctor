import 'package:city_clinic_doctor/modal/auth/SignUpResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BaseBloc {
  final _signUpStream = PublishSubject<SignUpResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<SignUpResponse> get signUpStream => _signUpStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _signUpStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void signUp(String name, String phone,
      String email, String password, String fb_token, String longitude, String latitude) async {
      print("calling");
      if (isLoading) return;
      isLoading = true;
      _loadingStream.sink.add(isLoading);
      SignUpResponse r = await repository.signUp(name, phone, email, password, fb_token, longitude, latitude);
      // _signUpStream.sink.add(r);
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _signUpStream.sink.add(r);
  }
}