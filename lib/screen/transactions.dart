import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  dynamic data;
  void _search() {
    var url = Uri.parse(
        'http://192.168.9.96:8081/api/order'); // always check the url is correct
    http.get(url).then((response) {
      setState(() {
        data = jsonDecode(response.body);
      });
      // print("response");
      // print(response);
      // print(response.body);
    }).catchError((onError) {
      print("onError");
      print(onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    _search();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: (data == null) ? 0 : data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        // Text(
                        //   "${data[index]['orderLineItemsList'].length} items",
                        //   style: TextStyle(
                        //       fontSize: 20, fontWeight: FontWeight.bold),
                        // ),
                        // Text(
                        //   "${data[index]['orderNumber']}",
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data[index]['orderLineItemsList'].length,
                          itemBuilder: (context, itemIndex) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data[index]['orderLineItemsList'][itemIndex]['skuCode']}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${data[index]['orderLineItemsList'][itemIndex]['price']} MAD",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      drawer: const Drawer(),
    );
  }
}
