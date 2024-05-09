import 'dart:async';
import 'dart:ui';
import 'package:eneo_fails/app/notification/model/background_task_types.dart';
import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class BackGroundService {
  static void initializeWorkManager(EneoOutageBloc _eneoOutageBloc) {
    Workmanager().cancelAll();
    Workmanager().executeTask((task, inputData) async {
      try {
        switch (task) {
          case BackGroundTask.PeriodicOutage:
            FlutterBackgroundService().invoke(BackGroundTask.PeriodicOutage);
            break;
          case BackGroundTask.OneOffTask:
            FlutterBackgroundService().invoke(BackGroundTask.OneOffTask);
            break;
          default:
        }

        return Future.value(true);
      } catch (e) {
        logError(e);
        return Future.error(e);
      }
    });
  }

  static void checkOutage() async {
    try {
      final eneoOutageBloc = await ServiceLocators.registerBackGround();
      eneoOutageBloc.add(CheckBackGroundUserEneoOutageEvent());
    } catch (e) {
      logError(e);
    }
  }

  static void registerPeriodicTask() {
    Workmanager().registerPeriodicTask(
      BackGroundTask.PeriodicOutage,
      BackGroundTask.PeriodicOutage,
      frequency: Duration(minutes: 15),
      initialDelay: Duration(minutes: 5),
    );
  }

  static void registerOneOffTask() {
    Workmanager().registerOneOffTask(
      BackGroundTask.OneOffTask,
      BackGroundTask.OneOffTask,
      initialDelay: Duration(minutes: 5),
    );
  }

  static Future<void> initializeBackgroundService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        // auto start service
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,
        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,
        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
  }

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    final log = preferences.getStringList('log') ?? <String>[];
    log.add(DateTime.now().toIso8601String());
    await preferences.setStringList('log', log);

    return true;
  }

  static Future<void> onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    // bring to foreground
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      service.on(BackGroundTask.PeriodicOutage).listen((event) {
        checkOutage();
      });
      service.on(BackGroundTask.OneOffTask).listen((event) {
        checkOutage();
      });
    });
  }
  // static void checkOutage() async {
  //   try {

  //     Dio dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));
  //     // OutageService outageService =  OutageService(dio: dio..options.baseUrl = "https://alert.eneo.cm");
  //     final outageService = getIt.get<OutageService>();
  //     final localNotificationService = getIt.get<LocalNotificationService>();
  //     final locationService = LocationService(dio: dio..options.baseUrl = "https://alert.eneo.cm");
  //     // LocalNotificationService localNotificationService = LocalNotificationService();

  //     LocationModel? location = await LocalStorageService.getLocation();
  //     if (location == null) return;

  //     await localNotificationService.initialize();
  //     // localNotificationService.showSimpleNotification(
  //     //   title: "model.title",
  //     //   description: "model.description",
  //     //   payload: "",
  //     // );
  //     // print("---");

  //     final response = await outageService.getOutages(data: {"localite": location.placemark!.locality!});
  //     if (response.statusCode != 200) return;
  //     final decodedData = json.decode(response.data);
  //     List raw_outages = decodedData['data'];

  //     List<EneoOutageModel> new_outages = raw_outages.map((e) => EneoOutageModel.fromJson(e)).toList();
  //     bool hasElectricity = new_outages.length == 0;
  //     final userOutage = UserOutage(hasElectricity: hasElectricity, userLocation: location);

  //     BaseNotificationModel model = BaseNotificationModel(
  //       data: userOutage.toJson(),
  //       title: LangUtil.trans("notifications.outage_title"),
  //       type: NotificationType.EneoOutage,
  //       description: "notifications.outage_out_description",
  //     );
  //     localNotificationService.showSimpleNotification(
  //       title: model.title,
  //       description: model.description,
  //       payload: json.encode(userOutage.toJson()),
  //     );
  //   } catch (e) {
  //     logError(e);
  //   }
  // }
}
