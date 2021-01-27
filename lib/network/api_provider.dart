import 'dart:convert';
import 'dart:io';
import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ChangePassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassVerifyOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/LogoutResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ResendOtpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/ResetPassResponse.dart';
import 'package:city_clinic_doctor/modal/auth/SignUpResponse.dart';
import 'package:city_clinic_doctor/modal/auth/VerifyOtpResponse.dart';
import 'package:city_clinic_doctor/modal/home/AddAppointmentScheduleResponse.dart';
import 'package:city_clinic_doctor/modal/notifications/notifications_response.dart';
import 'package:city_clinic_doctor/modal/prescriptions/prescriptions.dart';
import 'package:city_clinic_doctor/modal/profile/BankDetailResponse.dart';
import 'package:city_clinic_doctor/modal/profile/ProfileImageResponse.dart';
import 'package:city_clinic_doctor/modal/profile/ProfileUpdateResponse.dart';
import 'package:city_clinic_doctor/modal/profile/QualificationResponse.dart';
import 'package:city_clinic_doctor/modal/profile/RegistrationResponse.dart';
import 'package:city_clinic_doctor/modal/profile/SpecialityResponse.dart';
import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';
import 'package:city_clinic_doctor/modal/staticResponse/staticResponse.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:city_clinic_doctor/ui/auth/bloc/LoginBloc.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dioClient = Dio(BaseOptions(
    baseUrl: TESTING_BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 5000,
    headers: {
      'Appversion': '1.0',
      'Ostype': Platform.isAndroid ? 'android' : 'ios'
    },
  ));

  //Authentication api call here...

  Future<SignUpResponse> signUp(
      String name,
      String phone,
      String email,
      String password,
      String fb_token,
      String longitude,
      String latitude) async {
    final _map = Map();
    _map['name'] = name;
    _map['email'] = email;
    _map['phone_number'] = phone;
    _map['password'] = password;
    _map['firebase_token'] = fb_token;
    _map['longitude'] = longitude;
    _map['latitude'] = latitude;
    _map["role_id"] = "3";

    print("Signup data -> $_map");
    try {
      Response response = await _dioClient.post('signup', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return SignUpResponse.fromJson(json);
        else
          return SignUpResponse.fromError(json['message'], response.statusCode);
      } else {
        return SignUpResponse.fromError("No data", 396);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return SignUpResponse.fromError("$e", 397);
    }
  }

  Future<UserDetailResponse> login(String phone, String password,
      String longitude, String latitude, int roleType) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Roletype': roleType
      },
    ));

    final _map = Map();
    _map['user_cred'] = phone;
    _map['password'] = password;
    _map['longitude'] = longitude;
    _map['latitude'] = latitude;
    print(
        "phone -> $phone :: password -> $password :: longitude -> $longitude :: latitude -> $latitude");

    try {
      Response response = await _dioClient.post('login', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return UserDetailResponse.fromJson(json);
        else
          return UserDetailResponse.fromError(
              json['message'],json['success'] /*,
            response.data['error_code'],*/
              );
      } else {
        return UserDetailResponse.fromError("No data" ,false/*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return UserDetailResponse.fromError("$e" ,false/*, 397*/);
    }
  }

  Future<ForgotPassResponse> forgotPass(String phone) async {
    final _map = Map();
    _map['user_cred'] = phone;
    _map['type'] = "phone";
    print("phone -> $phone");

    try {
      Response response = await _dioClient.post('userforgot', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ForgotPassResponse.fromJson(json);
        else
          return ForgotPassResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return ForgotPassResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ForgotPassResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<ResendOtpResponse> forgotPassResendOtp(
      String phone, int userID) async {
    final _map = Map();
    _map['user_cred'] = phone;
    _map['type'] = "phone";
    print("forgotData -> $_map");

    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Userid': userID
      },
    ));

    try {
      Response response =
          await _dioClient.post('userforgotresendotp', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ResendOtpResponse.fromJson(json);
        else
          return ResendOtpResponse.fromError(json['message']);
      } else {
        return ResendOtpResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ResendOtpResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<ForgotPassVerifyOtpResponse> verifyForgotPassOtp(
      String phone, String otp, String userLogID, int userID) async {
    final _map = {
      'otp': otp,
      'user_cred': phone,
      'result_forgot_log_id': userLogID
    };

    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Userid': userID
      },
    ));

    try {
      Response response =
          await _dioClient.post('userforgotverifyotp', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ForgotPassVerifyOtpResponse.fromJson(json);
        else
          return ForgotPassVerifyOtpResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return ForgotPassVerifyOtpResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ForgotPassVerifyOtpResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<ResetPassResponse> resetPassword(String password, int userID) async {
    final _map = {'password': password};

    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Userid': userID
      },
    ));

    print("password -> $password :: userID -> $userID");
    try {
      Response response = await _dioClient.post('resetpassword', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ResetPassResponse.fromJson(json);
        else
          return ResetPassResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return ResetPassResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ResetPassResponse.fromError("$e" /*, 397*/);
    }
  }
  // Future<StaticPageResponse> getStaticDtata() async {
  //     Dio _dioClient = Dio(BaseOptions(
  //     baseUrl: TESTING_BASE_URL,
  //     connectTimeout: 5000,
  //     receiveTimeout: 5000,
  //     headers: {
  //       'Appversion': '1.0',
  //       'Ostype': Platform.isAndroid ? 'android' : 'ios',
  //     },
  //   ));
  //     Response response = await _dioClient.post('staticpageslist');
  //     dynamic json = jsonDecode(response.toString());
  //   if (response.data != "") {
  //       print("dataValue :- ${json['success']}");
  //       if (json['success'] == true)
  //         return StaticPageResponse.fromJson(json);
  //       else
  //         return StaticPageResponse.fromError(
  //             json['message'] /*,
  //           response.data['error_code'],*/
  //             );
  //     } else {
  //       return StaticPageResponse.fromError("No data" /*, 396*/);
  //     }
  //   }

  Future<VerifyOtpResponse> verifySignUpOtp(
      String phone, String otp, String userLogID, int userID) async {
    final _map = {
      'otp': otp,
      'phone_number': phone,
      'user_otp_log_id': userLogID
    };
    print("map -> $_map :: userid -> $userID");
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Userid': userID
      },
    ));

    try {
      Response response = await _dioClient.post('verifyotp', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      print('----------OtpVerify---------------');
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return VerifyOtpResponse.fromJson(json);
        else
          return VerifyOtpResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return VerifyOtpResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return VerifyOtpResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<ResendOtpResponse> resendSignUpOtp(String phone, int userID) async {
    final _map = {'phone_number': phone};

    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Userid': userID
      },
    ));

    try {
      Response response = await _dioClient.post('resendotp', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ResendOtpResponse.fromJson(json);
        else
          return ResendOtpResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return ResendOtpResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ResendOtpResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<ResendOtpResponse> resendOtp(String phone, int userID) async {
    final _map = {'phone_number': phone, 'user_id': userID};

    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Userid': userID
      },
    ));

    try {
      Response response = await _dioClient.post('resendotp', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ResendOtpResponse.fromJson(json);
        else
          return ResendOtpResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return ResendOtpResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ResendOtpResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<UserDetailResponse> getUserDetails(
      String accessToken, int userID) async {
    final Dio _dioClientHeader =
        Dio(BaseOptions(baseUrl: TESTING_BASE_URL, headers: {
      'Appversion': '1.0',
      'Ostype': Platform.isAndroid ? 'ANDRIOD' : 'ios',
      'Userid': userID,
      'Accesstoken': accessToken
    }));

    print("User details :: $userID :: $accessToken");
    try {
      Response response = await _dioClientHeader.get('userinfo');
      dynamic json = jsonDecode(response.toString());
      UserDetailResponse data;
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true) {
          data = UserDetailResponse.fromJson(json);
          if (data != null) {
            PreferenceHelper.saveUser(data.user);
            currentUser.value.user = data.user;
          }

          return data;
        } else
          return UserDetailResponse.fromError(json['message'],json['success']);
      } else {
        return UserDetailResponse.fromError("No data",json['success'] /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return UserDetailResponse.fromError("$e",false /*, 397*/);
    }
  }

  Future<SpecialityResponse> getSpeciality() async {
    try {
      print('-------------getSpeciality Called');
      Response response = await _dioClient.get('getspecialities');
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return SpecialityResponse.fromJson(json);
        else
          return SpecialityResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return SpecialityResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return SpecialityResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<StaticPageResponse> getStaticPages() async {
    try {
      print('-------------getStaticPages Called');
      Response response = await _dioClient.get('staticpageslist');
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return StaticPageResponse.fromJson(json);
        else
          return StaticPageResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return StaticPageResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return StaticPageResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<ChangePassResponse> changePassword(
      String oldPass, String newPass, String accessToken, int userID) async {
    final _map = Map();
    _map['old_password'] = oldPass;
    _map['new_password'] = newPass;
    print(
        "changePassword -> $_map :: userID -> $userID :: accessToken -> $accessToken");

    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    try {
      Response response = await _dioClient.post('changepassword', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ChangePassResponse.fromJson(json);
        else
          return ChangePassResponse.fromError(json['message']);
      } else {
        return ChangePassResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ChangePassResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<LogoutResponse> logoutUser(String accessToken, int userID) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    try {
      Response response = await _dioClient.get('logout');
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return LogoutResponse.fromJson(json);
        else
          return LogoutResponse.fromError(json['message']);
      } else {
        return LogoutResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return LogoutResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<String> uploadPrescriptions(
      String msg, String medicine, File imageFile) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': currentUser.value.user.accessToken,
        'Userid': currentUser.value.user.userId
      },
    ));

    print(
        "profileImage -> userID -> ${currentUser.value.user.accessToken} :: accessToken -> ${currentUser.value.user.userId}");

    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "medicines": medicine,
      "message": msg,
      "image": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });
    String k = '';
    try {
      Response response =
          await _dioClient.post('uploadprescription', data: formData);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      k = json['message'];
      return k;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return 'Something went wrong';
    }
  }

  Future<ProfileImageResponse> profileORCoverImage(
      String accessToken, int userID, String keyword, File imageFile) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    print(
        "profileImage -> userID -> $userID :: accessToken -> $accessToken :: $keyword");

    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "keyword": keyword,
      "image": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    try {
      Response response =
          await _dioClient.post('doctorprofileimage', data: formData);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ProfileImageResponse.fromJson(json);
        else
          return ProfileImageResponse.fromError(json['message']);
      } else {
        return ProfileImageResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ProfileImageResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<QualificationResponse> doctorQualification(
      String accessToken,
      int userID,
      String degree,
      String university,
      String passingYear,
      File regProofFile) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    print(
        "doctorQualification -> userID -> $userID :: accessToken -> $accessToken");
    String fileName = regProofFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "degree": degree,
      "university": university,
      "passing_year": passingYear,
      "image": await MultipartFile.fromFile(
        regProofFile.path,
        filename: fileName,
      ),
    });

    try {
      Response response =
          await _dioClient.post('doctorqualification', data: formData);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return QualificationResponse.fromJson(json);
        else
          return QualificationResponse.fromError(json['message']);
      } else {
        return QualificationResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return QualificationResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<RegistrationResponse> doctorRegistration(
      String accessToken,
      int userID,
      String regNumber,
      String regCouncil,
      String regDate,
      File regProofFile) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    String fileName = regProofFile.path.split('/').last;
    print(
        "doctorRegistration -> :: userID -> $userID :: accessToken -> $accessToken"
        ":: registration_number -> $regNumber :: registration_council -> "
        "$regCouncil :: registration_date -> $regDate :: image -> $fileName");

    FormData formData = FormData.fromMap({
      "registration_number": regNumber,
      "registration_council": regCouncil,
      "registration_date": regDate,
      "image": await MultipartFile.fromFile(
        regProofFile.path,
        filename: fileName,
      ),
    });

    try {
      Response response =
          await _dioClient.post('doctorregistrationdeatils', data: formData);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return RegistrationResponse.fromJson(json);
        else
          return RegistrationResponse.fromError(json['message']);
      } else {
        return RegistrationResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return RegistrationResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<ProfileUpdateResponse> profileUpdate(
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
      String ifsc_code) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    final _map = Map();
    _map['name'] = name;
    _map['gender'] = gender;
    _map['dob'] = dob;
    _map['exprience'] = exprience;
    _map['speciality_id'] = exprience;
    _map['hospital_address'] = hospital_address;
    _map['land_mark'] = land_mark;
    _map['availability_for_home_visit'] = availability_for_home_visit;
    _map['consultation_type'] = consultation_type;
    _map['state_id'] = state_id;
    _map['country_id'] = country_id;
    _map['city_id'] = city_id;
    _map['bank_name'] = bank_name;
    _map['account_holder_name'] = account_holder_name;
    _map['account_number'] = account_number;
    _map['ifsc_code'] = ifsc_code;

    print(
        "profileUpdate -> $_map :: userID -> $userID :: accessToken -> $accessToken");

    try {
      Response response = await _dioClient.post('doctorprofile', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return ProfileUpdateResponse.fromJson(json);
        else
          return ProfileUpdateResponse.fromError(json['message']);
      } else {
        return ProfileUpdateResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return ProfileUpdateResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<BankResponse> getBankData() async {
    try {
      Response response = await _dioClient.get('getbanks');
      dynamic json = jsonDecode(response.toString());
      print('-------getBankData---------');
      print(response.data);
      if (response.data[0] != "") {
        print("Bank=====dataValue :- $json");
        return BankResponse.fromJson(json);
        // else
        //   return BankResponse.fromError(
        //       json['message'] /*,
        //     response.data['error_code'],*/
        //       );
      } else {
        return BankResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return BankResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<AddAppointmentScheduleResponse> addAppointmentSchedule(
      String accessToken,
      int userID,
      String working_days,
      String morning_time_start,
      String morning_time_end,
      String afternoon_time_start,
      String afternoon_time_end,
      String evening_time_start,
      String evening_time_end) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    final _map = Map();
    _map['working_days'] = working_days;
    // _map['slot_type'] = slot_type;
    _map['morning_time_start'] = morning_time_start;
    _map['morning_time_end'] = morning_time_end;
    _map['afternoon_time_start'] = afternoon_time_start;
    _map['afternoon_time_end'] = afternoon_time_end;
    _map['evening_time_start'] = evening_time_start;
    _map['evening_time_end'] = evening_time_end;
    print("AddAppointment -> $_map");

    try {
      Response response =
          await _dioClient.post('addappointmentschedule', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return AddAppointmentScheduleResponse.fromJson(json);
        else
          return AddAppointmentScheduleResponse.fromError(json['message']);
      } else {
        return AddAppointmentScheduleResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("-------------Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return AddAppointmentScheduleResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<String> contactUsSubmit(
    String accessToken,
    String name,
    String email,
    String phone,
    String msg,
    int userID,
  ) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));
    final _map = Map();
    _map['name'] = name;
    _map['email'] = email;
    _map['phone'] = phone;
    _map['message'] = msg;
    print("Contact us  -> $_map :: ${userID} :: ${accessToken}");
    String k = '';

    try {
      Response response = await _dioClient.post('contactus', data: _map);
      dynamic json = jsonDecode(response.toString());
      print("dataValue :- ${json}");
      k = json['message'];
      return k;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return 'Something went wrong';
    }
  }

  Future<AddAppointmentScheduleResponse> addAppointmentScheduleTesting(
      String accessToken,
      int userID,
      String working_days,
      String slotType,
      String time_start,
      String time_end) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': accessToken,
        'Userid': userID
      },
    ));

    final _map = Map();
    _map['working_days'] = working_days;
    _map['slot_type'] = slotType;
    _map['start_time'] = time_start;
    _map['end_time'] = time_end;
    print("AddAppointment -> $_map :: ${userID} :: ${accessToken}");

    try {
      Response response =
          await _dioClient.post('addappointmentschedule', data: _map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return AddAppointmentScheduleResponse.fromJson(json);
        else
          return AddAppointmentScheduleResponse.fromError(json['message']);
      } else {
        return AddAppointmentScheduleResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return AddAppointmentScheduleResponse.fromError("$e" /*, 397*/);
    }
  }

  String getErrorMsg(DioErrorType type) {
    switch (type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return "Connection timeout";
        break;
      case DioErrorType.SEND_TIMEOUT:
        return "Send timeout";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return "Receive timeout";
        break;
      case DioErrorType.RESPONSE:
        return "Response timeout";
        break;
      case DioErrorType.CANCEL:
        return "Request has been cancelled";
        break;
      case DioErrorType.DEFAULT:
        return "Could not connect";
        break;
      default:
        return "Something went wrong";
        break;
    }
  }

  Future<AppointmentListResponse> getAppointments(int docId) async {
    try {
      print('-------------getAppointments Called--$docId');
      Response response =
          await _dioClient.get('bookinglist?for=doctor&id=$docId');
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return AppointmentListResponse.fromJson(json);
        else
          return AppointmentListResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return AppointmentListResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return AppointmentListResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<AppointmentListResponse> getOnGoingOrUpcomingAppointments(
      int docId, String timeFrame) async {
    try {
      print('-------------getAppointments Called--$docId');
      Response response = await _dioClient
          .get('bookinglist?for=doctor&id=$docId&time_frame=$timeFrame');
      dynamic json = jsonDecode(response.toString());
      print("-------------------------------------");
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true) {
          print('SUCCCscscscs');
          return AppointmentListResponse.fromJson(json);
        } else
          return AppointmentListResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return AppointmentListResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return AppointmentListResponse.fromError("$e" /*, 397*/);
    }
  }

//   Future<BankDetailResponse> getBanks(){

//   }
// }

  Future<NotificationsResponse> getNotifications() async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': currentUser.value.user.accessToken,
        'Userid': currentUser.value.user.userId
      },
    ));
    try {
      // print('-------------getAppointments Called--$docId');
      Response response = await _dioClient.get('getnotifications');
      dynamic json = jsonDecode(response.toString());
      print('--------------------');
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true)
          return NotificationsResponse.fromJson(json);
        else
          return NotificationsResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
              );
      } else {
        return NotificationsResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return NotificationsResponse.fromError("$e" /*, 397*/);
    }
  }

  Future<bool> deleteNotifications(notificationId) async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': currentUser.value.user.accessToken,
        'Userid': currentUser.value.user.userId
      },
    ));
    // var _map={
    //   'id':notificationId
    // };
    try {
      // print('-------------getAppointments Called--$docId');
      Response response =
          await _dioClient.get('removenotifications?id=$notificationId');
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (json['success']) {
        return true;
      } else
        return false;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return false;
    }
  }

  Future<bool> deleteAllNotifications() async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': currentUser.value.user.accessToken,
        'Userid': currentUser.value.user.userId
      },
    ));
    try {
      // print('-------------getAppointments Called--$docId');
      Response response = await _dioClient.get('removeallnotifications');
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (json['success']) {
        return true;
      } else
        return false;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return false;
    }
  }

  Future<PrescriptionsResponse> getAllPrescriptions() async {
    Dio _dioClient = Dio(BaseOptions(
      baseUrl: TESTING_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios',
        'Accesstoken': currentUser.value.user.accessToken,
        'Userid': currentUser.value.user.userId
      },
    ));
    try {
      Response response = await _dioClient
          .get('getprescription');
      dynamic json = jsonDecode(response.toString());
      print("-----------------PrescriptionsResponse--------------------");
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['success']}");
        if (json['success'] == true) {
          print('SUCCCscscscs');
          return PrescriptionsResponse.fromJson(json);
        } else
          return PrescriptionsResponse.fromError(
              json['message'] /*,
            response.data['error_code'],*/
          );
      } else {
        return PrescriptionsResponse.fromError("No data" /*, 396*/);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      print("Error -> $e");
      return PrescriptionsResponse.fromError("$e" /*, 397*/);
    }
  }
}
