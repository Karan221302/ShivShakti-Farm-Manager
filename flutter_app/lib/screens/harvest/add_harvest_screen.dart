import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/crop.dart';
import '../../services/crop_service.dart';
import '../../services/harvest_service.dart';

class AddHarvestScreen extends StatefulWidget {
  const AddHarvestScreen({super.key});

  @override
  State<AddHarvestScreen> createState() =>
      _AddHarvestScreenState();
}

class _AddHarvestScreenState
    extends State<AddHarvestScreen> {

  final HarvestService harvestService =
      HarvestService();

  final CropService cropService =
      CropService();

  final quantityController =
      TextEditingController();

  final rateController =
      TextEditingController();

  List<Crop> crops = [];

  Crop? selectedCrop;

  DateTime harvestDate = DateTime.now();

  bool loading = true;

  bool saving = false;

  String unit = "KG";

  final List<String> units = [

    "KG",

    "QUINTAL",

    "TON"

  ];

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

        if (result.isNotEmpty) {

          selectedCrop = result.first;

        }

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

  Future<void> pickDate() async {

    final picked =
        await showDatePicker(

      context: context,

      initialDate: harvestDate,

      firstDate: DateTime(2020),

      lastDate: DateTime(2035),

    );

    if (picked != null) {

      setState(() {

        harvestDate = picked;

      });

    }

  }

  double get revenue {

    final qty =
        double.tryParse(quantityController.text) ?? 0;

    final rate =
        double.tryParse(rateController.text) ?? 0;

    return qty * rate;

  }

  Future<void> saveHarvest() async {

    if (selectedCrop == null) return;

    if (quantityController.text.isEmpty ||
        rateController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text("Enter Quantity and Rate"),
        ),

      );

      return;

    }

    setState(() {

      saving = true;

    });

    try {

      await harvestService.addHarvest(

        cropId: selectedCrop!.id,

        harvestDate:
            DateFormat("yyyy-MM-dd")
                .format(harvestDate),

        quantity:
            double.parse(
                quantityController.text),

        unit: unit,

        rate:
            double.parse(
                rateController.text),

      );

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(e.toString()),
        ),

      );

    }

    if (mounted) {

      setState(() {

        saving = false;

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),

      );

    }

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Add Harvest",
        ),

      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            DropdownButtonFormField<Crop>(

              value: selectedCrop,

              decoration: const InputDecoration(

                labelText: "Crop",

                border: OutlineInputBorder(),

              ),

              items: crops.map((crop) {

                return DropdownMenuItem<Crop>(

                  value: crop,

                  child: Text(crop.cropName),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  selectedCrop = value;

                });

              },

            ),

            const SizedBox(height: 20),

            ListTile(

              shape: RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(10),

                side: const BorderSide(),

              ),

              title: Text(

                DateFormat("dd MMM yyyy")
                    .format(harvestDate),

              ),

              trailing: const Icon(
                Icons.calendar_month,
              ),

              onTap: pickDate,

            ),

            const SizedBox(height: 20),

            TextField(

              controller: quantityController,

              keyboardType:
                  TextInputType.number,

              onChanged: (_) {

                setState(() {});

              },

              decoration: const InputDecoration(

                labelText: "Quantity",

                border: OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(

              value: unit,

              decoration: const InputDecoration(

                labelText: "Unit",

                border: OutlineInputBorder(),

              ),

              items: units.map((u) {

                return DropdownMenuItem(

                  value: u,

                  child: Text(u),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  unit = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            TextField(

              controller: rateController,

              keyboardType:
                  TextInputType.number,

              onChanged: (_) {

                setState(() {});

              },

              decoration: const InputDecoration(

                labelText: "Rate",

                border: OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 20),

            Card(

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Column(

                  children: [

                    const Text(

                      "Estimated Revenue",

                    ),

                    const SizedBox(height: 10),

                    Text(

                      "₹${revenue.toStringAsFixed(2)}",

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

            const SizedBox(height: 30),

            SizedBox(

              height: 50,

              child: ElevatedButton(

                onPressed:
                    saving ? null : saveHarvest,

                child: saving

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Save Harvest",
                      ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}