import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qoruz/models/request_model.dart';
import '../models/marketplace_model.dart';

class ApiService {
  static Future<List<TalentRequest>> getMarketplaceItems() async {
    final response = await http.get(
      Uri.parse("https://staging3.hashfame.com/api/v1/interview.mplist?page=1"),
    );

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      if (decodedData is Map<String, dynamic> && decodedData.containsKey("marketplace_requests")) {
        List<dynamic> dataList = decodedData["marketplace_requests"];

        return dataList.map((item) => TalentRequest.fromMap(item)).toList();
      } else {
        throw Exception("Unexpected API response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<List<TalentRequest>> getMarketplaceItemsDetails(String id) async {
    final response = await http.get(
      Uri.parse("https://staging3.hashfame.com/api/v1/interview.mplist?id_hash=$id"),
    );

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      if (decodedData is Map<String, dynamic> && decodedData.containsKey("web_marketplace_requests")) {
        List<dynamic> dataList = [decodedData["web_marketplace_requests"]];

        return dataList.map((item) => TalentRequest.fromMap(item)).toList();
      } else {
        throw Exception("Unexpected API response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }
}
