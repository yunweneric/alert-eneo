import 'package:dio/dio.dart';
import 'package:eneo_fails/app/outage/data/controller/eneo_outage/eneo_outage_bloc.dart';
import 'package:eneo_fails/app/outage/data/repositories/outage_repository.dart';
import 'package:eneo_fails/app/outage/data/services/outage_service.dart';
import 'package:eneo_fails/shared/components/navigation/navigation_bar_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocators {
  static register() {
    Dio dio = Dio()
      ..interceptors.add(
        LogInterceptor(responseBody: true),
      );

    OutageService outageService = OutageService(
      dio: dio..options.baseUrl = "https://alert.eneo.cm",
    );
    getIt.registerSingleton<OutageService>(outageService);

    OutageRepository outageRepository = OutageRepository(outageService);
    getIt.registerSingleton<OutageRepository>(outageRepository);

    EneoOutageBloc _EneoOutageBloc = EneoOutageBloc(outageRepository);
    NavigationBarBloc _navigationBarBloc = NavigationBarBloc();

    getIt.registerSingleton<EneoOutageBloc>(_EneoOutageBloc);
    getIt.registerSingleton<NavigationBarBloc>(_navigationBarBloc);

    print("Service locators registered ...");
  }
}
