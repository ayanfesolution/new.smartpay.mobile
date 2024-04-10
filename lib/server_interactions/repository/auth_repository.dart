import 'package:dartz/dartz.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay_mobile/model/profile_detail_model.dart';
import 'package:smartpay_mobile/model/register_response_model.dart';
import 'package:smartpay_mobile/model/verify_token_model.dart';
import 'package:smartpay_mobile/utils/constants.dart';

import '../../model/get_email_token_model.dart';
import '../../utils/secure_storage.dart';
import '../datasource/auth_source.dart';

class AuthRepository {
  AuthRepository(this.auth, this.storage);
  final AuthDataSource auth;
  final SecureStorage storage;

  // Future<String> getEmailToken({
  //   required String email,
  // }) async {
  //   final res = await auth.getEmailToken(email: email);

  //   if (res.status == true) {
  //     print(res);
  //     print(GetEmailTokenModel.fromJson(res.data).token ?? '');
  //     return GetEmailTokenModel.fromJson(res.data).token ?? '';
  //   } else {
  //     return res.message ?? '';
  //   }
  // }

  Future<Either<String, GetEmailTokenModel>> getEmailToken({
    required String email,
  }) async {
    final res = await auth.getEmailToken(email: email);

    if (res.status == true) {
      print(GetEmailTokenModel.fromJson(res.data).token);
      return Right(GetEmailTokenModel.fromJson(res.data));
    } else {
      kToastMsgPopUp(res.message ?? '');
      return Left(res.message ?? '');
    }
  }

  Future<Either<String, VerifyTokenModel>> verifyEmailToken({
    required String email,
    required String token,
  }) async {
    final res = await auth.verifyEmailToken(email: email, token: token);

    if (res.status == true) {
      return Right(VerifyTokenModel.fromJson(res.data));
    } else {
      kToastMsgPopUp(res.message ?? '');
      return Left(res.message ?? '');
    }
  }

  Future<Either<String, bool>> register({
    required String image,
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required String address,
  }) async {
    final res = await auth.register(
      username: username,
      email: email,
      password: password,
      address: address,
      image: image,
      phoneNumber: phoneNumber,
    );

    if (res == true) {
      return const Right(true);
    } else {
      return const Left('Registration Failed');
    }
  }

  Future<Either<String, String>> login({
    required String email,
    required String password,
  }) async {
    final res = await auth.login(email: email, password: password);

    if (res.token != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserToken, res.token ?? '');
      await FlutterSessionJwt.saveToken(res.token ?? '');
      storage.writeSecureData(kUserToken, res.token ?? '');
      return Right(res.token ?? '');
    } else {
      return const Left('Invalid credentials');
    }
  }

  Future<bool> signOut() async {
    final res = await auth.logout();

    if (res.status == true) {
      return true;
    } else {
      kToastMsgPopUp(res.message ?? '');
      return false;
    }
  }

  Future<ProfileDetailsModel?> dashboard() async {
    final res = await auth.dashboard();

    if (res != null) {
      return res;
    } else {
      return null;
    }
  }
}
