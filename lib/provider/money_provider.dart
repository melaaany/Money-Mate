import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final String category;
  Transaction({required this.id, required this.title, required this.amount, required this.category});
}

class FinanceProvider with ChangeNotifier {
  double _totalBalance = 12450.80;
  List<Transaction> _transactions = [
    Transaction(id: '1', title: 'Green Curry Bistro', amount: -24.50, category: 'Food'),
  ];

  double get totalBalance => _totalBalance;
  List<Transaction> get transactions => _transactions;

  void addTransaction(String title, double amount, String category) {
    _transactions.add(Transaction(id: DateTime.now().toString(), title: title, amount: amount, category: category));
    _totalBalance += amount;
    notifyListeners(); // Perintah ajaib agar UI terupdate
  }
}