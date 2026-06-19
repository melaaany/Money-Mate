import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SpendingScreen extends StatelessWidget {
  const SpendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('My Spending', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Analyze your habits and optimize your growth.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)), child: const Text('Insight of the Month', style: TextStyle(fontSize: 10, color: Color(0xFF064E3B)))), const SizedBox(height: 12), const Text('Great job!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF064E3B))), const Text('You spent 10% less on Entertainment this month!', style: TextStyle(color: Color(0xFF064E3B)))])),
                Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF86EFAC), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.trending_down, color: Color(0xFF064E3B), size: 32)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0, shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Category Spending', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(width: 180, height: 180, child: CircularProgressIndicator(value: 1.0, color: AppColors.primary, strokeWidth: 20)),
                        SizedBox(width: 180, height: 180, child: CircularProgressIndicator(value: 0.6, color: AppColors.darkGreen, strokeWidth: 20)),
                        SizedBox(width: 180, height: 180, child: CircularProgressIndicator(value: 0.15, color: Colors.yellow, strokeWidth: 20)),
                        Column(children: const [Text('TOTAL', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)), Text('\$2,840', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}