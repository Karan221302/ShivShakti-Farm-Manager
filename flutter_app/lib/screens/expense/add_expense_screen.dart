import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/expense_service.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() =>
      _AddExpenseScreenState();
}

class _AddExpenseScreenState
    extends State<AddExpenseScreen> {

  final ExpenseService expenseService =
      ExpenseService();

  final amountController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  DateTime expenseDate = DateTime.now();

  bool saving = false;

  String category = "FUEL";

  String paymentMode = "CASH";

  final List<String> categories = [

    "FUEL",
    "FERTILIZER",
    "SEEDS",
    "LABOUR",
    "EQUIPMENT",
    "TRANSPORT",
    "ELECTRICITY",
    "WATER",
    "OTHER"

  ];

  final List<String> paymentModes = [

    "CASH",

    "UPI",

    "BANK_TRANSFER"

  ];

  Future<void> pickDate() async {

    final picked =
        await showDatePicker(

      context: context,

      initialDate: expenseDate,

      firstDate: DateTime(2024),

      lastDate: DateTime(2035),

    );

    if (picked != null) {

      setState(() {

        expenseDate = picked;

      });

    }

  }

  Future<void> saveExpense() async {

    if (amountController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Enter Amount"),

        ),

      );

      return;

    }

    setState(() {

      saving = true;

    });

    try {

      await expenseService.addExpense(

        expenseDate:
            DateFormat("yyyy-MM-dd")
                .format(expenseDate),

        amount:
            double.parse(
                amountController.text),

        category: category,

        paymentMode: paymentMode,

        description:
            descriptionController.text,

      );

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),

        ),

      );

    }

    if (mounted) {

      setState(() {

        saving = false;

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Add Expense",
        ),

      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            ListTile(

              title: Text(

                DateFormat(
                        "dd MMM yyyy")
                    .format(expenseDate),

              ),

              trailing: const Icon(
                Icons.calendar_month,
              ),

              onTap: pickDate,

            ),

            const SizedBox(height: 20),

            TextField(

              controller: amountController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(

                labelText: "Amount",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(

              value: category,

              decoration:
                  const InputDecoration(

                labelText: "Category",

                border:
                    OutlineInputBorder(),

              ),

              items: categories.map((e) {

                return DropdownMenuItem(

                  value: e,

                  child: Text(e),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  category = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(

              value: paymentMode,

              decoration:
                  const InputDecoration(

                labelText:
                    "Payment Mode",

                border:
                    OutlineInputBorder(),

              ),

              items: paymentModes.map((e) {

                return DropdownMenuItem(

                  value: e,

                  child: Text(e),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  paymentMode = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            TextField(

              controller:
                  descriptionController,

              maxLines: 3,

              decoration:
                  const InputDecoration(

                labelText:
                    "Description",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 30),

            SizedBox(

              height: 50,

              child: ElevatedButton(

                onPressed:
                    saving ? null : saveExpense,

                child: saving

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Save Expense",
                      ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}