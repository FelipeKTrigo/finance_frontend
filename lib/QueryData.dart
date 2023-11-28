import 'dart:convert';

import 'package:http/http.dart' as http;

class QueryData {

  static Future<Map<String, double>> listSpents() async {
    List response = jsonDecode(await http
        .get(Uri.parse("http://localhost:8080/v1/spent/list"))
        .then((value) => value.body));
    print(response);
    List<MapEntry<String,double>> list = [];
    response.forEach((object) {
      list.add(MapEntry(object['name'], object['percentage']));
    });
    print(list);
    Map<String,double> a = {
      ...Map.fromEntries(list)
    };
    print(a);
    return a;
  }
}
