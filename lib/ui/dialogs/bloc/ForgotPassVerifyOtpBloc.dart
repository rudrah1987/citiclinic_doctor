import 'package:city_clinic_doctor/modal/auth/ForgotPassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassVerifyOtpResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPassVerifyOtpBloc extends BaseBloc {
  final _forgotPassVerifyOtpStream = PublishSubject<ForgotPassVerifyOtpResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<ForgotPassVerifyOtpResponse> get forgotPassVerifyOtpStream => _forgotPassVerifyOtpStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _forgotPassVerifyOtpStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void forgotPassVerifyOtp(String phone, String otp, String userLoginID, int userID) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(isLoading);
    await repository.forgotPassVerifyOtp(phone, otp, userLoginID, userID).then((value) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _forgotPassVerifyOtpStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}