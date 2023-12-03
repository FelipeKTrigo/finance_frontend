import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../domain/Spent.dart';
import '../domain/customer.dart';

class QueryData<T>{
  List<T> list = [];

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
  static Future<customer> customerGet() async {
    Map<String,dynamic> response = jsonDecode(await http
        .get(Uri.parse("http://localhost:8080/v1/customer/get"))
        .then((value) => value.body));
    return customer.fromJSON(response);
  }
  void controllerMapping(T obj){
    list.add(obj);
  }
  Future<Map<String, dynamic>> putSpent() async {
    final queryParameter = {'id': '1'};
    final uri =
    Uri.http("localhost:8080", "/v1/customer/add/spent", queryParameter);
    final response = jsonDecode(await http
        .put(uri,
        headers: {"Content-type": "application/json; charset=utf-8"},
        body: put(list[1] as double, list[0] as String))
        .then((value) => value.body));
    print(response);
    return response;
  }
  String put(double price, String name) {
    return jsonEncode({'price': price, 'name': name});
  }

  static Future<List<Spent>> listarSpents() async {
    List response = jsonDecode(utf8.decode(await http
            .get(Uri.parse("http://localhost:8080/v1/spent/list"))
        .then((value) => value.bodyBytes)));
    List<Spent> list = response.map((e){
      return Spent.fromJson(e);
    }).toList();
    print(list.map((element) => element.id).toList());
    return list;
  }
}
