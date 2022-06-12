import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String titleInput;

  String amountInput;

  void submitData() {
    final enteredTitle = titleInput;
    final enteredAmount = double.parse(amountInput);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(titleInput, double.parse(amountInput));
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (val) {
                  titleInput = val;
                },
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  amountInput = val;
                },
                onSubmitted: (_) => submitData(),
              ),
              FlatButton(
                child: Text('Add Transaction'),
                textColor: Colors.purple,
                onPressed: () {
                  print(titleInput);
                  print(amountInput);
                  submitData();
                },
              )
            ]),
      ),
    );
  }
}
