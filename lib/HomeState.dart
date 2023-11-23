import 'package:financial_frontend/HomeDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeState extends State<HomeDetail> {
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
    "almoço": 34,
    "picanha": 90,
    "leite": 1
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Text("Grafico", style: TextStyle(fontSize: 20)),
          Expanded(child: PieChart(dataMap: dataMap, baseChartColor: Colors.grey)),
          ElevatedButton(onPressed: () {
            setState(() {
              String key = "leite";
              dataMap.update(key, (value) => value+1);
            });
          },child: Text("Add"),)
        ]),
      ),
    );
  }
}
