import 'package:city_clinic_doctor/ui/drawer/feeManagement/FeesManagement.dart';
import 'package:city_clinic_doctor/ui/drawer/paymentManagement/PaymentManagementPage.dart';
import 'package:city_clinic_doctor/ui/drawer/prescriptionManagement/PrescriptionPage.dart';
import 'package:city_clinic_doctor/ui/drawer/statistics/StatisticsPage.dart';
import 'package:city_clinic_doctor/ui/home/timeSlot/time_slot_manag/time_slot_managment.dart';
import 'package:city_clinic_doctor/ui/settings/Settings.dart';

import '../ui/home/Chat/ChatPage.dart';

class Routes {
  static const String statistics = StatisticsPage.routeName;
  static const String feeManagement = FeesManagement.routeName;
  static const String prescriptionManagement = PrescriptionPage.routeName;
  static const String paymentManagement = PaymentManagementPage.routeName;
  static const String myChat = ChatPage.routeName;
  static const String settings = Settings.routeName;
  static const String timeSlotManagment = TimeSlotManagement.routeName;

}