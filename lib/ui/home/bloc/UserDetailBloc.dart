import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class UserDetailBloc extends BaseBloc {
  final _userDetailStream = PublishSubject<UserDetailResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<UserDetailResponse> get userDetailStream => _userDetailStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _userDetailStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void userDetailData(String accessToken, int userID) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    UserDetailResponse loginData = await repository.userDetail(accessToken, userID);
    isLoading = false;
    _loadingStream.sink.add(isLoading);
    _userDetailStream.sink.add(loginData);
  }
}