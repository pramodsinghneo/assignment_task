import 'package:assignment_task/presentation/welcome_page/welcome_controller.dart';
import 'package:get/instance_manager.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController(), fenix: true);
  }
}
