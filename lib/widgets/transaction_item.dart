import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
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
                child: Text('${transaction.amount.toStringAsFixed(0)}/='),
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(transaction.date),
          ),
          trailing: MediaQuery.of(context).size.width > 500
              ? FlatButton.icon(
                  textColor: Colors.black,
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  onPressed: () => deleteTransaction(transaction.id))
              : IconButton(
                  icon: Icon(Icons.delete),
                  tooltip: 'Delete Transaction',
                  color: Colors.black,
                  onPressed: () => deleteTransaction(transaction.id),
                ),
        ),
    );
  }
}
