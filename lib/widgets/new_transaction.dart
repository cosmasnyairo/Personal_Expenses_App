import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addnew;

  NewTransaction(this.addnew);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submit() {
    final Enteredtitle = titleController.text;
    final EnteredAmount = double.parse(amountController.text);

    if (Enteredtitle.isEmpty || EnteredAmount <= 0) {
     
      return; //ensures function below being reached
    }
    widget.addnew(
      Enteredtitle,
      EnteredAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit(), //_ is for the value not bein used
            ),
            FlatButton(
                child: Text('Add Transaction'),
                textColor: Colors.brown,
                onPressed: submit)
          ],
        ),
      ),
    );
  }
}
