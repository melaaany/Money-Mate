import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SplitBillScreen extends StatefulWidget {
  const SplitBillScreen({super.key});

  @override
  State<SplitBillScreen> createState() => _SplitBillScreenState();
}

class _SplitBillScreenState extends State<SplitBillScreen> {
  // State data untuk menyimpan informasi bill secara dinamis
  double _totalAmount = 124.50;
  String _billTitle = "Dinner Party";
  bool _splitEqually = true;

  // Daftar partisipan awal
  final List<String> _participants = ['Me', 'Sarah M.', 'Leo'];

  // Fungsi untuk menampilkan Pop-up input tagihan baru
  void _showNewSplitDialog() {
    final titleController = TextEditingController(text: _billTitle);
    final amountController = TextEditingController(text: _totalAmount.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Start New Split', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Event / Bill Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Total Amount (\$)', border: OutlineInputBorder(), prefixText: '\$ '),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGreen),
              onPressed: () {
                if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                  setState(() {
                    _billTitle = titleController.text;
                    _totalAmount = double.parse(amountController.text);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Create', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan Pop-up tambah teman
  void _showAddParticipantDialog() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Add Participant', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: "Friend's Name", border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGreen),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    _participants.add(nameController.text);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung otomatis pembagian per orang
    double perPersonAmount = _totalAmount / _participants.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        title: const Text('Split Bill', style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner teks utama
          Container(
            height: 100,
            decoration: BoxDecoration(color: AppColors.lightGreen, borderRadius: BorderRadius.circular(24)),
            alignment: Alignment.center,
            child: const Text('Fair sharing, zero stress.', style: TextStyle(fontSize: 18, color: AppColors.darkGreen, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),

          // Card Detail Event Aktif
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_billTitle, style: const TextStyle(color: AppColors.darkGreen, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Total Bill: \$${_totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGreen, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                      label: const Text('Modify / New Split', style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: _showNewSplitDialog, // Trigger ganti bill
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Header Row Partisipan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Participants', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.lightGreen, borderRadius: BorderRadius.circular(12)),
                  child: Text('${_participants.length} People', style: const TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold))
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Card List Avatar Partisipan (Horizontal Scrollable)
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Tombol statis khusus untuk menambah partisipan baru
                    GestureDetector(
                      onTap: _showAddParticipantDialog,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          children: [
                            CircleAvatar(radius: 24, backgroundColor: Colors.blue.shade50, child: const Icon(Icons.add, color: AppColors.darkGreen)),
                            const SizedBox(height: 8),
                            const Text('Add Friend', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.darkGreen)),
                          ],
                        ),
                      ),
                    ),
                    // Loop daftar nama teman dari List _participants
                    ..._participants.map((name) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: name == 'Me' ? AppColors.primary : Colors.grey.shade300,
                            child: Text(name[0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          const SizedBox(height: 8),
                          Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Card Hasil Pembagian Nominal
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Split equally', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        Switch(
                            value: _splitEqually,
                            activeColor: AppColors.darkGreen,
                            onChanged: (value) {
                              setState(() {
                                _splitEqually = value;
                              });
                            }
                        )
                      ]
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text('EACH PERSON OWES:', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                  const SizedBox(height: 4),
                  Text(
                      _splitEqually ? '\$ ${perPersonAmount.toStringAsFixed(2)}' : 'Custom Split Mode',
                      style: const TextStyle(fontSize: 28, color: AppColors.darkGreen, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}