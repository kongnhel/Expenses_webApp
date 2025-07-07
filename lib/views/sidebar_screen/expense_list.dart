import 'package:expense_dashboard/api/getApi.dart';
import 'package:expense_dashboard/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  static const String id = 'expense-list';

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel) onEdit;
  final void Function(ExpenseModel)? onDelete;
  final VoidCallback? onDeleteAll;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onEdit,
    this.onDelete,
    this.onDeleteAll,
  });

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  ExpenseModel? _pendingDelete;
  bool _isDeleting = false;

  Future<void> _confirmDelete(
    BuildContext context,
    ExpenseModel expense,
  ) async {
    if (_isDeleting) return;
    final id = expense.id;

    if (id == null || id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid ID — cannot delete')),
      );
      return;
    }

    _pendingDelete = expense;
    _isDeleting = true;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    bool isUndoPressed = false;

    scaffoldMessenger
        .showSnackBar(
          SnackBar(
            content: Text('Deleted ${expense.categories}'),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                isUndoPressed = true;
                scaffoldMessenger.hideCurrentSnackBar();
              },
            ),
          ),
        )
        .closed
        .then((reason) async {
          if (_pendingDelete != null && !isUndoPressed) {
            try {
              await deleteExpense(id);
              if (widget.onDelete != null) {
                widget.onDelete!(_pendingDelete!);
              }
            } catch (e) {
              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text('Delete failed: ${e.toString()}')),
              );
            }
          }
          _pendingDelete = null;
          _isDeleting = false;
        });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty) {
      return const Center(
        child: Text(
          'No expenses found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.delete_forever),
            label: const Text('Delete All Expenses'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 239, 42, 42),
            ),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Confirm Delete All'),
                  content: const Text(
                    'Are you sure you want to delete all expenses?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                if (widget.onDeleteAll != null) {
                  widget.onDeleteAll!();
                }
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: widget.expenses.length,
            itemBuilder: (context, index) {
              final expense = widget.expenses[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: Text(
                    expense.categories,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 49, 65, 215),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        'Amount: \$${double.tryParse(expense.amount)?.toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Date: ${expense.date}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      if (expense.note != null && expense.note!.isNotEmpty)
                        Text(
                          'Note: ${expense.note}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () => widget.onEdit(expense),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(context, expense),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
