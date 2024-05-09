import 'package:dio/dio.dart';
import 'package:eneo_fails/app/donation/data/controller/donation/donation_bloc.dart';
import 'package:eneo_fails/app/donation/data/repository/donate_repository.dart';
import 'package:eneo_fails/app/location/data/repositories/location_repository.dart';
import 'package:eneo_fails/app/location/data/services/location_service.dart';
import 'package:eneo_fails/app/notification/data/controller/notification/notification_bloc.dart';
import 'package:eneo_fails/app/notification/data/repository/local_notification_repository.dart';
import 'package:eneo_fails/app/notification/data/services/local_notification_service.dart';
import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/repositories/outage_repository.dart';
import 'package:eneo_fails/app/outage/data/services/outage_service.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:eneo_fails/shared/data/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocators {
  static register() async {
    Dio dio = Dio()
      ..interceptors.add(
        LogInterceptor(responseBody: true),
      );

    OutageService outageService = OutageService(
      dio: dio..options.baseUrl = "https://alert.eneo.cm",
    );

    LocationService locationService = LocationService(
      dio: dio..options.baseUrl = "https://alert.eneo.cm",
    );

    LocalStorageService localStorageService = LocalStorageService();
    LocalNotificationService localNotificationService = LocalNotificationService();
    // BackGroundService backGroundService = BackGroundService(locationService);

    getIt.registerSingleton<OutageService>(outageService);
    getIt.registerSingleton<LocationService>(locationService);
    getIt.registerSingleton<LocalStorageService>(localStorageService);
    getIt.registerSingleton<LocalNotificationService>(localNotificationService);
    // getIt.registerSingleton<BackGroundService>(backGroundService);

    OutageRepository outageRepository = OutageRepository(outageService);
    LocationRepository locationRepository = LocationRepository(locationService);
    DonationRepository donationRepository = DonationRepository();
    LocalNotificationRepository localNotificationRepository = LocalNotificationRepository(localNotificationService);
    getIt.registerSingleton<OutageRepository>(outageRepository);
    getIt.registerSingleton<DonationRepository>(donationRepository);
    getIt.registerSingleton<LocalNotificationRepository>(localNotificationRepository);

    NotificationBloc notificationBloc = NotificationBloc(localNotificationRepository);
    DonationBloc donationBloc = DonationBloc(donationRepository);
    EneoOutageBloc _eneoOutageBloc = EneoOutageBloc(outageRepository, locationRepository, notificationBloc);
    NavigationBarBloc _navigationBarBloc = NavigationBarBloc();

    getIt.registerSingleton<NotificationBloc>(notificationBloc);
    getIt.registerSingleton<EneoOutageBloc>(_eneoOutageBloc);
    getIt.registerSingleton<NavigationBarBloc>(_navigationBarBloc);
    getIt.registerSingleton<DonationBloc>(donationBloc);

    print("Service locators registered ...");
  }

  static EneoOutageBloc registerBackGround() {
    Dio dio = Dio()
      ..interceptors.add(
        LogInterceptor(responseBody: true),
      );

    OutageService outageService = OutageService(
      dio: dio..options.baseUrl = "https://alert.eneo.cm",
    );

    LocationService locationService = LocationService(
      dio: dio..options.baseUrl = "https://alert.eneo.cm",
    );

    LocalNotificationService localNotificationService = LocalNotificationService();

    OutageRepository outageRepository = OutageRepository(outageService);
    LocationRepository locationRepository = LocationRepository(locationService);
    LocalNotificationRepository localNotificationRepository = LocalNotificationRepository(localNotificationService);

    NotificationBloc notificationBloc = NotificationBloc(localNotificationRepository);
    EneoOutageBloc _eneoOutageBloc = EneoOutageBloc(outageRepository, locationRepository, notificationBloc);

    print("Service locators registered ...");
    return _eneoOutageBloc;
  }
}
