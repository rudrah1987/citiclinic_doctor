import 'package:city_clinic_doctor/repository/repo.dart';

abstract class BaseBloc {
  final repository = Repository();

  void dispose() {}
}