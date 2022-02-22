import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

Future<dynamic> getFromUrl(String _url) async {
  var url = Uri.parse(_url);

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    },
  );
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse;
  } else {
    return ['Request failed with status: ${response.statusCode}.'];
  }
}

Future<bool> computeFakeData() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );
  return true;
}

Future<List<String>> getProduct() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );
  return ["banane", "pomme", "poire", "fraise"];
}

Future<List<String>> computeData() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );
  Random random = Random.secure();
  int randomInt = random.nextInt(100);

  List<String> result = [];

  for (int i = 0; i < randomInt; i++) {
    result.add("oui");
  }
  return result;
}

Future<Map<String, dynamic>> getUserById(String id) async {
  return await getFromUrl('http://www.localhost:3000/getUserById?id=$id')
      as Map<String, dynamic>;
}

Future<List<dynamic>> getFriends(String id) async {
  return await getFromUrl('http://www.localhost:3000/getFriends?id=$id')
      as List<dynamic>;
}

Future<List<dynamic>> getProducts() async {
  return await getFromUrl('http://www.localhost:3000/getProducts')
      as List<dynamic>;
}

Future<List<dynamic>> getUsers() async {
  return await getFromUrl('http://www.localhost:3000/getUsers')
      as List<dynamic>;
}

Future<List<dynamic>> buyArticle(int userId, int articleId) async {
  return await getFromUrl(
          'http://www.localhost:3000/buy?id=$userId&productid=$articleId')
      as List<dynamic>;
}

Future<List<dynamic>> unbuyArticle(int userId, int articleId) async {
  return await getFromUrl(
          'http://www.localhost:3000/unbuy?id=$userId&productid=$articleId')
      as List<dynamic>;
}

Future<List<dynamic>> follow(int id, int id2) async {
  return await getFromUrl('http://www.localhost:3000/follow?id=$id&id2=$id2')
      as List<dynamic>;
}

Future<List<dynamic>> unfollow(int id, int id2) async {
  return await getFromUrl('http://www.localhost:3000/unfollow?id=$id&id2=$id2')
      as List<dynamic>;
}
