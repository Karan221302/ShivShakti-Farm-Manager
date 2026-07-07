import 'package:flutter/material.dart';

import '../../services/inventory_service.dart';

class AddInventoryScreen extends StatefulWidget {
  const AddInventoryScreen({super.key});

  @override
  State<AddInventoryScreen> createState() =>
      _AddInventoryScreenState();
}

class _AddInventoryScreenState
    extends State<AddInventoryScreen> {

  final _formKey = GlobalKey<FormState>();

  final InventoryService inventoryService =
      InventoryService();

  final nameController = TextEditingController();

  final unitController = TextEditingController();

  final currentStockController =
      TextEditingController();

  final minimumStockController =
      TextEditingController();

  final purchasePriceController =
      TextEditingController();

  final sellingPriceController =
      TextEditingController();

  String category = "SEED";

  bool loading = false;

  Future<void> save() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {

      await inventoryService.addInventory(

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
                    sellingPriceController.text,
                  ),

      );

      if (mounted) {
        Navigator.pop(context, true);
      }

    } catch (e) {

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(
            content: Text(e.toString()),
          ),

        );

      }

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
        title: const Text("Add Inventory"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              TextFormField(

                controller: nameController,

                decoration: const InputDecoration(
                  labelText: "Item Name",
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return "Required";
                  }

                  return null;

                },

              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(

                value: category,

                decoration: const InputDecoration(
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

                decoration: const InputDecoration(
                  labelText: "Unit (Kg, Bag, Litre...)",
                ),

              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    currentStockController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Current Stock",
                ),

              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    minimumStockController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Minimum Stock",
                ),

              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    purchasePriceController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Purchase Price",
                ),

              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    sellingPriceController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Selling Price (Optional)",
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
                          "Save Inventory",
                        ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}