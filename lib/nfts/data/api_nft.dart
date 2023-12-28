import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../import.dart';

class ApiClientNFT {
  static Future<List<NFTModel>> getNFT(
      StreamController<String> errorController) async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://$myApiDomain/api/v2/&token=$myApiToken');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonT = jsonDecode(response.body) as Map<String, dynamic>;
        final json = jsonT['results'] as List<dynamic>;
        final map = json.map((e) => e as Map<String, dynamic>).toList();
        return map.map((e) => NFTModel.fromMap(e)).toList();
      }
      return [];
    } catch (_) {
      errorController.add('Check your internet connection');
      return [];
    }
  }
}
