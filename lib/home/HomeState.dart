import 'package:financial_frontend/home/HomeDetail.dart';

import 'package:financial_frontend/client/QueryData.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../domain/Spent.dart';

class HomeState extends State<HomeDetail> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  QueryData client = QueryData();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const Padding(
            padding: EdgeInsets.all(16),
            child:
                Text("GASTOS", softWrap: true, style: TextStyle(fontSize: 20))),
        FutureBuilder<Map<String, double>>(
          future: QueryData.listSpents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Expanded(
                  child: PieChart(
                dataMap: snapshot.requireData,
                baseChartColor: Colors.grey,
                legendOptions:
                    const LegendOptions(legendPosition: LegendPosition.bottom),
              ));
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
          },
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Background color
                ),
                onPressed: () {
                  rmDiag();
                },
                child: const Text("Remover Gasto"))),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Background color
                ),
                onPressed: () {
                  showDiag();
                },
                child: const Text("Adicionar Gasto")))
      ])),
    );
  }

  Future rmDiag() {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: const Text(
                "REMOVER DESPESAS",
                softWrap: true,
                style: TextStyle(fontSize: 20),
              ),
              children: [
                FutureBuilder(
                  future: QueryData.listarSpents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.requireData.length,
                          itemBuilder: (context, index) {
                            Spent s = snapshot.requireData[index];
                            return Column(
                              children: [Text(s.name), const Icon(Icons.close)],
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ));
  }

  Future showDiag() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "CADASTRAR DESPESAS",
                softWrap: true,
                style: TextStyle(fontSize: 20),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Nome"),
                      onSaved: (value) {
                        client.controllerMapping(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor envie o nome da nova despesa';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Valor"),
                      onSaved: (value) {
                        client.controllerMapping(double.parse(value!));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor envie o valor da nova despesa';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: cancel, child: const Text("CANCELAR")),
                TextButton(onPressed: submit, child: const Text("ENVIAR"))
              ],
            ));
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      Navigator.pop(context);
      client.putSpent();
    }
  }
}
