import 'package:assignment_task/core/util/api_model.dart';
import 'package:assignment_task/core/widget/common_widget.dart';
import 'package:assignment_task/data/remote_datasource.dart';
import 'package:assignment_task/di/service_locator.dart';
import 'package:assignment_task/entities/survey_model.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var remoteDatasource = locator<RemoteDataSource>();
  var surveyFieldModel = SurveyFieldModel().obs;
  List<Choice>? choiceList = [];
  List<Field>? fields = [];
  var loader = false.obs;
  var failedMessage = "".obs;
  var failedLoader = false.obs;

  @override
  void onInit() {
    getFieldData();
    super.onInit();
  }

  getFieldData() async {
    loader.value = true;
    var response = await remoteDatasource.getSurveyFieldData();
    if (response.status == Status.SUCCESS) {
      loader.value = false;
      failedLoader.value = false;
      surveyFieldModel.value = response.data;
      print("surveyModel-->${surveyFieldModel.value}");
      _getChoiceList(surveyFieldModel.value);
    } else {
      loader.value = false;
      failedLoader.value = true;
      failedMessage.value = response.message!;
      print(response.message);
      dialog(response.message!);
    }
  }

  void _getChoiceList(SurveyFieldModel value) {
    choiceList = value.fields![2].properties?.choices;
    fields = value.fields!;
  }
}
