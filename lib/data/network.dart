import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;

class NetworkService {
  static Future<String?> getUri(
      {required final Uri uri, Map<String, String>? headers}) async {
    try {
      final response = await https.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
