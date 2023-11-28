import 'package:financial_frontend/HomeDetail.dart';

import 'package:financial_frontend/QueryData.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        Expanded(
            child: FutureBuilder<Map<String, double>>(
          future: QueryData.listSpents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return PieChart(
                dataMap: snapshot.requireData,
                baseChartColor: Colors.grey,
                legendOptions:
                    const LegendOptions(legendPosition: LegendPosition.bottom),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        )),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Adicionar Gasto")))
      ])),
    );
  }
}
