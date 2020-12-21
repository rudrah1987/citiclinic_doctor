import 'package:city_clinic_doctor/modal/auth/LoginResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  final _loginStream = PublishSubject<LoginResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<LoginResponse> get loginStream => _loginStream.stream;

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

  void login(String phone,
      String password, String longitude, String latitude, int roleType) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository.login(phone, password, longitude, latitude, roleType).then((value){
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _loginStream.sink.add(value);
    }).catchError((error){
      isLoading = false;
     _loadingStream.sink.add(isLoading);
     _errorStream.add(error);
    });
  }
}