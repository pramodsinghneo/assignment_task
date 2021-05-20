import 'package:assignment_task/core/util/api_model.dart';
import 'package:assignment_task/core/util/strings.dart';
import 'package:assignment_task/core/widget/common_widget.dart';
import 'package:assignment_task/data/remote_datasource.dart';
import 'package:assignment_task/di/service_locator.dart';
import 'package:assignment_task/entities/survey_model.dart';
import 'package:assignment_task/presentation/thanks_page/thanks_view.dart';
import 'package:assignment_task/presentation/welcome_page/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  var remoteDatasource = locator<RemoteDataSource>();
  var choice = Choice();
  var welcomeController = Get.find<WelcomeController>();
  List<Item> list = [];
  var itemValue = Item("", 1111).obs;
  List<Choice>? choiceList = [];
  List<Field>? listFields = [];
  var datePicked = "".obs;
  List<YesNo> listYesNoItem = [];

  List<PostItems> postItemsList = [];
  var index = 1.obs;
  var itemIndex = "".obs;
  var ageValue = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var gender = "".obs;
  var emaildPrimary = "".obs;
  var emailSecondary = "".obs;
  var phoneNumber = "".obs;
  var ratingValue = "".obs;
  var dateOfVisit = "".obs;
  var selection1 = "".obs;
  var selection2 = "".obs;

  var validateRating = false.obs;
  var validateDatePicker = false.obs;
  var validateSelection = false.obs;

  @override
  void onInit() {
    listYesNoItem.addAll(listYesNo);
    getWelcomeData();
    itemValue.value = list[0];
    index.value = 1;

    super.onInit();
  }

  getWelcomeData() {
    listFields = welcomeController.fields;
    list.add(Item(welcomeController.fields![2].title!, -1));
    choiceList = welcomeController.choiceList;

    for (int i = 0; i < choiceList!.length; i++) {
      list.add(Item(choiceList![i].label!, i));
    }

    for (int i = 0; i < listFields!.length; i++) {
      if (listFields![i].type == yesNo) {
        itemIndex.value = listFields![i].id!;
        postItemsList.add(PostItems(itemIndex.value, "Yes"));
        break;
      }
    }

    print(list.length);
  }

  void postUpdateValue(String body) async {
    var response = await remoteDatasource.postUpdateValue(body);
    if (response.status == Status.SUCCESS) {
      print(response.data);
      if (response.data.message == submitted) {
        Get.to(ThanksView());
      }
    } else {
      print(response.message);
      dialog(response.message!);
    }
  }
}

class Item {
  final String title;
  final int id;

  Item(this.title, this.id);
}

var listYesNo = [
  YesNo("Yes", 1),
  YesNo("No", 2),
];

class YesNo {
  final String title;
  final int id;

  YesNo(this.title, this.id);
}

class PostItems {
  final String id;
  final String title;

  PostItems(this.id, this.title);

  Map<String, dynamic> toJson() {
    return {
      "field_id": this.id,
      "field_data": this.title,
    };
  }
}
