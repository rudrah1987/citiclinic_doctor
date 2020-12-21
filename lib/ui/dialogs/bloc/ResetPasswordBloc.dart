import 'package:city_clinic_doctor/modal/auth/ForgotPassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassVerifyOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ResetPassResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordBloc extends BaseBloc {
  final _resetPassStream = PublishSubject<ResetPassResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<ResetPassResponse> get resetPassStream => _resetPassStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _resetPassStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void resetPassword(String password, int userID) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(isLoading);
    await repository.resetPassword(password, userID).then((value) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _resetPassStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}