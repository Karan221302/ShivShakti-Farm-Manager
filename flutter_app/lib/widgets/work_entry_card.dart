import 'package:flutter/material.dart';

import '../models/work_entry.dart';

class WorkEntryCard extends StatelessWidget {
  final WorkEntry workEntry;

  final VoidCallback? onEdit;

  final VoidCallback? onDelete;

  const WorkEntryCard({
    super.key,
    required this.workEntry,
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
                  child: Icon(Icons.person),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    workEntry.labourName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  "₹${workEntry.wageAmount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 12),

            Text("📅 ${workEntry.workDate}"),
            Text("🌾 ${workEntry.workType}"),
            Text("🕐 ${workEntry.manday}"),

            if (workEntry.remarks != null &&
                workEntry.remarks!.isNotEmpty)
              Text("📝 ${workEntry.remarks}"),

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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
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