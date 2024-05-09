import 'package:dio/dio.dart';
import 'package:eneo_fails/shared/data/services/base_service.dart';
import 'package:eneo_fails/shared/utils/log_util.dart';

class OutageService extends BaseService {
  OutageService({required super.dio});

  Future<Response> getOutages({required Map<String, dynamic> data}) async {
    try {
      var formData = FormData.fromMap(data);
      final response = await post(url: "/ajaxOutage.php", data: formData);
      final dd = response.data;
      logI(dd);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
