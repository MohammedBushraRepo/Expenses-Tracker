import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  //Add new expense recieve method from parent
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }
  final _titleController =
      TextEditingController(); //initiate controller to the text field
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  //to present Date
  void _presentDatePicker() async {
    //configration for the date Picker
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 50, now.month, now.day);

    //handel  Date Picker
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //Show Dialog Based Abone Mobile OS
  void _showDialog() {
    //check device os
    if (Platform.isIOS) {
      //to Show IOS Dialog
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter valid title amount and date "),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); //to exits the alert dialog
              },
              child: const Text("Okay "),
            ),
          ],
        ),
      );
    } else {
      //show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter valid title amount and date "),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); //to exits the alert dialog
              },
              child: const Text("Okay "),
            ),
          ],
        ),
      );
    }
  }

  //handle submitting Data
  void _submittingData() {
    //validate the amount
    final enteredAmount = double.tryParse(_amountController
        .text); //tryParse('hello') = null ,, tryParse('12.5') = 12.5
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    //add the data the Navgation Method
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!, // ! is to tell dart that will not be null
        category: _selectedCategory,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //to handle landscabe Screen with Key Board
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                16, 16, 16, keyboardSpace + 16), //Adjust keyboard space
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text('amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return; //if user select No thing return
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(
                        //also expanded used when adding Row inside row
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, //to push the date into the end of the row
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //to center the content verticly
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ), // ! to force dart to assume that wouldnt be null
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text('amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        //also expanded used when adding Row inside row
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, //to push the date into the end of the row
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //to center the content verticly
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ), // ! to force dart to assume that wouldnt be null
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      //*** cancelation Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),

                      // ** Save Expense Button
                      ElevatedButton(
                        onPressed: _submittingData,
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      //dropdown button
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return; //if user select No thing return
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),

                      const Spacer(),
                      //*** cancelation Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),

                      // ** Save Expense Button
                      ElevatedButton(
                        onPressed: _submittingData,
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
