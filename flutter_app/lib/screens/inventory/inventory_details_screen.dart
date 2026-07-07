import 'package:flutter/material.dart';

import '../../models/inventory.dart';
import '../../services/inventory_service.dart';
import '../../widgets/stock_in_dialog.dart';
import '../../widgets/stock_out_dialog.dart';
import 'inventory_transactions_screen.dart';
import 'edit_inventory_screen.dart';



class InventoryDetailsScreen extends StatefulWidget {
  final Inventory inventory;

  const InventoryDetailsScreen({
    super.key,
    required this.inventory,
  });

  @override
  State<InventoryDetailsScreen> createState() =>
      _InventoryDetailsScreenState();
}

class _InventoryDetailsScreenState
    extends State<InventoryDetailsScreen> {

  final InventoryService inventoryService =
      InventoryService();

  late Inventory inventory;

  @override
  void initState() {
    super.initState();
    inventory = widget.inventory;
  }
  Future<void> refreshInventory() async {

  final latest =
      await inventoryService.getInventoryById(
    inventory.id,
  );

  if (!mounted) return;

  setState(() {

    inventory = latest;

  });

}

  @override
  Widget build(BuildContext context) {

    final bool lowStock =
        inventory.currentStock <=
            inventory.minimumStock;

    return Scaffold(

      appBar: AppBar(

        title: const Text("Inventory Details"),

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Card(

              elevation: 3,

              child: Padding(

                padding:
                    const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(

                      inventory.name,

                      style:
                          const TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),

                    const SizedBox(height: 20),

                    detail(
                      "Category",
                      inventory.category,
                    ),

                    detail(
                      "Unit",
                      inventory.unit,
                    ),

                    detail(
                      "Current Stock",
                      "${inventory.currentStock}",
                    ),

                    detail(
                      "Minimum Stock",
                      "${inventory.minimumStock}",
                    ),

                    detail(
                      "Purchase Price",
                      "₹${inventory.purchasePrice}",
                    ),

                    detail(
                      "Selling Price",
                      inventory.sellingPrice == null
                          ? "-"
                          : "₹${inventory.sellingPrice}",
                    ),

                    const SizedBox(height: 15),

                    Chip(
backgroundColor:
inventory.currentStock == 0
    ? Colors.grey.shade300
    : lowStock
        ? Colors.red.shade100
        : Colors.green.shade100,

                      label: Text(

                        inventory.currentStock == 0
    ? "Out of Stock"
    : lowStock
        ? "Low Stock"
        : "In Stock",

                        style: TextStyle(
color:
inventory.currentStock == 0
    ? Colors.black
    : lowStock
        ? Colors.red
        : Colors.green,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    )

                  ],

                ),

              ),

            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.add),

                label: const Text("Stock In"),

                onPressed: () async {

  final result =
      await showDialog<Map<String, dynamic>>(

    context: context,

    builder: (_) =>
        const StockInDialog(),

  );

  if (result == null) return;

  await inventoryService.stockIn(

    id: inventory.id,

    quantity: result["quantity"],

    remarks: result["remarks"],

  );
  await refreshInventory();

  if (mounted) {

    ScaffoldMessenger.of(context)

        .showSnackBar(

      const SnackBar(

        content: Text("Stock Updated"),

      ),

    );

  }

},

              ),

            ),

            const SizedBox(height: 12),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.remove),

                label: const Text("Stock Out"),

                onPressed: () async {

  final result =
      await showDialog<Map<String, dynamic>>(

    context: context,

    builder: (_) =>
        const StockOutDialog(),

  );

  if (result == null) return;

  await inventoryService.stockOut(

    id: inventory.id,

    quantity: result["quantity"],

    remarks: result["remarks"],

  );
  await refreshInventory();

  if (mounted) {

    ScaffoldMessenger.of(context)

        .showSnackBar(

      const SnackBar(

        content: Text("Stock Updated"),

      ),

    );

  }

},

              ),

            ),

            const SizedBox(height: 12),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.history),

                label:
                    const Text("Transactions"),

                onPressed: () {

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) =>

          InventoryTransactionsScreen(

        inventoryId: inventory.id,

      ),

    ),

  );

},

              ),

            ),

            const SizedBox(height: 12),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.edit),

                label:
                    const Text("Edit Inventory"),

                onPressed: () async {

  final updated = await Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => EditInventoryScreen(

        inventory: inventory,

      ),

    ),

  );

  if (updated == true) {

    await refreshInventory();

  }

},

              ),

            ),

          ],

        ),

      ),

    );

  }

  Widget detail(
      String title,
      String value,
      ) {

    return Padding(

      padding:
          const EdgeInsets.only(bottom: 12),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(

            title,

            style: const TextStyle(

              fontWeight:
                  FontWeight.bold,

            ),

          ),

          Text(value),

        ],

      ),

    );

  }

}