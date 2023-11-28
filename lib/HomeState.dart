import 'package:financial_frontend/HomeDetail.dart';

import 'package:financial_frontend/QueryData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeState extends State<HomeDetail> {

  late Future<Map<String,double>> dataMap;

  @override
  void initState() {
    dataMap = QueryData.listSpents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map<String, double>>(
          future: QueryData.listSpents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Text('Erro ao carregar os dados, Error:${snapshot.error}');
            } else {
              return PieChart(
                dataMap: snapshot.requireData ,baseChartColor: Colors.grey);
            }
          },
        ),
      ),
    );
  }
}
