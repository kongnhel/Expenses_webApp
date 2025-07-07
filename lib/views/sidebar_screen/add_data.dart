import 'package:expense_dashboard/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class FormAddData extends StatefulWidget {
  static const String id = 'form-add-data';

  final void Function(ExpenseModel newExpense)? onAdd;
  final VoidCallback? onSave;

  const FormAddData({Key? key, this.onAdd, this.onSave}) : super(key: key);

  @override
  State<FormAddData> createState() => _FormAddDataState();
}

class _FormAddDataState extends State<FormAddData> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _amount;
  String? _note;
  DateTime? _selectedDate;

  final List<String> _categories = [
    'Food',
    'Transport',
    'Bills',
    'Drinks',
    'Game',
    'Travel',
    'Donations',
    'School',
    'Others',
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      _formKey.currentState!.save();

      try {
        var url = Uri.parse(
          "https://expenses-api-re4p.onrender.com/addExpenses",
        );
        // var url = Uri.parse("http://192.168.89.179:3000/addExpenses");
        final tempExpense = ExpenseModel(
          categories: _selectedCategory!,
          amount: _amount!,
          note: _note ?? '',
          date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
        );
        var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(tempExpense.toJson()),
        );

        if (response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          final newExpense = ExpenseModel(
            id: responseData['id'],
            categories: _selectedCategory!,
            amount: _amount!,
            note: _note ?? '',
            date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
          );

          // Callbacks to update parent
          widget.onAdd?.call(newExpense);
          widget.onSave?.call();
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ Error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('⚠️ Connection error: $e')));
      }
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a date')));
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _selectedDate == null
        ? 'Pick Date'
        : DateFormat.yMMMd().format(_selectedDate!);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) => _selectedCategory = val,
                validator: (val) => val == null ? 'Choose a category' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter amount' : null,
                onSaved: (val) => _amount = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Note'),
                keyboardType: TextInputType.text,
                onSaved: (val) => _note = val ?? '',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(dateText),
                  const Spacer(),
                  IconButton(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today),
                    tooltip: 'Expense Date',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
