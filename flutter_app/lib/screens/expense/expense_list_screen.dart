import 'package:flutter/material.dart';

import '../../models/expense.dart';
import '../../services/expense_service.dart';
import '../../widgets/expense_card.dart';
import 'add_expense_screen.dart';
import 'edit_expense_screen.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() =>
      _ExpenseListScreenState();
}

class _ExpenseListScreenState
    extends State<ExpenseListScreen> {

  final ExpenseService expenseService =
      ExpenseService();

  final TextEditingController searchController =
      TextEditingController();

  List<Expense> expenses = [];

  List<Expense> filteredExpenses = [];

  bool loading = true;

  double totalExpense = 0;
  String selectedCategory = "ALL";
  String selectedPaymentMode = "ALL";

final List<String> categories = [

  "ALL",

  "LABOUR",

  "SEEDS",

  "FERTILIZER",

  "PESTICIDES",

  "FUEL",

  "MACHINERY",

  "TRANSPORTATION",

  "ELECTRICITY",

  "OTHER",

];
final List<String> paymentModes = [

  "ALL",

  "CASH",

  "UPI",

  "BANK_TRANSFER",

];

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {

    try {

      final result =
          await expenseService.getAll();

      setState(() {

        expenses = result;

        filteredExpenses = result;

        totalExpense = result.fold(
          0,
          (sum, item) => sum + item.amount,
        );

        loading = false;

      });

    } catch (e) {

      setState(() {
        loading = false;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(e.toString()),
        ),

      );

    }

  }
  Future<void> applyFilters() async {

  setState(() {
    loading = true;
  });

  try {

    final result = await expenseService.filterExpenses(

      category: selectedCategory,

      paymentMode: selectedPaymentMode,

    );

   setState(() {

  expenses = result;

  filteredExpenses = result;

  totalExpense = result.fold(
    0,
    (sum, item) => sum + item.amount,
  );

  loading = false;

});

search(searchController.text);

  } catch (e) {

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(e.toString()),
      ),

    );

  }

}

void search(String value) {

  setState(() {

    filteredExpenses = expenses.where((expense) {

      return expense.category
              .toLowerCase()
              .contains(value.toLowerCase()) ||

          expense.paymentMode
              .toLowerCase()
              .contains(value.toLowerCase()) ||

          (expense.description ?? "")
              .toLowerCase()
              .contains(value.toLowerCase());

    }).toList();

  });

}  

  Future<void> openAddExpense() async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const AddExpenseScreen(),

      ),

    );

    if (result == true) {

      loadExpenses();

    }

  }

  Future<void> openEditExpense(
      Expense expense) async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            EditExpenseScreen(
              expense: expense,
            ),

      ),

    );

    if (result == true) {

      loadExpenses();

    }

  }

  Future<void> deleteExpense(
      Expense expense) async {

    final confirm = await showDialog<bool>(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text(
          "Delete Expense",
        ),

        content: Text(
          "Delete ${expense.category} expense?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                context,
                false,
              );

            },

            child: const Text(
              "Cancel",
            ),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(
                context,
                true,
              );

            },

            child: const Text(
              "Delete",
            ),

          ),

        ],

      ),

    );

    if (confirm != true) return;

    await expenseService.deleteExpense(
      expense.id,
    );

    loadExpenses();

  }
    @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Expense Management",
        ),

      ),

      floatingActionButton: FloatingActionButton(

        onPressed: openAddExpense,

        child: const Icon(Icons.add),

      ),

      body: loading

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : RefreshIndicator(

              onRefresh: loadExpenses,

              child: Column(

                children: [

                  Card(

                    margin: const EdgeInsets.all(16),

                    elevation: 3,

                    child: Padding(

                      padding: const EdgeInsets.all(20),

                      child: Column(

                        children: [

                          const Text(

                            "Total Expenses",

                            style: TextStyle(
                              fontSize: 18,
                            ),

                          ),

                          const SizedBox(height: 10),

                          Text(

                            "₹${totalExpense.toStringAsFixed(2)}",

                            style: const TextStyle(

                              fontSize: 30,

                              fontWeight: FontWeight.bold,

                              color: Colors.red,

                            ),

                          ),

                        ],

                      ),

                    ),

                  ),

Padding(

  padding: const EdgeInsets.symmetric(
    horizontal: 16,
  ),

  child: TextField(

    controller: searchController,

    onChanged: search,

    decoration: InputDecoration(

      hintText: "Search Expense",

      prefixIcon: const Icon(Icons.search),

      border: OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(12),

      ),

    ),

  ),

),

const SizedBox(height: 10),

Padding(

  padding: const EdgeInsets.symmetric(
    horizontal: 16,
  ),

  child: DropdownButtonFormField<String>(

    value: selectedCategory,

    decoration: const InputDecoration(

      labelText: "Category",

      border: OutlineInputBorder(),

    ),

    items: categories.map((category) {

      return DropdownMenuItem<String>(

        value: category,

        child: Text(category),

      );

    }).toList(),

    onChanged: (value) async {

      setState(() {

        selectedCategory = value!;

      });

      await applyFilters();

    },

  ),

),

const SizedBox(height: 10),

Padding(

  padding: const EdgeInsets.symmetric(
    horizontal: 16,
  ),

  child: DropdownButtonFormField<String>(

    value: selectedPaymentMode,

    decoration: const InputDecoration(

      labelText: "Payment Mode",

      border: OutlineInputBorder(),

    ),

    items: paymentModes.map((mode) {

      return DropdownMenuItem<String>(

        value: mode,

        child: Text(mode),

      );

    }).toList(),

    onChanged: (value) async {

      setState(() {

        selectedPaymentMode = value!;

      });

      await applyFilters();

    },

  ),

),

const SizedBox(height: 10),

Expanded(

  child: filteredExpenses.isEmpty

                        ? ListView(

                            children: const [

                              SizedBox(height: 200),

                              Center(

                                child: Text(

                                  "No Expenses Found",

                                  style: TextStyle(
                                    fontSize: 18,
                                  ),

                                ),

                              ),

                            ],

                          )

                        : ListView.builder(

                            itemCount:
                                filteredExpenses.length,

                            itemBuilder:
                                (context, index) {

                              final expense =
                                  filteredExpenses[index];

                              return ExpenseCard(

                                expense: expense,

                                onEdit: () {

                                  openEditExpense(
                                    expense,
                                  );

                                },

                                onDelete: () {

                                  deleteExpense(
                                    expense,
                                  );

                                },

                              );

                            },

                          ),

                  ),

                ],

              ),

            ),

    );

  }

}