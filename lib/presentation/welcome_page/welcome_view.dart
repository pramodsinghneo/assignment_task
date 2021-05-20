import 'package:assignment_task/core/widget/constants.dart';
import 'package:assignment_task/core/widget/textstyle.dart';
import 'package:assignment_task/presentation/survey_page/survey_view.dart';
import 'package:assignment_task/presentation/thanks_page/thanks_view.dart';
import 'package:assignment_task/presentation/welcome_page/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WelcomeView extends GetWidget<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.loader.value == true
              ? Center(child: CircularProgressIndicator())
              : controller.failedLoader.value == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.failedMessage.value,
                            style: ConstantTextStyle.textStyleNoInternet,
                          ),
                          _iconRefresh(),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            _buildWelcomeTitle(context),
                            Constant.sizedBox(20),
                            _buildSubtitle(context),
                          ],
                        ),
                        _startBtn(context),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _iconRefresh() {
    return IconButton(
        icon: Icon(
          Icons.refresh,
          size: 30,
        ),
        onPressed: () {
          controller.getFieldData();
        });
  }

  Widget _buildWelcomeTitle(context) {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Text(
            controller.surveyFieldModel.value.welcomeScreen?.title ?? "",
            textAlign: TextAlign.center,
            style: ConstantTextStyle.textStyleTitle,
          ),
        ));
  }

  Widget _buildSubtitle(context) {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            controller.surveyFieldModel.value.welcomeScreen?.description ?? "",
            textAlign: TextAlign.center,
            style: ConstantTextStyle.textStyleSubTitle,
          ),
        ));
  }

  Widget _startBtn(context) {
    return ElevatedButton(
        onPressed: () {
          Get.to(() => SurveyView());
        },
        child: Text(
          "Start",
          style: ConstantTextStyle.textStyleBtn,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
        ));
  }
}
