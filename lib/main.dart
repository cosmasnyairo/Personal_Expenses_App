import 'package:flutter/material.dart';
import 'package:personalexpenses/widgets/transaction_list.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [
    Transaction(
      id: 'a1',
      title: 'Food',
      amount: 2500,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a2',
      title: 'Keyboard',
      amount: 1500,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a3',
      title: 'Mouse',
      amount: 1000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a4',
      title: 'Watch',
      amount: 1500,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a5',
      title: 'Stationery',
      amount: 1230,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a6',
      title: 'Usb',
      amount: 250,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a7',
      title: 'Earphones',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a8',
      title: 'Clothes',
      amount: 1000,
      date: DateTime.now(),
    ),
  ];

  void _newTransaction(String newtitle, double newamount) {
    final newT = Transaction(
      id: DateTime.now().toString(),
      title: newtitle,
      amount: newamount,
      date: DateTime.now(),
    );

    setState(() {
      _usertransactions.add(newT); //add new element to list
    });
  }

  void _StartAddNewTransaction(BuildContext contx) {
    showModalBottomSheet(
      context: contx,
      builder: (_) {
        return GestureDetector(
          onTap: (){},
          child: NewTransaction(_newTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Personal Expenses',
          style: TextStyle(
            color: Colors.lightBlue,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.white70,
            ),
            onPressed: () => _StartAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        //easy scrolling
        child: Column(
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
            TransactionList(_usertransactions)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        backgroundColor: Colors.black,
        onPressed: () => _StartAddNewTransaction(context),
      ),
    );
  }
}
