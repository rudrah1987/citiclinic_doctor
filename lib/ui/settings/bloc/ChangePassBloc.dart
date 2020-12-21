import 'package:city_clinic_doctor/modal/auth/ChangePassResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class ChangePassBloc extends BaseBloc {
  final _changePassStream = PublishSubject<ChangePassResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<ChangePassResponse> get changePassStream => _changePassStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _changePassStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void changePassword(String oldPass, String newPass, String accessToken, int userID) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    ChangePassResponse r = await repository.changePassword(oldPass, newPass, accessToken, userID);
    print(r);
    isLoading = false;
    _loadingStream.sink.add(isLoading);
    _changePassStream.sink.add(r);

    /*.then((value) {

    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.sink.add(error);
    });*/
  }
}