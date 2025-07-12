import 'package:http/http.dart' as http;

var client = http.Client();
String host = ""; // Test

class NetworkManager {
  static Uri buildUrl(String endpoint) {
    final apiPath = "$host$endpoint";
    return Uri.parse(apiPath);
  }

  static bool responseTrue({
    required httpStatusCode,
  }) {
    if (
        (httpStatusCode == 200 || httpStatusCode == 201)) {
      return true;
    } else {
      return false;
    }
  }

  /// Make a get request
  static Future<http.Response> getData(var endpoint) async {
    var response = await client.get(
      buildUrl(endpoint),
      headers: {"Content-Type": "application/json", "Accept": "*/*"},
    );
    return response;
  }
}
