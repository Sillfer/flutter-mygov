import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> transactions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchTransactions,
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }

  void fetchTransactions() async {
    const url = 'http://192.168.9.96:8081/api/order';
    print('fetching transactions');
    final response = await http.get(Uri.parse(url));
    // print('response: $response');
    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        setState(() {
          transactions = data;
          print('transactions: $transactions');
        });
      } catch (e) {
        print('Error decoding JSON response: $e');
      }
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }
}
