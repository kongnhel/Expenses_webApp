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

  Widget _selectedScreen = DashboardPage(expenses: []);

  @override
  void initState() {
    super.initState();
    _loadExpensesForDashboard();
  }

  Future<List<ExpenseModel>> fetchExpensesOnly() async {
    return await getExpenses();
  }

  Future<void> _loadExpensesForDashboard() async {
    setState(() {
      _isLoading = true;
      _selectedScreen = const Center(child: CircularProgressIndicator());
    });

    try {
      final data = await fetchExpensesOnly();
      setState(() {
        _expenses = data;
        _isLoading = false;
        _selectedScreen = DashboardPage(expenses: _expenses);
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
        // your edit logic
      },
      onDelete: (expense) {
        setState(() {
          _expenses.removeWhere((e) => e.id == expense.id);
          _selectedScreen = _buildExpenseList();
        });
      },
      onDeleteAll: () {
        _removeAllExpenses();
      },
    );
  }

  Future<void> _removeAllExpenses() async {
    final originalExpenses = [..._expenses];
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
                isUndo = true;
                setState(() {
                  _expenses = originalExpenses;
                  _selectedScreen = _buildExpenseList();
                });
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
        _loadExpensesForDashboard();
        break;

      case ExpenseList.id:
        setState(() {
          _selectedScreen = const Center(child: CircularProgressIndicator());
        });
        fetchExpensesOnly()
            .then((data) {
              setState(() {
                _expenses = data;
                _selectedScreen = _buildExpenseList();
              });
            })
            .catchError((e) {
              setState(() {
                _selectedScreen = Center(
                  child: Text('Error loading expenses: $e'),
                );
              });
            });
        break;

      case FormAddData.id:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormAddData()),
        ).then((result) {
          if (result == true) {
            _loadExpensesForDashboard();
          }
        });
        break;

      default:
        _loadExpensesForDashboard();
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
      ),
      sideBar: SideBar(
        selectedRoute: DashboardPage.id,
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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _selectedScreen,
      ),
    );
  }
}
