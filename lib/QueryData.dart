import 'dart:convert';

import 'package:http/http.dart' as http;

class QueryData {

  static Future<Map<String, double>> listSpents() async {
    List response = jsonDecode(utf8.decode(await http
        .get(Uri.parse("http://localhost:8080/v1/spent/list"))
        .then((value) => value.bodyBytes)));
    print(response);
    List<MapEntry<String,double>> list = [];
    double total = 0;
    response.forEach((object) {
      total = total + object['percentage'];
      list.add(MapEntry(object['name'], object['percentage']));
    });
    total = 100 - total;
    list.add(MapEntry('livre', total));
    print(list);
    Map<String,double> a = {
      ...Map.fromEntries(list)
    };
    print(a);
    return a;
  }
}
