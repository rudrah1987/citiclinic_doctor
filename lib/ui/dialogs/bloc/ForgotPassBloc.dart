import 'package:city_clinic_doctor/modal/auth/ForgotPassResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPassBloc extends BaseBloc {
  final _forgotPassStream = PublishSubject<ForgotPassResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<ForgotPassResponse> get forgotPassStream => _forgotPassStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _forgotPassStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void forgotPass(String phone) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(isLoading);
    await repository.forgotPassword(phone).then((value) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _forgotPassStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}