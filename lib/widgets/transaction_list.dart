import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      //wrapping in container ,setting height then using scrollview enales list be scrolled independently,removed
      //scroll direction to horizontal is for future use
      //list view builderr is more optimal
      height: 400,
      child: transactions.isEmpty
          ? Column(
              //if transactions is empty
              children: <Widget>[
                Text(
                  'Nothing Added Yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              //else
              itemBuilder: (contex, index) {
                //needs widget to  be return
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Text(
                          'Ksh ${transactions[index].amount.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
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
              },
              itemCount: transactions.length,
            ),
    );
  }
}
