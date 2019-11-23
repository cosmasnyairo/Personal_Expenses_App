import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 'a1',
      title: 'Toothbrush',
      amount: 200,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a2',
      title: 'Keyboard',
      amount: 2000,
      date: DateTime.now(),
    ),
    // Transaction(
    //   id: 'a3',
    //   title: 'Mouse',
    //   amount: 1000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'a4',
    //   title: 'Watch',
    //   amount: 1500,
    //   date: DateTime.now(),
    // ),
  ];

  // String titleInput;
  // String amountInput;

  final titleController =TextEditingController();
  final amountController =TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.deepOrange,
              elevation: 5,
              child: Text('Chart'),
            ),
          ),
          Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
            
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                  ),
                  FlatButton(
                    child: Text('Add Transaction'),
                    textColor: Colors.brown,
                    onPressed: () {
                      print(titleController.text);
                      print(amountController.text);
                    },
                  )
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.teal,
                        width: 2,
                      )),
                      child: Text(
                        'Ksh ${tx.amount}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.teal),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tx.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(tx.date),
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
