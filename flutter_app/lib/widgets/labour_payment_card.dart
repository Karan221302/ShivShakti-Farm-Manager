import 'package:flutter/material.dart';

import '../models/labour_payment.dart';

class LabourPaymentCard extends StatelessWidget {

  final LabourPayment payment;

  final VoidCallback? onEdit;

  final VoidCallback? onDelete;

  const LabourPaymentCard({

    super.key,

    required this.payment,

    this.onEdit,

    this.onDelete,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

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

                  child: Icon(Icons.person),

                ),

                const SizedBox(width: 12),

                Expanded(

                  child: Text(

                    payment.labourName,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                ),

                Text(

                  "₹${payment.amount.toStringAsFixed(0)}",

                  style: const TextStyle(

                    color: Colors.green,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

              ],

            ),

            const SizedBox(height: 10),

            Text(
              "📅 ${payment.paymentDate}",
            ),

            Text(
              "💳 ${payment.paymentMode}",
            ),

            if (payment.remarks != null &&
                payment.remarks!.isNotEmpty)

              Text(
                "📝 ${payment.remarks}",
              ),

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

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red,
                  ),

                  onPressed: onDelete,

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

            ),

          ],

        ),

      ),

    );

  }

}