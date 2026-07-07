import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {

  final Expense expense;

  final VoidCallback? onEdit;

  final VoidCallback? onDelete;

  const ExpenseCard({

    super.key,

    required this.expense,

    this.onEdit,

    this.onDelete,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                const CircleAvatar(

                  child: Icon(Icons.money_off),

                ),

                const SizedBox(width: 12),

                Expanded(

                  child: Text(

                    expense.category,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                ),

                Text(

                  "₹${expense.amount.toStringAsFixed(0)}",

                  style: const TextStyle(

                    color: Colors.red,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

              ],

            ),

            const SizedBox(height: 12),

            Text("📅 ${expense.expenseDate}"),

            Text("💳 ${expense.paymentMode}"),

            if (expense.description != null &&
                expense.description!.isNotEmpty)

              Text("📝 ${expense.description}"),

            const SizedBox(height: 16),

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.end,

              children: [

                OutlinedButton.icon(

                  onPressed: onEdit,

                  icon: const Icon(Icons.edit),

                  label: const Text("Edit"),

                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(

                  onPressed: onDelete,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red,
                  ),

                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),

                  label: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                ),

              ],

            )

          ],

        ),

      ),

    );

  }

}