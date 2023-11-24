import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Learning.dart';


class LearningDescription extends StatelessWidget {
  const LearningDescription(this.it, {super.key});
  final Learning it;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Column(children: [Text(it.title,style: const TextStyle(
            fontSize: 34
        ),softWrap: true), Text("By ${it.author}",style: const TextStyle(
            fontSize: 12
        ), softWrap: true)]),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [Text(it.text)],
        ),
      ),
    );
  }
}