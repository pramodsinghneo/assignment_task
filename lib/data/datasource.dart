import 'package:assignment_task/core/util/api_model.dart';
import 'package:assignment_task/entities/survey_model.dart';

abstract class DataSource {
  Future<AppResult<dynamic>> getSurveyFieldData();
  Future<AppResult<dynamic>> postUpdateValue(String body);
}
