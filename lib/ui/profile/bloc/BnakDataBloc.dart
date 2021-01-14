import 'package:city_clinic_doctor/modal/profile/BankDetailResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class  BankDataBloc extends BaseBloc{
  
  final _bankDtaStream = PublishSubject<BankResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<BankResponse> get bankStream => _bankDtaStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _bankDtaStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }


  getBankList() async {
    print("getBankList calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(isLoading);
    await repository.getBanks().then((value) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _bankDtaStream.sink.add(value);
    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}