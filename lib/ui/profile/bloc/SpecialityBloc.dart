import 'package:city_clinic_doctor/modal/profile/BankDetailResponse.dart';
import 'package:city_clinic_doctor/modal/profile/CityResponse.dart';
import 'package:city_clinic_doctor/modal/profile/SpecialityResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class SpecialityBloc extends BaseBloc {
  final _specialityStream = PublishSubject<SpecialityResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<SpecialityResponse> get specialityStream => _specialityStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _specialityStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void getSpecialityData() async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(isLoading);
    await repository.getSpecialityData().then((value) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _specialityStream.sink.add(value);
    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }

  // getBankList() async {
  //   print("calling");
  //   if (isLoading) return;
  //   isLoading = true;
  //   _loadingStream.sink.add(isLoading);
  //   await repository.getBanks().then((value) {
  //     isLoading = false;
  //     _loadingStream.sink.add(isLoading);
  //     _bankDtaStream.sink.add(value);
  //   }).catchError((error) {
  //     isLoading = false;
  //     _loadingStream.sink.add(isLoading);
  //     _errorStream.add(error);
  //   });
  // }
}
