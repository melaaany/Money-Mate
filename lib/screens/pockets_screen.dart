import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PocketsScreen extends StatefulWidget {
  const PocketsScreen({super.key});

  @override
  State<PocketsScreen> createState() => _PocketsScreenState();
}

class _PocketsScreenState extends State<PocketsScreen> {
  // Data statis yang sekarang diubah menjadi List dinamis agar bisa ditambah
  List<Map<String, dynamic>> pockets = [
    {'title': 'Emergency Fund', 'saved': 8000.0, 'target': 10000.0, 'icon': Icons.medical_services, 'iconBg': AppColors.primary, 'progCol': AppColors.primary},
    {'title': 'New MacBook Pro', 'saved': 1850.0, 'target': 2499.0, 'icon': Icons.laptop_mac, 'iconBg': AppColors.lightGreen, 'progCol': AppColors.darkGreen},
  ];

  // Fungsi untuk menampilkan Pop-up Form Tambah Pocket
  void _showAddPocketDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController targetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Create New Pocket', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Pocket Name (e.g. Vacation)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: targetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Target Amount (\$)', border: OutlineInputBorder(), prefixText: '\$ '),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGreen),
              onPressed: () {
                if (titleController.text.isNotEmpty && targetController.text.isNotEmpty) {
                  // Tambahkan data ke dalam list dan perbarui UI
                  setState(() {
                    pockets.add({
                      'title': titleController.text,
                      'saved': 0.0, // Saldo awal 0
                      'target': double.parse(targetController.text),
                      'icon': Icons.savings, // Ikon default
                      'iconBg': AppColors.lightGreen,
                      'progCol': AppColors.darkGreen,
                    });
                  });
                  Navigator.pop(context); // Tutup dialog
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total tabungan secara otomatis dari data list
    double totalSavings = pockets.fold(0, (sum, item) => sum + item['saved']);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkGreen,
        onPressed: _showAddPocketDialog, // Panggil fungsi dialog saat diklik
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Text('My Pockets', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Total\nSavings:', style: TextStyle(color: Colors.black54)),
              const SizedBox(width: 12),
              Text('\$${totalSavings.toStringAsFixed(2)}', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.darkGreen)),
            ],
          ),
          const SizedBox(height: 24),

          // Me-*render* daftar pocket menggunakan perulangan map
          ...pockets.map((pocket) {
            double progress = pocket['saved'] / pocket['target'];
            return _buildPocketCard(
                pocket['icon'], pocket['iconBg'], pocket['title'],
                '\$${pocket['saved']} / \$${pocket['target']}',
                progress, pocket['progCol']
            );
          }).toList(),

          const SizedBox(height: 80), // Jarak untuk Floating Action Button
        ],
      ),
    );
  }

  Widget _buildPocketCard(IconData icon, Color iconBg, String title, String amt, double progress, Color progCol) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16), elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.black87)), const Icon(Icons.more_vert, color: Colors.grey)]),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(amt), Text('${(progress * 100).toInt()}%', style: TextStyle(color: progCol, fontWeight: FontWeight.bold))]),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation<Color>(progCol), minHeight: 12, borderRadius: BorderRadius.circular(8)),
          ],
        ),
      ),
    );
  }
}