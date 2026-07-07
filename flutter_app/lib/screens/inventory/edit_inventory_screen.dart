import 'package:flutter/material.dart';

import '../../models/inventory.dart';
import '../../services/inventory_service.dart';

class EditInventoryScreen extends StatefulWidget {

  final Inventory inventory;

  const EditInventoryScreen({

    super.key,

    required this.inventory,

  });

  @override
  State<EditInventoryScreen> createState() =>
      _EditInventoryScreenState();

}

class _EditInventoryScreenState
    extends State<EditInventoryScreen> {

  final _formKey = GlobalKey<FormState>();

  final InventoryService service =
      InventoryService();

  late TextEditingController nameController;
  late TextEditingController unitController;
  late TextEditingController currentStockController;
  late TextEditingController minimumStockController;
  late TextEditingController purchasePriceController;
  late TextEditingController sellingPriceController;

  late String category;

  bool loading = false;

  @override
  void initState() {

    super.initState();

    final item = widget.inventory;

    nameController =
        TextEditingController(text: item.name);

    unitController =
        TextEditingController(text: item.unit);

    currentStockController =
        TextEditingController(
            text: item.currentStock.toString());

    minimumStockController =
        TextEditingController(
            text: item.minimumStock.toString());

    purchasePriceController =
        TextEditingController(
            text: item.purchasePrice.toString());

    sellingPriceController =
        TextEditingController(
            text: item.sellingPrice?.toString() ?? "");

    category = item.category;

  }

  Future<void> save() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {

      await service.updateInventory(

        id: widget.inventory.id,

        name: nameController.text,

        category: category,

        unit: unitController.text,

        currentStock:
            double.parse(currentStockController.text),

        minimumStock:
            double.parse(minimumStockController.text),

        purchasePrice:
            double.parse(purchasePriceController.text),

        sellingPrice:
            sellingPriceController.text.isEmpty
                ? null
                : double.parse(
                    sellingPriceController.text),

      );

      if (mounted) {
        Navigator.pop(context, true);
      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(e.toString()),
        ),

      );

    }

    if (mounted) {

      setState(() {
        loading = false;
      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Edit Inventory"),

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(
                  labelText: "Name",
                ),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(

                value: category,

                decoration:
                    const InputDecoration(
                  labelText: "Category",
                ),

                items: const [

                  DropdownMenuItem(
                    value: "SEED",
                    child: Text("Seed"),
                  ),

                  DropdownMenuItem(
                    value: "FERTILIZER",
                    child: Text("Fertilizer"),
                  ),

                  DropdownMenuItem(
                    value: "PESTICIDE",
                    child: Text("Pesticide"),
                  ),

                  DropdownMenuItem(
                    value: "EQUIPMENT",
                    child: Text("Equipment"),
                  ),

                  DropdownMenuItem(
                    value: "TOOL",
                    child: Text("Tool"),
                  ),

                  DropdownMenuItem(
                    value: "OTHER",
                    child: Text("Other"),
                  ),

                ],

                onChanged: (value) {

                  setState(() {

                    category = value!;

                  });

                },

              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: unitController,
                decoration:
                    const InputDecoration(
                  labelText: "Unit",
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: currentStockController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(
                  labelText: "Current Stock",
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: minimumStockController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(
                  labelText: "Minimum Stock",
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: purchasePriceController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(
                  labelText: "Purchase Price",
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: sellingPriceController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(
                  labelText: "Selling Price",
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed:
                      loading ? null : save,

                  child: loading

                      ? const CircularProgressIndicator()

                      : const Text(
                          "Update Inventory",
                        ),

                ),

              )

            ],

          ),

        ),

      ),

    );

  }

}