import 'package:flutter/material.dart';

class ProfitCard extends StatelessWidget {

  final double revenue;
  final double expense;
  final double profit;

  const ProfitCard({

    super.key,

    required this.revenue,

    required this.expense,

    required this.profit,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20),

      ),

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "Financial Overview",

              style: TextStyle(

                fontSize: 20,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 20),

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                Column(

                  children: [

                    const Text("Revenue"),

                    const SizedBox(height: 8),

                    Text(

                      "₹${revenue.toStringAsFixed(0)}",

                      style: const TextStyle(

                        color: Colors.green,

                        fontWeight: FontWeight.bold,

                        fontSize: 18,

                      ),

                    ),

                  ],

                ),

                Column(

                  children: [

                    const Text("Expense"),

                    const SizedBox(height: 8),

                    Text(

                      "₹${expense.toStringAsFixed(0)}",

                      style: const TextStyle(

                        color: Colors.red,

                        fontWeight: FontWeight.bold,

                        fontSize: 18,

                      ),

                    ),

                  ],

                ),

                Column(

                  children: [

                    const Text("Profit"),

                    const SizedBox(height: 8),

                    Text(

                      "₹${profit.toStringAsFixed(0)}",

                      style: const TextStyle(

                        color: Colors.blue,

                        fontWeight: FontWeight.bold,

                        fontSize: 18,

                      ),

                    ),

                  ],

                ),

              ],

            )

          ],

        ),

      ),

    );

  }

}