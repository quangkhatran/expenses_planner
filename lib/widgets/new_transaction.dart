import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String _titleInput;
  String _amountInput;
  DateTime _selectedDate;

  void _submitData() {
    if (_amountInput.isEmpty) {
      return;
    }

    final enteredTitle = _titleInput;
    final enteredAmount = double.parse(_amountInput);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      _titleInput,
      double.parse(_amountInput),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onChanged: (val) {
                    _titleInput = val;
                  },
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (val) {
                    _amountInput = val;
                  },
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No Date chosen!'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        ),
                      ),
                      Platform.isIOS
                          ? CupertinoButton(
                              child: Text(
                                'Choose Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: _presentDatePicker,
                            )
                          : FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              child: Text(
                                'Choose Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: _presentDatePicker,
                            ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: () {
                    print(_titleInput);
                    print(_amountInput);
                    _submitData();
                  },
                )
              ]),
        ),
      ),
    );
  }
}
