import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //Formatter Object

const uuid = Uuid(); //this packsge is used to generate unique Id

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getters added : flutter pub add intl => for formatting Dates
  String get formattedDate {
    return formatter.format(date);
  }
}

//class to chart for every Category
class ExpenseBucket {
  const ExpenseBucket({ 
    required this.category ,
    required this.expenses,
  });
  
// Adding Extra Constructer Function ,, used to flter the incoming expenses for Each Category
  ExpenseBucket.forCategory(List<Expense> allExpenses , this.category)
  : expenses = allExpenses
  .where((expense) => expense.category == category)
  .toList();
   
  final Category category;
  final List<Expense> expenses;

  //helper getter function
  double get totalExpenses {
    double sum = 0 ;

      for (final expense in expenses){
      sum += expense.amount;
  }

  return sum;   
}

}

