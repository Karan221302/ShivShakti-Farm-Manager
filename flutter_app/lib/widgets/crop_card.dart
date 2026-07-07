import 'package:flutter/material.dart';

import '../models/crop.dart';

class CropCard extends StatelessWidget {

  final Crop crop;

  final VoidCallback? onEdit;

  final VoidCallback? onDelete;

  const CropCard({

    super.key,

    required this.crop,

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

                    crop.cropName,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                ),

              ],

            ),

            const SizedBox(height: 10),

            Text("🌱 Variety: ${crop.variety}"),

            Text("📅 Sowing: ${crop.sowingDate}"),

            Text(
              "🌾 Harvest: ${crop.expectedHarvestDate}",
            ),

            if (crop.notes != null &&
                crop.notes!.isNotEmpty)

              Text("📝 ${crop.notes}"),

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

            )

          ],

        ),

      ),

    );

  }

}