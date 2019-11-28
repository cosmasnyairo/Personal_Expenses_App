import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Padding(
                      padding: EdgeInsets.all(9),
                      child: FittedBox(
                        child: Text(
                            '${transactions[index].amount.toStringAsFixed(0)}/='),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                        textColor: Colors.black,
                        icon: Icon(Icons.delete),
                        label: Text('Delete'),
                        onPressed: () =>deleteTransaction(transactions[index].id)

                      )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          tooltip: 'Delete Transaction',
                          color: Colors.black,
                          onPressed: () =>deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
