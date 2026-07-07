import 'package:flutter/material.dart';

import '../../models/labour.dart';
import '../../services/labour_service.dart';
import '../../widgets/labour_card.dart';
import 'add_labour_screen.dart';
import 'edit_labour_screen.dart';

class LabourListScreen extends StatefulWidget {
  const LabourListScreen({super.key});

  @override
  State<LabourListScreen> createState() => _LabourListScreenState();
}

class _LabourListScreenState extends State<LabourListScreen> {
  final LabourService labourService = LabourService();

  final TextEditingController searchController =
      TextEditingController();

  List<Labour> labours = [];

  List<Labour> filtered = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadLabours();
  }

  Future<void> loadLabours() async {
    try {
      final result = await labourService.getAll();

      setState(() {
        labours = result;
        filtered = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  void search(String value) {
    setState(() {
      filtered = labours.where((labour) {
        return labour.name
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            labour.mobile
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            labour.village
                .toLowerCase()
                .contains(value.toLowerCase());
      }).toList();
    });
  }

  Future<void> openAddLabour() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddLabourScreen(),
      ),
    );

    if (result == true) {
      loadLabours();
    }
  }

  Future<void> openEditLabour(
      Labour labour) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditLabourScreen(
          labour: labour,
        ),
      ),
    );

    if (result == true) {
      loadLabours();
    }
  }

  Future<void> deleteLabour(
      Labour labour) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Disable Labour"),
          content: Text(
            "Disable ${labour.name} ?",
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
              child: const Text("Disable"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await labourService.disableLabour(
        labour.id,
      );

      loadLabours();

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Labour Disabled",
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Labour Management",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: openAddLabour,
        child: const Icon(Icons.add),
      ),

      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: loadLabours,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(16),
                    child: TextField(
                      controller:
                          searchController,
                      onChanged: search,
                      decoration:
                          InputDecoration(
                        hintText:
                            "Search Labour",
                        prefixIcon:
                            const Icon(
                          Icons.search,
                        ),
                        suffixIcon:
                            searchController
                                    .text
                                    .isEmpty
                                ? null
                                : IconButton(
                                    icon:
                                        const Icon(
                                      Icons
                                          .clear,
                                    ),
                                    onPressed:
                                        () {
                                      searchController
                                          .clear();

                                      search("");
                                    },
                                  ),
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: filtered.isEmpty
                        ? const Center(
                            child: Text(
                              "No Labour Found",
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                filtered.length,
                            itemBuilder:
                                (context,
                                    index) {
                              final labour =
                                  filtered[
                                      index];

                              return LabourCard(
                                labour:
                                    labour,

                                onEdit:
                                    () {
                                  openEditLabour(
                                    labour,
                                  );
                                },

                                onDelete:
                                    () {
                                  deleteLabour(
                                    labour,
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