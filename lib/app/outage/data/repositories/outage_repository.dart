import 'dart:convert';

import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/data/services/outage_service.dart';

class OutageRepository {
  final OutageService _outageService;

  OutageRepository(this._outageService);

  Future<List<EneoOutageModel>> getOutages(
      {required Map<String, dynamic> data}) async {
    final response = await _outageService.getOutages(data: data);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.data);
      List raw_outages = decodedData['data'];
      return raw_outages.map((e) => EneoOutageModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load outages");
    }
  }
}
