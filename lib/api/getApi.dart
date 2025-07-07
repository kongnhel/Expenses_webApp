import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/expense_model.dart';

Future<void> deleteExpense(String id) async {
  // final url = Uri.parse('https://localhost:7209/api/Expense/$id');
  final url = Uri.parse(
    'https://expenses-api-re4p.onrender.com/DeleteExpenses/$id',
  );
  // final url = Uri.parse('http://192.168.89.179:3000/DeleteExpenses/$id');
  print('Deleting expense with ID: $id'); // Debug log
  final response = await http.delete(url);

  if (response.statusCode == 204 || response.statusCode == 200) {
    print('Expense deleted successfully: $id');
    return; // Success, no content or OK
  } else if (response.statusCode == 404) {
    print('Error: Expense with ID $id not found - ${response.body}');
    throw Exception(
      'Expense not found: ${response.statusCode} - ${response.body}',
    );
  } else {
    print(
      'Error response: ${response.statusCode} - ${response.body}',
    ); // Debug log
    throw Exception(
      'Failed to delete expense: ${response.statusCode} - ${response.body}',
    );
  }
}

Future<List<ExpenseModel>> getExpenses() async {
  // var url = Uri.parse("https://localhost:7209/api/Expense");
  var url = Uri.parse("https://expenses-api-re4p.onrender.com/getExpenses");
  // var url = Uri.parse("http://10.10.14.105:3000/getExpenses");
  // var url = Uri.parse("http://192.168.89.179:3000/getExpenses");

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => ExpenseModel.fromJson(e)).toList();
    } else {
      throw Exception("កំហុស: ${response.statusCode}");
    }
  } catch (e) {
    print("⚠️ Error: $e");
    rethrow;
  }
}

Future<void> deleteAllExpenses() async {
  final url = Uri.parse(
    'https://expenses-api-re4p.onrender.com/DeleteAllExpenses',
    // 'http://10.10.14.105:3000/DeleteAllExpenses',
    // 'http://192.168.89.179:3000/DeleteAllExpenses',
  ); // Match your Express route
  final response = await http.delete(url);

  if (response.statusCode != 200) {
    throw Exception('Failed to delete all expenses: ${response.statusCode}');
  }
}
