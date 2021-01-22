import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class MyAppointmentBloc extends BaseBloc {
  final _onGoingAppointmentStream = PublishSubject<AppointmentListResponse>();
  final _pastAppointmentStream = PublishSubject<AppointmentListResponse>();


  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<AppointmentListResponse> get pastAppointmentStream =>
      _pastAppointmentStream.stream;
  Stream<AppointmentListResponse> get onGoingAppointmentStream =>
      _onGoingAppointmentStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;
  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _pastAppointmentStream?.close();
    _onGoingAppointmentStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void getOnGoingAppointments(int doc_ID) async {
    // _appointmentStream.
    print("calling------------getOnGoingAppointments $doc_ID");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.add(true);
    repository.getOnGoingOrUpcomingAppointments(doc_ID,'upcoming').then((value) {
      isLoading = false;
      print("-----------------object-------------------$value-");

      print("object\\\\\\\\ ");
      _loadingStream.add(isLoading);
      _onGoingAppointmentStream.add(value);
      // for (var i in value.data) {
      //   print("------------getOnGoingAppointments VISIT TYPE   ${i.otherBookingDeatils.visitType}");
      //
      //   if (i.otherBookingDeatils.visitType == '1') {
      //     onGoingDocVisitStreamList.add(i);
      //   } else
      //     onGoingHomeVisitStreamList.add(i);
      // }
      // print('onGoingDocVisitStreamList-------$onGoingDocVisitStreamList');
      // print('_docVisitList-------$onGoingDocVisitStreamList');
    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
  void getPastAppointments(int doc_ID) async {
    print("calling------------getPastAppointments $doc_ID");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    await repository.getOnGoingOrUpcomingAppointments(doc_ID,'past').then((value) {
      print("Vslu $value");
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      print(value.data);
      _pastAppointmentStream.sink.add(value);
      print(value.data);
      // for (var i in value.data) {
      //   print("------------PastAppointments VISIT TYPE   ${i.otherBookingDeatils.visitType}");
      //
      //   if (i.otherBookingDeatils.visitType == '1') {
      //     pastDocVisitStreamList.add(i);
      //   }else{
      //     pastHomeVisitStreamList.add(i);
      //   }
      // }
      // print('pastDocVisitStreamList-------$pastDocVisitStreamList');
    }).catchError((error) {
      isLoading = false;
      _loadingStream.sink.add(isLoading);
      _errorStream.add(error);
    });
  }
}
