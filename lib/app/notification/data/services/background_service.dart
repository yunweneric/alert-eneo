import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';
import 'package:eneo_fails/app/location/data/services/location_service.dart';
import 'package:eneo_fails/app/notification/data/services/local_notification_service.dart';
import 'package:eneo_fails/app/notification/model/background_task_types.dart';
import 'package:eneo_fails/app/notification/model/base_notification_model/base_notification_model.dart';
import 'package:eneo_fails/app/notification/model/notification_types.dart';
import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/data/services/outage_service.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/data/models/user_outage_model.dart';
import 'package:eneo_fails/shared/utils/log_util.dart';
import 'package:workmanager/workmanager.dart';

class BackGroundService {
  static void initialize(EneoOutageBloc _eneoOutageBloc) {
    Dio dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));
    OutageService outageService = OutageService(dio: dio..options.baseUrl = "https://alert.eneo.cm");
    LocationService locationService = LocationService(dio: dio..options.baseUrl = "https://alert.eneo.cm");
    LocalNotificationService localNotificationService = LocalNotificationService();

    Workmanager().executeTask((task, inputData) async {
      try {
        logI(task);
        logI(inputData);
        checkOutage(locationService, outageService, localNotificationService);
        return Future.value(true);
      } catch (e) {
        logError(e);
        return Future.error(e);
      }
    });
  }

  // static void checkOutage(EneoOutageBloc _eneoOutageBloc) async {
  //   try {
  //     logI("checkOutage");
  //     _eneoOutageBloc.add(CheckBackGroundUserEneoOutageEvent());
  //   } catch (e) {
  //     logError(e);
  //   }
  // }

  static void checkOutage(
    LocationService _locationService,
    OutageService _outageService,
    LocalNotificationService notification_service,
  ) async {
    Map<String, dynamic>? user_location = await _locationService.determineCurrentLocation();
    if (user_location == null) return;
    LocationModel? location = LocationModel.fromJson(user_location);

    final response = await _outageService.getOutages(data: {"localite": location.placemark!.locality!});
    if (response != 200) return;
    final decodedData = json.decode(response.data);
    List raw_outages = decodedData['data'];

    List<EneoOutageModel> new_outages = raw_outages.map((e) => EneoOutageModel.fromJson(e)).toList();
    bool hasElectricity = new_outages.length == 0;
    final userOutage = UserOutage(hasElectricity: hasElectricity, userLocation: location);
    BaseNotificationModel model = BaseNotificationModel(
      data: userOutage.toJson(),
      title: "notifications.outage_title",
      type: NotificationType.EneoOutage,
      description: "notifications.outage_description",
    );
    notification_service.showSimpleNotification(
      title: model.title,
      description: model.description,
      payload: json.encode(userOutage.toJson()),
    );
  }

  static void registerPeriodicTask() {
    Workmanager().registerPeriodicTask(
      BackGroundTask.periodic_outage,
      BackGroundTask.periodic_outage,
      frequency: Duration(minutes: 15),
    );
  }

  static void registerOneOffTask() {
    Workmanager().registerOneOffTask(BackGroundTask.on_off_task, BackGroundTask.on_off_task);
  }
}
