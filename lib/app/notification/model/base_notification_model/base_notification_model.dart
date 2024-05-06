import 'package:json_annotation/json_annotation.dart';

part 'base_notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseNotificationModel {
  Map<String, dynamic> data;
  String title;
  String description;
  String type;

  BaseNotificationModel(
      {required this.data,
      required this.title,
      required this.type,
      required this.description});

  factory BaseNotificationModel.fromJson(Map<String, dynamic> json) {
    return _$BaseNotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BaseNotificationModelToJson(this);

  BaseNotificationModel copyWith(
      {required data, required title, required type, required description}) {
    return BaseNotificationModel(
      data: data,
      title: title,
      type: type,
      description: description,
    );
  }
}
