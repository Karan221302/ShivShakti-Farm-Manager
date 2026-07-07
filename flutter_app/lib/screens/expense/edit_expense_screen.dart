import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/expense.dart';
import '../../services/expense_service.dart';

class EditExpenseScreen extends StatefulWidget {

  final Expense expense;

  const EditExpenseScreen({
    super.key,
    required this.expense,
  });

  @override
  State<EditExpenseScreen> createState() =>
      _EditExpenseScreenState();
}

class _EditExpenseScreenState
    extends State<EditExpenseScreen> {

  final ExpenseService expenseService =
      ExpenseService();

  final amountController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  late DateTime expenseDate;

  late String category;

  late String paymentMode;

  bool saving = false;

  final List<String> categories = [
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

    "CASH",
    "UPI",
    "BANK_TRANSFER"

  ];

  @override
  void initState() {

    super.initState();

    amountController.text =
        widget.expense.amount.toString();

    descriptionController.text =
        widget.expense.description ?? "";

    expenseDate =
        DateTime.parse(
            widget.expense.expenseDate);

    category =
        widget.expense.category;

    paymentMode =
        widget.expense.paymentMode;

  }

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

  Future<void> updateExpense() async {

    setState(() {

      saving = true;

    });

    await expenseService.updateExpense(

      id: widget.expense.id,

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

  }
    @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Edit Expense",
        ),

      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            ListTile(

              shape: RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(10),

                side: const BorderSide(),

              ),

              title: Text(

                DateFormat("dd MMM yyyy")
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

            DropdownButtonFormField<String>(

              value: category,

              decoration:
                  const InputDecoration(

                labelText: "Category",

                border:
                    OutlineInputBorder(),

              ),

              items: categories.map((item) {

                return DropdownMenuItem<String>(

                  value: item,

                  child: Text(item),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  category = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(

              value: paymentMode,

              decoration:
                  const InputDecoration(

                labelText: "Payment Mode",

                border:
                    OutlineInputBorder(),

              ),

              items: paymentModes.map((item) {

                return DropdownMenuItem<String>(

                  value: item,

                  child: Text(item),

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

                labelText: "Description",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 30),

            SizedBox(

              height: 50,

              child: ElevatedButton(

                onPressed:
                    saving ? null : updateExpense,

                child: saving

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Update Expense",
                      ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}