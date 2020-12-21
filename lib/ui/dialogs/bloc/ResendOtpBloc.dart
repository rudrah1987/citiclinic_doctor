import 'package:city_clinic_doctor/modal/auth/ResendOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/VerifyOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class ResendOtpBloc extends BaseBloc {
  final _resendOtpStream = PublishSubject<ResendOtpResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<ResendOtpResponse> get resendOtpStream => _resendOtpStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _resendOtpStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void resendOtp(String phone, int userID) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);

    ResendOtpResponse r =  await repository.resendOtp(phone, userID);
    isLoading = false;
    _loadingStream.sink.add(isLoading);
    _resendOtpStream.sink.add(r);
   /*.then((value) {
      print(value);

    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      // _errorStream.sink.add(Error.fromJson(error));
    });*/
  }
}
