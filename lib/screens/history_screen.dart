import 'package:flutter/material.dart';

import '../models/refill.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/arrow_card.dart';
import 'add_refill_screen.dart';
import 'refill_detail_screen.dart';
import 'statistics_screen.dart';

class HistoryScreen extends StatefulWidget {
  final List<Refill> refills;
  final String unit;
  final VoidCallback? onChanged;

  const HistoryScreen({
    super.key,
    required this.refills,
    required this.unit,
    this.onChanged,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<void> _addRefill() async {
    final created = await Navigator.push<Refill>(
      context,
      MaterialPageRoute(
        builder: (_) => AddRefillScreen(unit: widget.unit),
      ),
    );
    if (created == null || !mounted) return;
    setState(() {
      widget.refills.add(created);
      widget.refills.sort((a, b) => b.date.compareTo(a.date));
    });
    widget.onChanged?.call();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Refill added successfully')),
    );
  }

  Future<void> _editRefill(int index) async {
    final updated = await Navigator.push<Refill>(
      context,
      MaterialPageRoute(
        builder: (_) => AddRefillScreen(
          unit: widget.unit,
          initialRefill: widget.refills[index],
        ),
      ),
    );
    if (updated == null || !mounted) return;
    setState(() {
      widget.refills[index] = updated;
      widget.refills.sort((a, b) => b.date.compareTo(a.date));
    });
    widget.onChanged?.call();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Refill updated successfully')),
    );
  }

  Future<void> _deleteRefill(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete refill?'),
        content: const Text('This refill will be removed from your history.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    setState(() => widget.refills.removeAt(index));
    widget.onChanged?.call();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Refill deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('History'),
        actions: [
          IconButton(
            tooltip: 'Add refill',
            onPressed: _addRefill,
            icon: const Icon(Icons.add),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.refills.isEmpty
                ? const Center(child: Text('No refills yet'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    itemCount: widget.refills.length,
                    itemBuilder: (context, index) {
                      final refill = widget.refills[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ArrowCard(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RefillDetailScreen(
                                refill: refill,
                                unit: widget.unit,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  size: 30),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shortDate(refill.date),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${refill.liters} ${widget.unit}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Edit refill',
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () => _editRefill(index),
                              ),
                              IconButton(
                                tooltip: 'Delete refill',
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteRefill(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.plum,
                    foregroundColor: AppColors.onDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(color: Colors.black),
                    ),
                    textStyle: AppTheme.buttonText(24),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StatisticsScreen(
                        refills: widget.refills,
                        unit: widget.unit,
                      ),
                    ),
                  ),
                  child: const Text('View Statistics'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
