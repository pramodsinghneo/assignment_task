import 'package:assignment_task/core/util/routes_path.dart';
import 'package:assignment_task/core/widget/textstyle.dart';
import 'package:assignment_task/presentation/welcome_page/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ThanksView extends StatelessWidget {
  var controller = Get.find<WelcomeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildThanksTitle(context),
            _againBtnAndShare(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThanksTitle(context) {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Text(
            controller.surveyFieldModel.value.thankyouScreens?.title ?? "",
            textAlign: TextAlign.center,
            style: ConstantTextStyle.textStyleTitle,
          ),
        ));
  }

  Widget _againBtnAndShare(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _againBtn(),
        _shareBtn(context),
      ],
    );
  }

  Widget _againBtn() {
    return Container(
      height: 40,
      child: ElevatedButton(
          onPressed: () {
            Get.offNamed(RoutesPath.Initial);
          },
          child: Text(
            "again",
            style: ConstantTextStyle.textStyleBtn,
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          )),
    );
  }

  _sharePressed() {}

  Widget _shareBtn(context) {
    return IconButton(icon: Icon(Icons.share), onPressed: _sharePressed);
  }
}
