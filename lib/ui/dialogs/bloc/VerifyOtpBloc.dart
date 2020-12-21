import 'package:city_clinic_doctor/modal/auth/VerifyOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class VerifyOtpBloc extends BaseBloc {
  final _otpVerifyStream = PublishSubject<VerifyOtpResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<VerifyOtpResponse> get otpVerifyStream => _otpVerifyStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _otpVerifyStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void verifyOtp(String phone, String otp, String userLogID, int userID) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);

    VerifyOtpResponse r =  await repository.verifyOtp(phone, otp, userLogID, userID);
    isLoading = false;
    _loadingStream.sink.add(isLoading);
    _otpVerifyStream.sink.add(r);
   /*.then((value) {
      print(value);

    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      // _errorStream.sink.add(Error.fromJson(error));
    });*/
  }
}
