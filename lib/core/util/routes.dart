import 'package:assignment_task/core/util/routes_path.dart';
import 'package:assignment_task/presentation/survey_page/survey_binding.dart';
import 'package:assignment_task/presentation/survey_page/survey_view.dart';
import 'package:assignment_task/presentation/welcome_page/welcome_binding.dart';
import 'package:assignment_task/presentation/welcome_page/welcome_view.dart';
import 'package:get/get.dart';

class RouterGet {
  static final route = [
    GetPage(
      name: RoutesPath.Initial,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: RoutesPath.Survey,
      page: () => SurveyView(),
      binding: SurveyBinding(),
    ),
  ];
}
