import 'package:city_clinic_doctor/modal/auth/SignUpResponse.dart';
import 'package:city_clinic_doctor/network/ApiResult.dart';
import 'package:city_clinic_doctor/network/DioClient.dart';
import 'package:city_clinic_doctor/network/NetworkExceptions.dart';
import 'package:dio/dio.dart';

class APIRepository {
  DioClient dioClient;
  String _baseUrl = "http://projects.adsandurl.com/cityclinics/api/";

  APIRepository() {
    var dio = Dio();

    dioClient = DioClient(_baseUrl, dio);
  }

  Future<ApiResult<SignUpResponse>> signUp(String name, String phone,
      String email, String password, String  fb_token, String longitude, String latitude) async {
    final _map = Map();
    _map['name'] = name;
    _map['email'] = email;
    _map['phone_number'] = phone;
    _map['password'] = password;
    _map['firebase_token'] = fb_token;
    _map['longitude'] = longitude;
    _map['latitude'] = latitude;

    print("Signup data -> $_map");

    try {
      Response response = await dioClient.post('doctorsignup', data: _map);
      print(response.data);
      return ApiResult.success(data: response.data);
    } catch (error) {
      print("Exception occured: $error");
      return ApiResult.failure(error: NetworkExceptions.getDioException(error));
    }
  }
}