import 'dart:convert';


import 'package:financial_frontend/backendDomain/ClientRequestDTO.dart';
import 'package:http/http.dart' as http;

import 'backendDomain/Client.dart';

class queryData {
  ///v1/customer/save
  static void fetchdata(String action, ClientRequestDTO dto) {
    http
        .post(Uri.parse("http://localhost:8080$action"),
            body: jsonEncode(dto.serial()))
        .then((resp) {
      Map map = jsonDecode(resp.body);
      print(map);
    });
  }

  static void list() {
    http
        .get(Uri.parse("http://localhost:8080/v1/customer/query"))
        .then((value) {
      List a = jsonDecode(value.body);
      a.forEach(print);
    });
  }
}
