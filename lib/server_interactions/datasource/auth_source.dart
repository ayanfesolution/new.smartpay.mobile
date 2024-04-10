import 'package:smartpay_mobile/model/login_response_model.dart';
import 'package:smartpay_mobile/model/profile_detail_model.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/helper.dart';

import '../../api/abstract_api.dart';
import '../../api/api_client.dart';
import '../../utils/endpoints.dart';
import '../../utils/error_handler.dart';

class AuthDataSource {
  AuthDataSource(this.client);
  final ApiClient client;

  Future<AbstractApiResponse> getEmailToken({
    required String email,
  }) async {
    try {
      final data = {'email': email};

      //client.header = {'Accept': 'application/json'};
      final result = await client.post('http://146.190.74.11/api/v1/auth/email',
          params: data);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }

  Future<AbstractApiResponse> verifyEmailToken({
    required String email,
    required String token,
  }) async {
    try {
      final data = {'email': email, 'token': token};

      client.header = {'Accept': 'application/json'};
      final result = await client
          .post('http://146.190.74.11/api/v1/auth/email/verify', params: data);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      NetworkExceptions.getDioException(e);
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }

  Future<bool> register({
    required String image,
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required String address,
  }) async {
    //final String deviceName = await Helper.deviveName;
    try {
      final data = {
        "username": username,
        "password": password,
        "email": email,
        "phone": phoneNumber,
        "address": address,
        "image": image
      };

      client.header = {'Accept': 'application/json'};
      final result = await client.post(
        '/register',
        data: data,
      );
      const output = true;
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return false;
    }
  }

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    // final String deviceName = await Helper.deviveName;
    try {
      final data = {'username': email, 'password': password};

      client.header = {'Accept': 'application/json'};
      final result = await client.post(
        '/login',
        data: data,
      );
      final output = handleResponseSignIn(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return LoginModel();
    }
  }

  Future<ProfileDetailsModel?> dashboard() async {
    try {
      final token = await Helper.token;
      client.header = {'Authorization': 'Bearer $token'};
      final result = await client.get(Endpoints.dashboard);
      final output = handleResponseProfile(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return null;
    }
  }

  Future<AbstractApiResponse> logout() async {
    try {
      client.header = {'Accept': 'application/json'};
      final result = await client.post(Endpoints.register);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }
}
