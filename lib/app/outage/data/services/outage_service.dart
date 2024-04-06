import 'package:dio/dio.dart';
import 'package:eneo_fails/shared/data/services/base_service.dart';

class OutageService extends BaseService {
  OutageService({required super.dio});

  Future<Response> getOutages({required Map<String, dynamic> data}) {
    var formData = FormData.fromMap(data);
    return post(url: "/ajaxOutage.php", data: formData);
  }
}
