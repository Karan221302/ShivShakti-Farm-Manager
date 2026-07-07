import 'package:flutter/material.dart';

import '../../models/work_entry.dart';
import '../../services/work_entry_service.dart';
import '../../widgets/work_entry_card.dart';
import 'add_work_entry_screen.dart';
import 'edit_work_entry_screen.dart';

class WorkEntryListScreen extends StatefulWidget {
  const WorkEntryListScreen({super.key});

  @override
  State<WorkEntryListScreen> createState() =>
      _WorkEntryListScreenState();
}

class _WorkEntryListScreenState
    extends State<WorkEntryListScreen> {

  final WorkEntryService workEntryService =
      WorkEntryService();

  final TextEditingController searchController =
      TextEditingController();

  List<WorkEntry> workEntries = [];

  List<WorkEntry> filteredEntries = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadWorkEntries();
  }

  Future<void> loadWorkEntries() async {

    try {

      final result =
          await workEntryService.getAll();

      setState(() {

        workEntries = result;

        filteredEntries = result;

        loading = false;

      });

    } catch (e) {

      setState(() {

        loading = false;

      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),

        ),

      );

    }

  }

  void search(String text) {

    setState(() {

      filteredEntries = workEntries.where(

        (entry) {

          return entry.labourName
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||

              entry.workType
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||

              entry.workDate
                  .contains(text);

        },

      ).toList();

    });

  }

  Future<void> openAddScreen() async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const AddWorkEntryScreen(),

      ),

    );

    if (result == true) {

      loadWorkEntries();

    }

  }

  Future<void> openEditScreen(
      WorkEntry workEntry) async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => EditWorkEntryScreen(

          workEntry: workEntry,

        ),

      ),

    );

    if (result == true) {

      loadWorkEntries();

    }

  }

  Future<void> deleteWorkEntry(
      WorkEntry workEntry) async {

    final confirm = await showDialog<bool>(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text(
          "Delete Work Entry",
        ),

        content: Text(
          "Delete work entry for ${workEntry.labourName}?"
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                  context,
                  false);

            },

            child: const Text("Cancel"),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(
                  context,
                  true);

            },

            child: const Text("Delete"),

          ),

        ],

      ),

    );

    if (confirm != true) return;

    try {

      await workEntryService.deleteWorkEntry(
          workEntry.id);

      loadWorkEntries();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
              "Work Entry Deleted"),

        ),

      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),

        ),

      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Work Entries",
        ),

      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: openAddScreen,

        child: const Icon(Icons.add),

      ),

      body: loading

          ? const Center(

              child:
                  CircularProgressIndicator(),

            )

          : RefreshIndicator(

              onRefresh: loadWorkEntries,

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
                            "Search Work Entries",

                        prefixIcon:
                            const Icon(
                                Icons.search),

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  12),

                        ),

                      ),

                    ),

                  ),

                  Expanded(

                    child: filteredEntries
                            .isEmpty

                        ? ListView(

                            children: const [

                              SizedBox(
                                  height: 200),

                              Center(

                                child: Text(

                                  "No Work Entries",

                                  style: TextStyle(
                                      fontSize:
                                          18),

                                ),

                              )

                            ],

                          )

                        : ListView.builder(

                            itemCount:
                                filteredEntries
                                    .length,

                            itemBuilder:
                                (context,
                                    index) {

                              final workEntry =
                                  filteredEntries[
                                      index];

                              return WorkEntryCard(

                                workEntry:
                                    workEntry,

                                onEdit: () {

                                  openEditScreen(
                                      workEntry);

                                },

                                onDelete: () {

                                  deleteWorkEntry(
                                      workEntry);

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