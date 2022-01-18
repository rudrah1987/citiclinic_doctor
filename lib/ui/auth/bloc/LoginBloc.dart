
import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';
import 'package:city_clinic_doctor/new/customs/logger_global.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

ValueNotifier<UserDetailResponse> currentUser = new ValueNotifier(UserDetailResponse());

class LoginBloc extends BaseBloc {
  final _loginStream = PublishSubject<UserDetailResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<UserDetailResponse> get loginStream => _loginStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _loginStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  //

  void login(String phone, String password, String longitude, String latitude,
      int roleType) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository
        .login(phone, password, longitude, latitude, roleType)
        .then((value) {
      isLoading = false;
      if(value.success==null){

      }
      if (value.success) {
        // setCurrentUser(value);
        _loadingStream.sink.add(isLoading);
        _loginStream.sink.add(value);
        // if(value.user!=null){
        //   PreferenceHelper.saveUser(value.user);
        // }
        // PreferenceHelper.getUser().then((value) {


          currentUser.value.user = value.user;
          currentUser.notifyListeners();
          gLogger.i('UserName getUser-${currentUser.value.user.name}');
        //
        // });
        // gLogger.i('UserName-${currentUser.value.user.name}');
      }
      else{
        Fluttertoast.showToast(msg: value.message);
        print('------------------${value.message}');
        isLoading = false;
        _loadingStream.sink.add(isLoading);
      }
    }).catchError((error) {
      print('------------------${error}');

      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}
