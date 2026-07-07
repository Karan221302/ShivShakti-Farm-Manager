import 'package:flutter/material.dart';

import '../../models/crop.dart';
import '../../services/crop_service.dart';
import '../../widgets/crop_card.dart';
import 'add_crop_screen.dart';
import 'edit_crop_screen.dart';

class CropListScreen extends StatefulWidget {
  const CropListScreen({super.key});

  @override
  State<CropListScreen> createState() =>
      _CropListScreenState();
}

class _CropListScreenState
    extends State<CropListScreen> {

  final CropService cropService =
      CropService();

  final TextEditingController searchController =
      TextEditingController();

  List<Crop> crops = [];

  List<Crop> filteredCrops = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCrops();
  }

  Future<void> loadCrops() async {

    try {

      final result =
          await cropService.getAll();

      setState(() {

        crops = result;

        filteredCrops = result;

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

      filteredCrops = crops.where(

        (crop) {

          return crop.cropName
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||

              crop.variety
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||

              (crop.notes ?? "")
                  .toLowerCase()
                  .contains(text.toLowerCase());

        },

      ).toList();

    });

  }

  Future<void> openAddCrop() async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const AddCropScreen(),

      ),

    );

    if (result == true) {

      loadCrops();

    }

  }

  Future<void> openEditCrop(
      Crop crop) async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            EditCropScreen(
              crop: crop,
            ),

      ),

    );

    if (result == true) {

      loadCrops();

    }

  }

  Future<void> deleteCrop(
      Crop crop) async {

    final confirm = await showDialog<bool>(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text(
          "Delete Crop",
        ),

        content: Text(
          "Delete ${crop.cropName}?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                context,
                false,
              );

            },

            child: const Text(
              "Cancel",
            ),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(
                context,
                true,
              );

            },

            child: const Text(
              "Delete",
            ),

          ),

        ],

      ),

    );

    if (confirm != true) return;

    await cropService.deleteCrop(
      crop.id,
    );

    loadCrops();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Crop Management",
        ),

      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: openAddCrop,

        child: const Icon(Icons.add),

      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : RefreshIndicator(

              onRefresh: loadCrops,

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
                          const InputDecoration(

                        hintText:
                            "Search Crop",

                        prefixIcon:
                            Icon(Icons.search),

                        border:
                            OutlineInputBorder(),

                      ),

                    ),

                  ),

                  Expanded(

                    child: filteredCrops
                            .isEmpty

                        ? ListView(

                            children: const [

                              SizedBox(height: 200),

                              Center(

                                child: Text(

                                  "No Crops Found",

                                  style: TextStyle(
                                    fontSize: 18,
                                  ),

                                ),

                              ),

                            ],

                          )

                        : ListView.builder(

                            itemCount:
                                filteredCrops.length,

                            itemBuilder:
                                (context, index) {

                              final crop =
                                  filteredCrops[index];

                              return CropCard(

                                crop: crop,

                                onEdit: () {

                                  openEditCrop(
                                      crop);

                                },

                                onDelete: () {

                                  deleteCrop(
                                      crop);

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