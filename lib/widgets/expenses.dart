import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter course ',
      amount: 19.50,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema ',
      amount: 20.50,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  //to display the existing expenses
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  //to Add New Expense we need to create method to receive the Data and show into expense
  void _addExpense(Expense expense) {
    setState(() {
      //resceive expense object and add it to the list
      _registeredExpenses.add(expense);
    });
  }

  //to Remove Expense
  void _removeExpense(Expense expense) {
    final expenseIndex =
        _registeredExpenses.indexOf(expense); //get the index of removed expense
    setState(() {
      _registeredExpenses.remove(expense);
    });
    //to empty the snack when removong multible items
    ScaffoldMessenger.of(context).clearSnackBars();
    //to display message when removing a List
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted "),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex,
                    expense); //needs the index and the deleted obhect to be return back
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //if their is NO content
    Widget mainContent = const Center(
      child: Text("No expenses found . Start adding some !"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
           Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    ); //Genral Styles
  }
}
