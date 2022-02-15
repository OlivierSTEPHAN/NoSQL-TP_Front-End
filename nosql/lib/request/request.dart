import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<String> getFromUrl(String url) async {
  var url =
      Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    return 'Number of books about http: $itemCount.';
  } else {
    return 'Request failed with status: ${response.statusCode}.';
  }
}
