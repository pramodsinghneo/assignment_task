import 'dart:convert';
import 'dart:io';

import 'package:assignment_task/core/exception/exception.dart';
import 'package:assignment_task/core/network_helper/network_helper.dart';
import 'package:assignment_task/core/util/api_model.dart';
import 'package:assignment_task/core/util/api_path.dart';
import 'package:assignment_task/data/datasource.dart';
import 'package:assignment_task/di/service_locator.dart';
import 'package:assignment_task/entities/error_model.dart';
import 'package:assignment_task/entities/success_model.dart';
import 'package:assignment_task/entities/survey_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as io;

class RemoteDataSource extends DataSource {
  var helper = locator<NetworkHelper>();
  // var client = io.IOClient();
  var client = http.Client();

  @override
  Future<AppResult<dynamic>> getSurveyFieldData() async {
    try {
      var response = await helper.get(ApiPath.getFieldData);

      if (response.statusCode == 200) {
        var model = SurveyFieldModel.fromJson(response.data);
        return AppResult.success(model);
      } else {
        return AppResult.failure(response.statusMessage!, response.statusCode!);
      }
    } on InternetException catch (e) {
      return AppResult.failure(e.msg);
    } on ServerException catch (e) {
      return AppResult.failure(e.msg);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  @override
  Future<AppResult<dynamic>> postUpdateValue(String body) async {
    try {
      var response =
          await helper.post(ApiPath.postFieldData, body, requireToken: false);
      if (response.statusCode == 200) {
        var model = SuccessModel.fromJson(response.data);
        return AppResult.success(model);
      } else {
        return AppResult.failure(response.statusMessage!, response.statusCode!);
      }
    } on InternetException catch (e) {
      return AppResult.failure(e.msg);
    } on ServerException catch (e) {
      return AppResult.failure(e.msg);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }
}
