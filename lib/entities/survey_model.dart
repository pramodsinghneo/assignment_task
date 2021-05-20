import 'dart:convert';

SurveyFieldModel surveyFieldModelFromJson(String str) =>
    SurveyFieldModel.fromJson(json.decode(str));

String surveyFieldModelToJson(SurveyFieldModel data) =>
    json.encode(data.toJson());

class SurveyFieldModel {
  SurveyFieldModel({
    this.title,
    this.welcomeScreen,
    this.thankyouScreens,
    this.fields,
  });

  String? title;
  WelcomeScreen? welcomeScreen;
  ThankyouScreens? thankyouScreens;
  List<Field>? fields;

  factory SurveyFieldModel.fromJson(Map<String, dynamic> json) =>
      SurveyFieldModel(
        title: json["title"],
        welcomeScreen: WelcomeScreen.fromJson(json["welcome_screen"]),
        thankyouScreens: ThankyouScreens.fromJson(json["thankyou_screens"]),
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "welcome_screen": welcomeScreen?.toJson(),
        "thankyou_screens": thankyouScreens?.toJson(),
        "fields": List<dynamic>.from(fields!.map((x) => x.toJson())),
      };
}

class Field {
  Field({
    this.id,
    this.title,
    this.validations,
    this.type,
    this.properties,
  });

  String? id;
  String? title;
  Validations? validations;
  String? type;
  Properties? properties;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        title: json["title"],
        validations: Validations.fromJson(json["validations"]),
        type: json["type"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "validations": validations?.toJson(),
        "type": type,
        "properties": properties == null ? null : properties?.toJson(),
      };
}

class Properties {
  Properties({
    this.alphabeticalOrder,
    this.choices,
    this.steps,
    this.structure,
  });

  bool? alphabeticalOrder;
  List<Choice>? choices;
  int? steps;
  String? structure;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        alphabeticalOrder: json["alphabetical_order"] == null
            ? null
            : json["alphabetical_order"],
        choices: json["choices"] == null
            ? null
            : List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        steps: json["steps"] == null ? null : json["steps"],
        structure: json["structure"] == null ? null : json["structure"],
      );

  Map<String, dynamic> toJson() => {
        "alphabetical_order":
            alphabeticalOrder == null ? null : alphabeticalOrder,
        "choices": choices == null
            ? null
            : List<dynamic>.from(choices!.map((x) => x.toJson())),
        "steps": steps == null ? null : steps,
        "structure": structure == null ? null : structure,
      };
}

class Choice {
  Choice({
    this.label,
  });

  String? label;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
      };
}

class Validations {
  Validations({
    this.requiredItem,
  });

  bool? requiredItem;

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        requiredItem: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "required": requiredItem,
      };
}

class ThankyouScreens {
  ThankyouScreens({
    this.title,
  });

  String? title;

  factory ThankyouScreens.fromJson(Map<String, dynamic> json) =>
      ThankyouScreens(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class WelcomeScreen {
  WelcomeScreen({
    this.title,
    this.description,
  });

  String? title;
  String? description;

  factory WelcomeScreen.fromJson(Map<String, dynamic> json) => WelcomeScreen(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
