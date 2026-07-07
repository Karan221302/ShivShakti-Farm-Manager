import 'package:flutter/material.dart';

import '../../models/harvest.dart';
import '../../services/harvest_service.dart';
import '../../widgets/harvest_card.dart';
import 'add_harvest_screen.dart';
import 'edit_harvest_screen.dart';

class HarvestListScreen extends StatefulWidget {
  const HarvestListScreen({super.key});

  @override
  State<HarvestListScreen> createState() =>
      _HarvestListScreenState();
}

class _HarvestListScreenState
    extends State<HarvestListScreen> {

  final HarvestService harvestService =
      HarvestService();

  final TextEditingController searchController =
      TextEditingController();

  List<Harvest> harvests = [];

  List<Harvest> filteredHarvests = [];

  bool loading = true;

  double totalRevenue = 0;

  @override
  void initState() {
    super.initState();
    loadHarvests();
  }

  Future<void> loadHarvests() async {

    try {

      final result =
          await harvestService.getAll();

      setState(() {

        harvests = result;

        filteredHarvests = result;

        totalRevenue = result.fold(

          0,

          (sum, item) => sum + item.revenue,

        );

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

  void search(String value) {

    setState(() {

      filteredHarvests = harvests.where(

        (harvest) {

          return harvest.cropName

                  .toLowerCase()

                  .contains(value.toLowerCase()) ||

              harvest.unit

                  .toLowerCase()

                  .contains(value.toLowerCase());

        },

      ).toList();

    });

  }

  Future<void> openAddHarvest() async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const AddHarvestScreen(),

      ),

    );

    if (result == true) {

      loadHarvests();

    }

  }

  Future<void> openEditHarvest(
      Harvest harvest) async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            EditHarvestScreen(

          harvest: harvest,

        ),

      ),

    );

    if (result == true) {

      loadHarvests();

    }

  }

  Future<void> deleteHarvest(
      Harvest harvest) async {

    final confirm = await showDialog<bool>(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text(
          "Delete Harvest",
        ),

        content: Text(
          "Delete ${harvest.cropName} harvest?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                  context,
                  false);

            },

            child: const Text(
              "Cancel",
            ),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(
                  context,
                  true);

            },

            child: const Text(
              "Delete",
            ),

          ),

        ],

      ),

    );

    if (confirm != true) return;

    await harvestService.deleteHarvest(
      harvest.id,
    );

    loadHarvests();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Harvest Management",
        ),

      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: openAddHarvest,

        child: const Icon(Icons.add),

      ),

      body: loading

          ? const Center(

              child:
                  CircularProgressIndicator(),

            )

          : RefreshIndicator(

              onRefresh: loadHarvests,

              child: Column(

                children: [

                  Card(

                    margin:
                        const EdgeInsets.all(16),

                    child: Padding(

                      padding:
                          const EdgeInsets.all(20),

                      child: Column(

                        children: [

                          const Text(

                            "Total Revenue",

                            style: TextStyle(
                              fontSize: 18,
                            ),

                          ),

                          const SizedBox(
                              height: 10),

                          Text(

                            "₹${totalRevenue.toStringAsFixed(2)}",

                            style: const TextStyle(

                              fontSize: 28,

                              fontWeight:
                                  FontWeight.bold,

                              color: Colors.green,

                            ),

                          ),

                        ],

                      ),

                    ),

                  ),

                  Padding(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    child: TextField(

                      controller:
                          searchController,

                      onChanged: search,

                      decoration:
                          const InputDecoration(

                        hintText:
                            "Search Harvest",

                        prefixIcon:
                            Icon(Icons.search),

                        border:
                            OutlineInputBorder(),

                      ),

                    ),

                  ),

                  const SizedBox(height: 10),

                  Expanded(

                    child:
                        filteredHarvests.isEmpty

                            ? ListView(

                                children: const [

                                  SizedBox(
                                      height:
                                          200),

                                  Center(

                                    child: Text(

                                      "No Harvest Records",

                                      style:
                                          TextStyle(
                                        fontSize:
                                            18,
                                      ),

                                    ),

                                  )

                                ],

                              )

                            : ListView.builder(

                                itemCount:
                                    filteredHarvests
                                        .length,

                                itemBuilder:
                                    (context,
                                        index) {

                                  final harvest =
                                      filteredHarvests[
                                          index];

                                  return HarvestCard(

                                    harvest:
                                        harvest,

                                    onEdit: () {

                                      openEditHarvest(
                                          harvest);

                                    },

                                    onDelete: () {

                                      deleteHarvest(
                                          harvest);

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