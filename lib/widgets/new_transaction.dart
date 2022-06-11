import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  String titleInput;
  String amountInput;

  NewTransaction(this.addTx);

  void submitData() {
    final enteredTitle = titleInput;
    final enteredAmount = double.parse(amountInput);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addTx(titleInput, double.parse(amountInput));
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
