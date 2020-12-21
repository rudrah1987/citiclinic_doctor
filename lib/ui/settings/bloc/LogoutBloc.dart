import 'package:city_clinic_doctor/modal/auth/LogoutResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class LogoutBloc extends BaseBloc {
  final _logoutStream = PublishSubject<LogoutResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<LogoutResponse> get logoutStream => _logoutStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _logoutStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void logoutUser(String accessToken, int userID) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    LogoutResponse r = await repository.logoutUser(accessToken, userID);
    isLoading = false;
    _loadingStream.sink.add(false);
    _logoutStream.sink.add(r);

       /* .then((value) {
      print(value);
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _logoutStream.sink.add(value);
    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.sink.add(error);
    });*/
  }
}