import 'package:flutter/material.dart';

class MoneyMateData extends ChangeNotifier {
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> pockets = [
    {'title': 'Emergency Fund', 'saved': 8000.0, 'target': 10000.0},
  ];

  // Menghitung angka secara dinamis
  double get totalIncome => transactions
      .where((t) => t['isIncome'] == true)
      .fold(0.0, (sum, t) => sum + t['amount']);

  double get totalExpense => transactions
      .where((t) => t['isIncome'] == false)
      .fold(0.0, (sum, t) => sum + t['amount']);

  double get balance => totalIncome - totalExpense;

  void addTransaction(Map<String, dynamic> tx) {
    transactions.insert(0, tx);
    notifyListeners(); // Semua UI (Home, Transaksi, Spending) otomatis update
  }

  void topUpPocket(int index, double amount) {
    pockets[index]['saved'] += amount;
    // Otomatis dianggap sebagai pengeluaran dari saldo kas utama
    addTransaction({'title': 'Top Up: ${pockets[index]['title']}', 'amount': amount, 'isIncome': false});
    notifyListeners();
  }
}