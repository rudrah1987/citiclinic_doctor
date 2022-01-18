import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class AppointmentBloc extends BaseBloc {
  final _appointmentStream = PublishSubject<AppointmentListResponse>();
  var docVisitStream = [];
  var homeVisitStream = [];
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<AppointmentListResponse> get appointmentStream =>
      _appointmentStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _appointmentStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void getAppointmentList(int doc_ID) async {
    print("calling------------getAppointmentList $doc_ID");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository.getApointments(doc_ID).then((value) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _appointmentStream.sink.add(value);
      for (var i in value.data.bookingList) {
        if (i.otherBookingDeatils.visitType == '0') {
          docVisitStream.add(i);
        } else
          homeVisitStream.add(i);
      }
      print('_homeVisitList-------$docVisitStream');
      print('_docVisitList-------$homeVisitStream');
    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}
