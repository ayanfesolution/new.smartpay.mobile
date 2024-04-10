import 'dart:io';

import 'package:dio/dio.dart';

import 'config.dart';

class ApiClient {
  ApiClient(this.dio) {
    dio.options.baseUrl = Config.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.headers.addAll(
      {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }
  final Dio dio;

  set header(Map<String, dynamic> header) {
    dio.options.headers = header;
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(url, queryParameters: params);
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: data,
        queryParameters: params,
      );
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.patch(url, data: data);
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete(url, data: data);
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> uploadImage(
    String url, {
    required File file,
  }) async {
    final fileName = file.path.split('/').last;
    try {
      final formData = FormData.fromMap({
        'images': await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final response = await dio.post(url, data: formData);
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }
}
