import 'dart:io';

import 'package:assignment_task/core/exception/exception.dart';
import 'package:assignment_task/core/network_info/network_info.dart';
import 'package:assignment_task/core/util/api_path.dart';
import 'package:dio/dio.dart';

class NetworkHelper {
  final Dio? dio;
  final NetworkInfo? networkInfo;

  NetworkHelper({this.dio, this.networkInfo});

  Future<Map<String, String>> getHeader() async {
    return {
      HttpHeaders.contentTypeHeader: "application/json",
    };
  }

  Future<Response<dynamic>> get(
    String url,
  ) async {
    if (await networkInfo!.currentNetworkConnection()) {
      try {
        Response response =
            await dio!.get(url, options: Options(headers: await getHeader()));

        return response;
      } on DioError catch (e) {
        _error(e);
        throw e;
      }
    } else {
      throw InternetException(msg: "No Internet");
    }
  }

  void _error(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      print("Connection");

      throw ServerException(msg: "Connection Timeout");
    } else if (e.type == DioErrorType.receiveTimeout) {
      throw ServerException(msg: "Receive Timeout");
    } else {
      throw ServerException(msg: e.response!.data["message"]);
    }
  }

  // ignore: missing_return
  Future<Response<dynamic>> post(String url, dynamic body,
      {required bool requireToken}) async {
    if (await networkInfo!.currentNetworkConnection()) {
      try {
        final response = await dio!.post(url,
            data: body, options: Options(headers: await getHeader()));
        if (response.statusCode == 200) {
          return response;
        } else {
          throw ServerException(msg: response.statusMessage);
        }
      } on DioError catch (e) {
        _error(e);
        throw e;
      }
    } else {
      throw InternetException(msg: "No Internet");
    }
  }
}
