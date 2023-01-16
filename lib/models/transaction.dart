class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  // final: so that value can't change

  // using named arguments,
  // so that data can be given in any order
  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
