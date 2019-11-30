import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    //wrapping in container ,setting height then using scrollview enales list be scrolled independently,removed
    //scroll direction to horizontal is for future use
    //list view builder is more optimal
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
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
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            //else
            itemBuilder: (contex, index) {
              //needs widget to  be return
              return TransactionItem(
                transaction: transactions[index],
                deleteTransaction: deleteTransaction,
              );
            },
            itemCount: transactions.length,
          );
  }
}
