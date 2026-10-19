import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';

class AddRefillScreen extends StatefulWidget {
  final String unit;

  const AddRefillScreen({super.key, required this.unit});

  @override
  State<AddRefillScreen> createState() => _AddRefillScreenState();
}

class _AddRefillScreenState extends State<AddRefillScreen> {
  final TextEditingController _litersController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stationController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _litersController.dispose();
    _priceController.dispose();
    _stationController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  void _save() {
    final litersText = _litersController.text.trim().replaceAll(',', '.');
    final priceText = _priceController.text.trim();
    final station = _stationController.text.trim();

    if (litersText.isEmpty || priceText.isEmpty) {
      _showMessage('Please fill in the amount and the price');
      return;
    }

    final liters = double.tryParse(litersText);
    final price = int.tryParse(priceText);

    if (liters == null || liters <= 0) {
      _showMessage('Amount must be a number bigger than 0');
    } else if (price == null || price <= 0) {
      _showMessage('Price must be a whole number bigger than 0');
    } else {
      Navigator.pop(
        context,
        Refill(
          date: _date,
          liters: liters,
          price: price,
          station: station.isEmpty ? 'Unknown station' : station,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('Add Refill'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Label('Date'),
            Material(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text(longDate(_date)),
                trailing: const Icon(Icons.edit_calendar),
                onTap: _pickDate,
              ),
            ),
            const SizedBox(height: 20),
            _Label('Amount (${widget.unit})'),
            TextField(
              controller: _litersController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'e.g. 3.5',
                prefixIcon: Icon(Icons.local_gas_station_outlined),
              ),
            ),
            const SizedBox(height: 20),
            const _Label('Price (Rp)'),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'e.g. 35000',
                prefixIcon: Icon(Icons.payments_outlined),
              ),
            ),
            const SizedBox(height: 20),
            const _Label('Gas station (optional)'),
            TextField(
              controller: _stationController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'e.g. Pertamina Jl. Sudirman',
                prefixIcon: Icon(Icons.place_outlined),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 60,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.plum,
                  foregroundColor: AppColors.onDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: AppTheme.buttonText(22),
                ),
                onPressed: _save,
                child: const Text('Save refill'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }
}
