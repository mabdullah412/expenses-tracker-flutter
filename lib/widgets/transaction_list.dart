import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  // constructor accepts list of transactions
  const TransactionList(this.transactions, this.deleteTransaction, {Key? key})
      : super(key: key);

  // stores list of transactions
  final List<Transaction> transactions;
  // callback to delete transaction
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // if transactions are empty
      // print "empty"
      // else print transactions
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.25,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      // Boxfit.cover takes the heigth of the parent container
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                            onPressed: () {
                              deleteTransaction(transactions[index].id);
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () {
                              deleteTransaction(transactions[index].id);
                            },
                          ),
                  ),
                );
              },
            ),
    );
  }
}
