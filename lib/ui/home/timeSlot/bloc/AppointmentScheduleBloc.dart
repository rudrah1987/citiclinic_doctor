import 'package:city_clinic_doctor/modal/home/AddAppointmentScheduleResponse.dart';
import 'package:city_clinic_doctor/repository/base.dart';
import 'package:rxdart/rxdart.dart';

class AddAppointmentBloc extends BaseBloc {
  final _addAppointmentStream =
      PublishSubject<AddAppointmentScheduleResponse>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<AddAppointmentScheduleResponse> get addAppointmentStream =>
      _addAppointmentStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _addAppointmentStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void addAppointmentSchedule(
      String accessToken,
      int userID,
      String working_days,
      String slotType,
      String time_start,
      String time_end) async {
    print("addAppointmentSchedule -------calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    AddAppointmentScheduleResponse addAppointmentScheduleResponse =
        await repository.addApointmentScheduleTesting(
            accessToken, userID, working_days, slotType, time_start, time_end);
    isLoading = false;
    _loadingStream.sink.add(isLoading);
    print('333333333 ${addAppointmentScheduleResponse.message}');
    _addAppointmentStream.sink.add(addAppointmentScheduleResponse);
  }

//   void addAppointmentSchedule(String accessToken, int userID,
//       String working_days, String morning_time_start,
//       String morning_time_end, String afternoon_time_start,
//       String afternoon_time_end, String evening_time_start,
//       String evening_time_end) async {
//     print("---addAppointmentSchedule calling---");
//     if (isLoading) return;
//     isLoading = true;
//     _loadingStream.sink.add(true);
//     AddAppointmentScheduleResponse addAppointmentScheduleResponse
//     = await repository.addApointmentSchedule(accessToken, userID, working_days,
//         morning_time_start, morning_time_end,
//         afternoon_time_start, afternoon_time_end,
//         evening_time_start, evening_time_end);
//     isLoading = false;
//     _loadingStream.sink.add(isLoading);
//     _addAppointmentStream.sink.add(addAppointmentScheduleResponse);
//   }
}
