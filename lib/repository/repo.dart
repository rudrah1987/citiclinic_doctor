import 'dart:io';

import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ChangePassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassVerifyOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/LoginResponse.dart';
import 'package:city_clinic_doctor/modal/auth/LogoutResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ResendOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ResetPassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/SignUpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/VerifyOtpResponse.dart';
import 'package:city_clinic_doctor/modal/home/AddAppointmentScheduleResponse.dart';
import 'package:city_clinic_doctor/modal/profile/ProfileImageResponse.dart';
import 'package:city_clinic_doctor/modal/profile/ProfileUpdateResponse.dart';
import 'package:city_clinic_doctor/modal/profile/QualificationResponse.dart';
import 'package:city_clinic_doctor/modal/profile/RegistrationResponse.dart';
import 'package:city_clinic_doctor/modal/profile/SpecialityResponse.dart';
import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';
import 'package:city_clinic_doctor/network/api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<SignUpResponse> signUp(
          String name,
          String phone,
          String email,
          String password,
          String fb_token,
          String longitude,
          String latitude) =>
      apiProvider.signUp(
          name, phone, email, password, fb_token, longitude, latitude);

  Future<UserDetailResponse> login(String phone, String password,
          String longitude, String latitude, int roleType) =>
      apiProvider.login(phone, password, longitude, latitude, roleType);

  Future<VerifyOtpResponse> verifyOtp(
          String phone, String otp, String userLoginID, int userID) =>
      apiProvider.verifySignUpOtp(phone, otp, userLoginID, userID);

  Future<ResendOtpResponse> resendOtp(String phone, int userID) =>
      apiProvider.resendOtp(phone, userID);

  Future<ForgotPassResponse> forgotPassword(String phone) =>
      apiProvider.forgotPass(phone);

  Future<UserDetailResponse> userDetail(String accessToken, int userID) =>
      apiProvider.getUserDetails(accessToken, userID);

  Future<ResendOtpResponse> forgotPassResendOtp(String phone, int userID) =>
      apiProvider.forgotPassResendOtp(phone, userID);

  Future<ForgotPassVerifyOtpResponse> forgotPassVerifyOtp(
          String phone, String otp, String userLoginID, int userID) =>
      apiProvider.verifyForgotPassOtp(phone, otp, userLoginID, userID);

  Future<ResetPassResponse> resetPassword(String password, int userID) =>
      apiProvider.resetPassword(password, userID);

  Future<ChangePassResponse> changePassword(
          String oldPass, String newPass, String accessToken, int userID) =>
      apiProvider.changePassword(oldPass, newPass, accessToken, userID);

  Future<LogoutResponse> logoutUser(String accessToken, int userID) =>
      apiProvider.logoutUser(accessToken, userID);

  //Profile apis here....

  Future<SpecialityResponse> getSpecialityData() => apiProvider.getSpeciality();

  Future<ProfileImageResponse> profileORCoverImage(
          String accessToken, int userID, String keyword, File imageFile) =>
      apiProvider.profileORCoverImage(accessToken, userID, keyword, imageFile);

  Future<QualificationResponse> doctorQualification(
          String accessToken,
          int userID,
          String degree,
          String university,
          String passingYear,
          File regProofFile) =>
      apiProvider.doctorQualification(
          accessToken, userID, degree, university, passingYear, regProofFile);

  Future<RegistrationResponse> doctorRegistration(
          String accessToken,
          int userID,
          String regNumber,
          String regCouncil,
          String regDate,
          File regProofFile) =>
      apiProvider.doctorRegistration(
          accessToken, userID, regNumber, regCouncil, regDate, regProofFile);

  Future<ProfileUpdateResponse> doctorProfileUpdate(
          String accessToken,
          int userID,
          String name,
          String gender,
          String dob,
          String exprience,
          int specialityID,
          String hospital_address,
          String land_mark,
          String availability_for_home_visit,
          String consultation_type,
          String city_id,
          String state_id,
          String country_id,
          String bank_name,
          String account_holder_name,
          String account_number,
          String ifsc_code) =>
      apiProvider.profileUpdate(
          accessToken,
          userID,
          name,
          gender,
          dob,
          exprience,
          specialityID,
          hospital_address,
          land_mark,
          availability_for_home_visit,
          consultation_type,
          city_id,
          state_id,
          country_id,
          bank_name,
          account_holder_name,
          account_number,
          ifsc_code);

  Future<AddAppointmentScheduleResponse> addApointmentSchedule(
          String accessToken,
          int userID,
          String working_days,
          String morning_time_start,
          String morning_time_end,
          String afternoon_time_start,
          String afternoon_time_end,
          String evening_time_start,
          String evening_time_end) =>
      apiProvider.addAppointmentSchedule(
          accessToken,
          userID,
          working_days,
          morning_time_start,
          morning_time_end,
          afternoon_time_start,
          afternoon_time_end,
          evening_time_start,
          evening_time_end);

  Future<AddAppointmentScheduleResponse> addApointmentScheduleTesting(
          String accessToken,
          int userID,
          String working_days,
          String slotType,
          String time_start,
          String time_end) =>
      apiProvider.addAppointmentScheduleTesting(
          accessToken, userID, working_days, slotType, time_start, time_end);

  Future<AppointmentListResponse> getApointments(int docId) =>
      apiProvider.getAppointments(docId);
}
