import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  // constructor to initialize the value of recent transactions
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  // recent transactions contains transactions for the last week
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // weekday will be used to calculate for last 7 days.
      // so for that we first get the current time.
      // then on the next iteration, we minus 1 from the current Day.
      // in this way we get the last 7 days
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      // here we filter recent transactions for a particular weekday add all
      // of them to get total for that day
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        // .E() returns shortcut fot the given day
        // ex: .E(Tuesday) = 'T', .E(Sunday) = 'S'
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + double.parse('${element['amount']}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  tx['day'] as String,
                  tx['amount'] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : (tx['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
