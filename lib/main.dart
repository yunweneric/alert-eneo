import 'package:eneo_fails/app/notification/data/services/background_service.dart';
import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/core/bootstrap.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@pragma('vm:entry-point')
initializeBackgroundTask() {
  EneoOutageBloc eneoOutageBloc = ServiceLocators.registerBackGround();
  BackGroundService.initializeWorkManager(eneoOutageBloc);
}

void main() async {
  await dotenv.load(fileName: ".env");
  bootstrap(initializeBackgroundTask);
}
