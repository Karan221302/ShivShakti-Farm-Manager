import 'package:flutter/material.dart';

import '../../models/inventory.dart';
import '../../services/inventory_service.dart';

import '../../widgets/inventory_card.dart';

import 'add_inventory_screen.dart';
import 'inventory_details_screen.dart';

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() =>
      _InventoryListScreenState();
}

class _InventoryListScreenState
    extends State<InventoryListScreen> {

  final InventoryService inventoryService =
      InventoryService();

  final TextEditingController searchController =
      TextEditingController();

  List<Inventory> inventories = [];

  List<Inventory> filtered = [];

  bool loading = true;

  @override
  void initState() {

    super.initState();

    loadInventory();

  }

  Future<void> loadInventory() async {

    try {

      inventories =
          await inventoryService.getAll();

      filtered = inventories;

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

  void search(String value) {

    setState(() {

      filtered = inventories.where(

        (inventory) {

          return inventory.name

              .toLowerCase()

              .contains(

                value.toLowerCase(),

              );

        },

      ).toList();

    });

  }

  Future<void> deleteInventory(
      Inventory inventory) async {

    final delete = await showDialog<bool>(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text(
          "Delete Inventory",
        ),

        content: Text(

          "Delete ${inventory.name} ?",

        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                context,
                false,
              );

            },

            child: const Text("Cancel"),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(
                context,
                true,
              );

            },

            child: const Text("Delete"),

          ),

        ],

      ),

    );

    if (delete != true) return;

    await inventoryService.deleteInventory(
      inventory.id,
    );

    loadInventory();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Inventory",
        ),

      ),

      floatingActionButton:

          FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>

                  const AddInventoryScreen(),

            ),

          );

          loadInventory();

        },

      ),

      body: loading

          ? const Center(

              child:

                  CircularProgressIndicator(),

            )

          : RefreshIndicator(

              onRefresh: loadInventory,

              child: Column(

                children: [

                  Padding(

                    padding:
                        const EdgeInsets.all(12),

                    child: TextField(

                      controller:
                          searchController,

                      onChanged: search,

                      decoration:

                          const InputDecoration(

                        hintText:

                            "Search Inventory",

                        prefixIcon:

                            Icon(Icons.search),

                        border:

                            OutlineInputBorder(),

                      ),

                    ),

                  ),

                  Expanded(

                    child: filtered.isEmpty

                        ? const Center(

                            child: Text(

                              "No Inventory Found",

                            ),

                          )

                        : ListView.builder(

                            itemCount:
                                filtered.length,

                            itemBuilder:

                                (_, index) {

                              final inventory =

                                  filtered[index];

                              return InventoryCard(

                                inventory:

                                    inventory,

                                onTap: () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder: (_) =>

                                          InventoryDetailsScreen(

                                        inventory:

                                            inventory,

                                      ),

                                    ),

                                  );

                                },

                                onDelete: () {

                                  deleteInventory(

                                    inventory,

                                  );

                                },

                              );

                            },

                          ),

                  ),

                ],

              ),

            ),

    );

  }

}