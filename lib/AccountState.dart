import 'package:financial_frontend/AccountDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountState extends State<AccountDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Image.asset("asset/img.png",scale: 2),
              const Text(
                "Robert Banks(Rob Banks)",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 20.0,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),

                      margin: const EdgeInsets.symmetric(
                          vertical: 11.0, horizontal: 24.0),
                      child: Row(children: [
                        const Icon(Icons.phone,
                            color: Color.fromARGB(255, 122, 122, 122)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                          child: Text(
                            "11 95140 4161",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SourceSans',
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(
                          vertical: 11.0, horizontal: 24.0),
                      child: Row(children: [
                        const Icon(Icons.email,
                            color: Color.fromARGB(255, 122, 122, 122)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                          child: Text(
                            "felipeknonertrigo@gmail.com",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SourceSans',
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }

}