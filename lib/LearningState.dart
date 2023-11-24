import 'package:financial_frontend/LearningDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Learning.dart';
import 'LearningDescription.dart';

class LearningState extends State<LearningDetail>{
  List<Learning> list = [
    Learning("CDB", "Lorem Ipsum 1", "Felipe trigo"),
    Learning("Renda Fixa", "Lorem Ipsum 2", "Felipe trigo"),
    Learning("Renda Variavel", "Lorem Ipsum 3", "Felipe trigo"),
    Learning("Ações para iniciantes no Mercado", "Lorem Ipsum 3", "Felipe trigo")
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      CupertinoSliverNavigationBar(
        largeTitle: Container(alignment: Alignment.center,child: Text('Learning')),
      ),
      SliverSafeArea(
        top: false,
        minimum: const EdgeInsets.only(top: 0),
        sliver: SliverToBoxAdapter(
          child: CupertinoListSection(
              topMargin: 0,
              children: [
                for (var it in list)
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.green[800])),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LearningDescription(it)));
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              const Icon(Icons.play_arrow, color: Colors.white),
                              Text(it.title,
                                  style: const TextStyle(fontSize: 22))
                            ])),
                      ))
              ]),
        ),
      )
    ]);
  }

}