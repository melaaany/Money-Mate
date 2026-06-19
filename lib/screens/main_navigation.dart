import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';
import 'transactions_screen.dart';
import 'pockets_screen.dart';
import 'split_bill_screen.dart';
import 'spending_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TransactionsScreen(),
    const PocketsScreen(),
    const SplitBillScreen(),
    const SpendingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.darkGreen,
        unselectedItemColor: AppColors.textLight,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(icon: _buildIcon(Icons.home_outlined, 0), label: 'Home'),
          BottomNavigationBarItem(icon: _buildIcon(Icons.receipt_long_outlined, 1), label: 'Transactions'),
          BottomNavigationBarItem(icon: _buildIcon(Icons.account_balance_wallet_outlined, 2), label: 'Pockets'),
          BottomNavigationBarItem(icon: _buildIcon(Icons.people_outline, 3), label: 'Split Bill'),
          BottomNavigationBarItem(icon: _buildIcon(Icons.person_outline, 4), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    bool isActive = _currentIndex == index;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.lightGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: isActive ? AppColors.darkGreen : AppColors.textLight),
    );
  }
}