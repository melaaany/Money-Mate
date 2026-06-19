import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // Daftar transaksi dinamis
  List<Map<String, dynamic>> transactions = [
    {'title': 'Poke Bowl Central', 'category': 'Food & Dining', 'amount': -24.50, 'isIncome': false, 'icon': Icons.restaurant, 'color': const Color(0xFFFEE2E2)},
    {'title': 'Salary Deposit', 'category': 'Income', 'amount': 3200.00, 'isIncome': true, 'icon': Icons.payments, 'color': AppColors.lightGreen},
  ];

  // Menampilkan Bottom Sheet untuk tambah transaksi
  void _showAddTransactionSheet() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    bool isIncome = false; // Default: Pengeluaran (Expense)

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Memungkinkan lembaran naik saat keyboard muncul
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder( // StatefulBuilder agar toggle switch dalam pop-up bisa direfresh
            builder: (BuildContext context, StateSetter setModalState) {
              return Padding(
                // Padding bawah untuk menghindari tertutup keyboard
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Add Transaction', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.darkGreen)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tipe: ', style: TextStyle(fontSize: 16)),
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(10),
                          isSelected: [!isIncome, isIncome],
                          onPressed: (index) {
                            setModalState(() => isIncome = index == 1);
                          },
                          children: const [
                            Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Expense')),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Income')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Transaction Name', border: OutlineInputBorder())),
                    const SizedBox(height: 16),
                    TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (\$)', border: OutlineInputBorder())),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGreen, padding: const EdgeInsets.symmetric(vertical: 16)),
                        onPressed: () {
                          if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                            // Update UI halaman transaksi
                            setState(() {
                              transactions.insert(0, { // Insert di index 0 agar data baru muncul paling atas
                                'title': titleController.text,
                                'category': isIncome ? 'Income' : 'General',
                                'amount': double.parse(amountController.text),
                                'isIncome': isIncome,
                                'icon': isIncome ? Icons.account_balance_wallet : Icons.shopping_cart,
                                'color': isIncome ? AppColors.lightGreen : const Color(0xFFFEE2E2),
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save Transaction', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        title: const Text('Transactions', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkGreen,
        onPressed: _showAddTransactionSheet, // Panggil Bottom Sheet
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                String amountPrefix = tx['isIncome'] ? '+\$' : '-\$';
                Color amountColor = tx['isIncome'] ? AppColors.darkGreen : Colors.red;

                return _buildTxCard(
                    tx['icon'], tx['color'], tx['title'], tx['category'],
                    '$amountPrefix${tx['amount'].abs()}', amountColor
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTxCard(IconData icon, Color bg, String title, String sub, String amount, Color amtCol) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12), elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: bg, shape: BoxShape.circle), child: Icon(icon, color: Colors.black87)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.black54)),
        trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: amtCol)),
      ),
    );
  }
}