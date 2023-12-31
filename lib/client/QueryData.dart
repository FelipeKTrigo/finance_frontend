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
    List<MapEntry<String,double>> list = [];
    double total = 0;
    response.forEach((object) {
      total = total + object['percentage'];
      list.add(MapEntry(object['name'], object['percentage']));
    });
    total = 100 - total;
    list.add(MapEntry('livre', total));
    Map<String,double> a = {
      ...Map.fromEntries(list)
    };
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
  static void deleteSpents(context,int id) {
    final uri = Uri.parse("http://localhost:8080/v1/spent/delete?id=$id");
    http.delete(uri);
    Navigator.of(context).pop();
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
    list.clear();
    return response;
  }
  String put(double price, String name) {
    return jsonEncode({'price': price, 'name': name});
  }

  static Future<List<Spent>> listarSpents() async {
    List response = jsonDecode(utf8.decode(await http
        .get(Uri.parse("http://localhost:8080/v1/spent/list"))
        .then((value) => value.bodyBytes)));
    List<Spent> list = response.map((e) => Spent.fromJson(e)).toList();
    return list;
  }
}
