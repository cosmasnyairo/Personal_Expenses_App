import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    // DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                color: Colors.black87,
                fontFamily: 'ComicSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
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

  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _usertransactions.where((transc) {
      return transc.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _newTransaction(String newtitle, double newamount, DateTime chosenDate) {
    final newT = Transaction(
      id: DateTime.now().toString(),
      title: newtitle,
      amount: newamount,
      date: chosenDate,
    );

    setState(() {
      _usertransactions.add(newT); //add new element to list
    });
  }

  void _startAddNewTransaction(BuildContext contx) {
    showModalBottomSheet(
      context: contx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_newTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
          middle: Text('Personal Expenses'),
          trailing:Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              )
             ],
          ),
        )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white70,
                ),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
      child: TransactionList(_usertransactions, _deleteTransaction),
    );
    final pageBody = SingleChildScrollView(
      //easy scrolling
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.2,
              child: Chart(_recentTransactions),
            ),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appbar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                : txListWidget
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appbar,
          )
        : Scaffold(
            appBar: appbar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container() //no floating button in IOS
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
