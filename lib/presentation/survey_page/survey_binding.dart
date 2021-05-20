import 'package:assignment_task/presentation/survey_page/survey_controller.dart';
import 'package:get/get.dart';

class SurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SurveyController(), fenix: true);
  }
}
