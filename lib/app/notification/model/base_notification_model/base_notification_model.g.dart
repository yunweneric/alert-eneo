// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseNotificationModel _$BaseNotificationModelFromJson(
        Map<String, dynamic> json) =>
    BaseNotificationModel(
      data: json['data'] as Map<String, dynamic>,
      title: json['title'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$BaseNotificationModelToJson(
        BaseNotificationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
    };
