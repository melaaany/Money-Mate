import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(backgroundColor: Colors.grey.shade300, child: const Icon(Icons.person, color: Colors.white)),
        ),
        title: const Text('MoneyMate', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold, fontSize: 22)),
        actions: [IconButton(icon: const Icon(Icons.notifications_none, color: AppColors.darkGreen), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Balance', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text('\$12,450.80', style: TextStyle(color: Color(0xFF064E3B), fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildBalInfo(Icons.arrow_upward, 'SAVINGS', '\$8,200'),
                      Container(width: 1, height: 40, color: AppColors.darkGreen.withOpacity(0.2)),
                      const SizedBox(width: 16),
                      _buildBalInfo(Icons.money, 'CASH', '\$4,250'),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildInfoCard('Income', '\$4,850.00', 'This month', AppColors.darkGreen)),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard('Expenses', '\$3,120.45', '78% of budget', Colors.red)),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Recent Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('View All', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            _itemTx(Icons.restaurant, const Color(0xFFD1FAE5), 'Green Curry Bistro', 'Food & Drinks', '-\$24.50', Colors.black),
            _itemTx(Icons.shopping_bag, const Color(0xFFFEE2E2), 'Style Haven', 'Shopping', '-\$89.00', Colors.black),
            _itemTx(Icons.savings, const Color(0xFFD1FAE5), 'Salary Deposit', 'Income', '+\$2,800.00', AppColors.darkGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildBalInfo(IconData icon, String title, String amount) {
    return Expanded(
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF86EFAC), shape: BoxShape.circle), child: Icon(icon, color: const Color(0xFF064E3B), size: 16)),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: AppColors.darkGreen, fontSize: 10, fontWeight: FontWeight.bold)), Text(amount, style: const TextStyle(color: Color(0xFF064E3B), fontSize: 16, fontWeight: FontWeight.bold))]),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String amount, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.grey)), const SizedBox(height: 12), Text(amount, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12))]),
    );
  }

  Widget _itemTx(IconData icon, Color bg, String title, String sub, String amount, Color amtCol) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.black87)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 13))])),
        Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: amtCol)),
      ]),
    );
  }
}