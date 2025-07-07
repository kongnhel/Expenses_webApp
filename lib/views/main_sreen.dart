import 'package:expense_dashboard/api/getApi.dart';
import 'package:expense_dashboard/model/expense_model.dart';
import 'package:expense_dashboard/views/sidebar_screen/add_data.dart';
import 'package:expense_dashboard/views/sidebar_screen/expense_list.dart';
import 'package:expense_dashboard/views/sidebar_screen/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ExpenseModel> _expenses = [];
  bool _isLoading = true;
  String? _error;
  Widget _selectedScreen = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();
    _loadExpensesFromApi();
  }

  Future<void> _loadExpensesFromApi() async {
    try {
      final data = await getExpenses();
      setState(() {
        _expenses = data;
        _isLoading = false;
        _selectedScreen = _buildExpenseList();
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
        _selectedScreen = Center(child: Text('Problem: $_error'));
      });
    }
  }

  Widget _buildExpenseList() {
    return ExpenseList(
      expenses: _expenses,
      onEdit: (expense) {
        // TODO: Implement editing if needed
      },
      onDelete: (expense) {
        setState(() {
          _expenses.removeWhere((e) => e.id == expense.id);
          _selectedScreen = _buildExpenseList();
        });
      },
    );
  }

  Future<void> _removeAllExpenses() async {
    final originalExpenses = [..._expenses]; // backup before delete

    setState(() {
      _expenses.clear();
      _selectedScreen = _buildExpenseList();
    });

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    bool isUndo = false;

    scaffoldMessenger
        .showSnackBar(
          SnackBar(
            content: const Text('All expenses deleted'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _expenses = originalExpenses;
                  _selectedScreen = _buildExpenseList();
                });
                isUndo = true;
              },
            ),
          ),
        )
        .closed
        .then((reason) async {
          if (!isUndo) {
            try {
              await deleteAllExpenses();
            } catch (e) {
              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text('Failed to delete: $e')),
              );
            }
          }
        });
  }

  void screenSelector(String route) {
    switch (route) {
      case DashboardPage.id:
        setState(() {
          _selectedScreen = DashboardPage();
        });
        break;
      case ExpenseList.id:
        setState(() {
          _selectedScreen = _buildExpenseList();
        });
        break;
      case FormAddData.id:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormAddData()),
        ).then((result) {
          if (result == true) {
            _loadExpensesFromApi(); // ✅ Refresh expense list
            setState(() {
              _selectedScreen = _buildExpenseList(); // ✅ Show list again
            });
          }
        });
        break;

      default:
        setState(() {
          _selectedScreen = DashboardPage();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 61, 247),
        title: const Text(
          'Expense Management',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Image.asset("assets/images/trash.png", width: 25, height: 25),
            onPressed: () {
              if (_expenses.isNotEmpty) {
                _removeAllExpenses();
              }
            },
          ),
        ],
      ),
      sideBar: SideBar(
        selectedRoute: ExpenseList.id,
        onSelected: (item) => screenSelector(item.route ?? ''),
        items: const [
          AdminMenuItem(
            title: 'Home',
            route: DashboardPage.id,
            icon: CupertinoIcons.home,
          ),
          AdminMenuItem(
            title: 'Expense List',
            route: ExpenseList.id,
            icon: CupertinoIcons.list_bullet,
          ),
          AdminMenuItem(
            title: 'Add Expense',
            route: FormAddData.id,
            icon: CupertinoIcons.add,
          ),
        ],
      ),
      body: _selectedScreen,
    );
  }
}
