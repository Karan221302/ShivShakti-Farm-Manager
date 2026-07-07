import 'package:flutter/material.dart';

import '../models/inventory.dart';

class InventoryCard extends StatelessWidget {
  final Inventory inventory;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const InventoryCard({
    super.key,
    required this.inventory,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool lowStock =
        inventory.currentStock <= inventory.minimumStock;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          backgroundColor: lowStock
              ? Colors.red.shade100
              : Colors.green.shade100,
          child: Icon(
            Icons.inventory_2,
            color: lowStock
                ? Colors.red
                : Colors.green,
          ),
        ),

        title: Text(
          inventory.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 4),

            Text(
              "Category : ${inventory.category}",
            ),

            Text(
              "Stock : ${inventory.currentStock} ${inventory.unit}",
            ),

            Text(
              "Minimum : ${inventory.minimumStock} ${inventory.unit}",
            ),

            Text(
              "Purchase : ₹${inventory.purchasePrice}",
            ),

            if (inventory.sellingPrice != null)
              Text(
                "Selling : ₹${inventory.sellingPrice}",
              ),

            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: lowStock
                    ? Colors.red.shade100
                    : Colors.green.shade100,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Text(
                lowStock
                    ? "Low Stock"
                    : "In Stock",
                style: TextStyle(
                  color: lowStock
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}