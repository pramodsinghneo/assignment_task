import 'dart:convert';

import 'package:assignment_task/core/util/pickdate.dart';
import 'package:assignment_task/core/util/strings.dart';
import 'package:assignment_task/core/widget/common_widget.dart';
import 'package:assignment_task/core/widget/constants.dart';
import 'package:assignment_task/core/widget/textstyle.dart';
import 'package:assignment_task/entities/survey_model.dart';
import 'package:assignment_task/presentation/survey_page/survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SurveyView extends GetView<SurveyController> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var controller = Get.put(SurveyController());
  var list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Survey",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 2,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: formPadding(),
                  child: Column(
                    children: [
                      Column(
                        children: controller.listFields!.map<Widget>((e) {
                          switch (e.type) {
                            case shortText:
                              return _buildNameField(
                                  e.id, e.title, e.validations!.requiredItem);
                            case dropdown:
                              return _buildDropDownWidget(
                                  e.id,
                                  e.title,
                                  e.validations!.requiredItem,
                                  e.properties?.choices);
                            case number:
                              return _buildNumberField(
                                  e.id, e.title, e.validations!.requiredItem);
                            case email:
                              return _buildEmailField(
                                  e.id, e.title, e.validations!.requiredItem);
                            case phoneNumber:
                              return _buildPhoneNumberField(
                                  e.id, e.title, e.validations!.requiredItem);
                            case rating:
                              controller.validateRating.value =
                                  e.validations!.requiredItem!;
                              return _buildRatingWidget(
                                  e.id,
                                  e.title,
                                  e.validations!.requiredItem,
                                  e.properties!.steps!);
                            case date:
                              controller.validateDatePicker.value =
                                  e.validations!.requiredItem!;
                              return _buildDatePickerField(
                                  e.id,
                                  e.title,
                                  e.validations!.requiredItem,
                                  context,
                                  e.properties!.structure);
                            case yesNo:
                              controller.validateSelection.value =
                                  e.validations!.requiredItem!;

                              return _buildSelectioWidget(
                                  e.id, e.title, e.validations!.requiredItem);
                          }
                          return SizedBox.shrink();
                        }).toList(),
                      ),
                      _submitBtn(context),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _buildNameField(String? id, String? title, bool? validationReq) {
    return Padding(
      padding: padding(),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: inputDec(title),
        validator: validationReq == true ? Constant.nameValidator : null,
        onSaved: (value) {
          if (!list.contains(id) && !controller.postItemsList.contains(id)) {
            list.add(id);
            var item1 = PostItems(id!, value!);
            controller.postItemsList.add(item1);
          } else {}
        },
      ),
    );
  }

  Widget _buildNumberField(String? id, String? title, bool? validationReq) {
    return Padding(
      padding: padding(),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: inputDec(title),
        validator: validationReq == true ? Constant.numberValidator : null,
        onSaved: (value) {
          var item1 = PostItems(id!, value!);
          controller.postItemsList.add(item1);
        },
      ),
    );
  }

  Widget _buildEmailField(String? id, String? title, bool? validationReq) {
    return Padding(
      padding: padding(),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: inputDec(title),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        validator: validationReq == true ? Constant.emailValidator : null,
        onSaved: (value) {
          if (!list.contains(id) && !controller.postItemsList.contains(id)) {
            list.add(id);
            var item1 = PostItems(id!, value!);
            controller.postItemsList.add(item1);
          } else {}
        },
      ),
    );
  }

  Widget _buildPhoneNumberField(
      String? id, String? title, bool? validationReq) {
    return Padding(
      padding: padding(),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: inputDec(title),
        validator: validationReq == true ? Constant.phoneNumberValidator : null,
        onSaved: (value) {
          var item1 = PostItems(id!, value!);
          controller.postItemsList.add(item1);
        },
      ),
    );
  }

  Widget _buildRatingWidget(
      String? id, String? title, bool? validationReq, int steps) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Column(
        children: [
          Constant.sizedBox(5),
          Text(
            title ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
          Constant.sizedBox(10),
          RatingBar.builder(
            itemSize: 35.0,
            initialRating: 3,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: steps,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.green,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              controller.ratingValue.value = rating.toString();

              if (controller.postItemsList.length > 0) {
                for (int i = 0; i < controller.postItemsList.length; i++) {
                  if (controller.postItemsList[i].id == id) {
                    controller.postItemsList.removeAt(i);
                    var items = PostItems(id!, rating.toString());
                    controller.postItemsList.insert(i, items);
                  } else {
                    var items = PostItems(id!, rating.toString());
                    controller.postItemsList.add(items);
                  }
                }
              } else {
                var items = PostItems(id!, rating.toString());
                controller.postItemsList.add(items);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(String? id, String? title, bool? validationReq,
      context, String? structures) {
    return Padding(
      padding: buildDatePickerFieldPadding(),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.0)),
        margin: datepickermargin(),
        padding: EdgeInsets.symmetric(
          horizontal: 3.0,
        ),
        child: Obx(
          () => Row(
            children: [
              Container(
                child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime date = (await PickDate.datePick(context))!;
                      controller.datePicked.value =
                          DateFormat(dateFormat).format(date);

                      if (controller.postItemsList.length > 0) {
                        for (int i = 0;
                            i < controller.postItemsList.length;
                            i++) {
                          if (controller.postItemsList[i].id == id) {
                            controller.postItemsList.removeAt(i);
                            var items =
                                PostItems(id!, controller.datePicked.value);
                            controller.postItemsList.insert(i, items);
                          } else {
                            var items =
                                PostItems(id!, controller.datePicked.value);
                            controller.postItemsList.add(items);
                          }
                        }
                      } else {
                        var items = PostItems(id!, controller.datePicked.value);
                        controller.postItemsList.add(items);
                      }
                    }),
              ),
              controller.datePicked.value != ""
                  ? Text(controller.datePicked.value)
                  : Text(title ?? ""),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectioWidget(String? id, String? title, bool? validationReq) {
    return Padding(
      padding: buildSelectioWidgetPadding(),
      child: Column(
        children: [
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Constant.sizedBox(10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: controller.listYesNoItem
                .map<Widget>(
                  (e) => Obx(
                    () => InkWell(
                      onTap: () {
                        controller.index.value = e.id;
                        controller.itemIndex.value = id!;
                        if (controller.postItemsList.length > 0) {
                          for (int i = 0;
                              i < controller.postItemsList.length;
                              i++) {
                            if (controller.postItemsList[i].id == id) {
                              controller.postItemsList.removeAt(i);
                              var items = PostItems(id, e.title);
                              controller.postItemsList.insert(i, items);
                            } else {
                              var items = PostItems(id, e.title);
                              controller.postItemsList.add(items);
                            }
                          }
                        } else {
                          var items = PostItems(id, e.title);
                          controller.postItemsList.add(items);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 1.0),
                            left: BorderSide(width: 1.0),
                            right: BorderSide(width: 1.0),
                          ),
                          color: e.id == controller.index.value &&
                                  controller.itemIndex.value == id
                              ? Colors.green
                              : Colors.white,
                        ),
                        width: 165,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            e.title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDropDownWidget(
      String? id, String? title, bool? validateReq, List<Choice>? choices) {
    return Padding(
      padding: buildDropDownWidgetPadding(),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          contentPadding: buildDropDownWidgetContentPadding(),
        ),
        child: DropdownButtonHideUnderline(
          child: Obx(
            () => DropdownButtonFormField<Item>(
              decoration: InputDecoration(enabledBorder: InputBorder.none),
              validator:
                  validateReq == true ? Constant.dropDownValidator : null,
              value: controller.itemValue.value,
              onChanged: (value) {
                controller.itemValue.value = value!;
                if (controller.postItemsList.length > 0) {
                  for (int i = 0; i < controller.postItemsList.length; i++) {
                    if (controller.postItemsList[i].id == id) {
                      controller.postItemsList.removeAt(i);
                      var items = PostItems(id!, value.title);
                      controller.postItemsList.insert(i, items);
                    } else {
                      var items = PostItems(id!, value.title);
                      controller.postItemsList.add(items);
                    }
                  }
                } else {
                  var items = PostItems(id!, value.title);
                  controller.postItemsList.add(items);
                }
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.keyboard_arrow_down),
              ),
              isDense: true,
              items: controller.list.map((value) {
                return DropdownMenuItem<Item>(
                  value: value,
                  child: Text(
                    value.title,
                    style: ConstantTextStyle.textStyleDropDown,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  inputDec(title) {
    return InputDecoration(
      contentPadding: inputDecPadding(),
      labelText: title,
      fillColor: Colors.white,
      labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14.0),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }

  _submitBtn(context) {
    return Padding(
      padding: submitBtnPadding(),
      child: Container(
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            _submitClicked();
          },
          child: Text(submit),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
        ),
      ),
    );
  }

  _submitClicked() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (controller.validateDatePicker.value == true &&
          controller.datePicked.value == "") {
        Constant.showToast(enterDate);
      } else if (controller.validateRating.value == true &&
          controller.ratingValue.value == "0") {
        Constant.showToast(enterRating);
      } else {
        var encodeList =
            controller.postItemsList.map((e) => e.toJson()).toList();
        var encodevalue = json.encode(encodeList);
        controller.postUpdateValue(encodevalue);
        controller.postItemsList.clear();
      }
    } else {}
  }

  padding() {
    return EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0);
  }
}
