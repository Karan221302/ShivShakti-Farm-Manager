import 'package:flutter/material.dart';

import '../models/harvest.dart';

class HarvestCard extends StatelessWidget {

  final Harvest harvest;

  final VoidCallback? onEdit;

  final VoidCallback? onDelete;

  const HarvestCard({

    super.key,

    required this.harvest,

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

                  child: Icon(Icons.grass),

                ),

                const SizedBox(width: 12),

                Expanded(

                  child: Text(

                    harvest.cropName,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                ),

                Text(

                  "₹${harvest.revenue.toStringAsFixed(0)}",

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
                "📅 ${harvest.harvestDate}"),

            Text(
                "⚖ ${harvest.quantity} ${harvest.unit}"),

            Text(
                "💰 ₹${harvest.rate}/unit"),

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