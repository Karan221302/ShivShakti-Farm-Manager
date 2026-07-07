import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/crop.dart';
import '../../services/crop_service.dart';

class EditCropScreen extends StatefulWidget {
  final Crop crop;

  const EditCropScreen({
    super.key,
    required this.crop,
  });

  @override
  State<EditCropScreen> createState() =>
      _EditCropScreenState();
}

class _EditCropScreenState
    extends State<EditCropScreen> {

  final CropService cropService =
      CropService();

  late TextEditingController cropNameController;
  late TextEditingController varietyController;
  late TextEditingController notesController;

  late DateTime sowingDate;
  late DateTime expectedHarvestDate;

  bool saving = false;

  @override
  void initState() {
    super.initState();

    cropNameController =
        TextEditingController(
      text: widget.crop.cropName,
    );

    varietyController =
        TextEditingController(
      text: widget.crop.variety,
    );

    notesController =
        TextEditingController(
      text: widget.crop.notes ?? "",
    );

    sowingDate =
        DateTime.parse(widget.crop.sowingDate);

    expectedHarvestDate =
        DateTime.parse(
            widget.crop.expectedHarvestDate);
  }

  Future<void> pickSowingDate() async {

    final picked =
        await showDatePicker(

      context: context,

      initialDate: sowingDate,

      firstDate: DateTime(2020),

      lastDate: DateTime(2035),

    );

    if (picked != null) {

      setState(() {

        sowingDate = picked;

      });

    }

  }

  Future<void> pickHarvestDate() async {

    final picked =
        await showDatePicker(

      context: context,

      initialDate:
          expectedHarvestDate,

      firstDate: DateTime(2020),

      lastDate: DateTime(2035),

    );

    if (picked != null) {

      setState(() {

        expectedHarvestDate =
            picked;

      });

    }

  }

  Future<void> updateCrop() async {

    if (cropNameController.text.isEmpty ||
        varietyController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text("Fill all required fields"),

        ),

      );

      return;
    }

    setState(() {

      saving = true;

    });

    try {

      await cropService.updateCrop(

        id: widget.crop.id,

        cropName:
            cropNameController.text,

        variety:
            varietyController.text,

        sowingDate:
            DateFormat("yyyy-MM-dd")
                .format(sowingDate),

        expectedHarvestDate:
            DateFormat("yyyy-MM-dd")
                .format(
                    expectedHarvestDate),

        notes:
            notesController.text,

      );

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

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

    return Scaffold(

      appBar: AppBar(

        title:
            const Text("Edit Crop"),

      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: ListView(

          children: [

            TextField(

              controller:
                  cropNameController,

              decoration:
                  const InputDecoration(

                labelText:
                    "Crop Name",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
                  varietyController,

              decoration:
                  const InputDecoration(

                labelText:
                    "Variety",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(
                height: 20),

            ListTile(

              title: Text(

                "Sowing: ${DateFormat("dd MMM yyyy").format(sowingDate)}",

              ),

              trailing:
                  const Icon(
                      Icons.calendar_month),

              onTap:
                  pickSowingDate,

            ),

            const SizedBox(
                height: 20),

            ListTile(

              title: Text(

                "Harvest: ${DateFormat("dd MMM yyyy").format(expectedHarvestDate)}",

              ),

              trailing:
                  const Icon(
                      Icons.calendar_month),

              onTap:
                  pickHarvestDate,

            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
                  notesController,

              maxLines: 3,

              decoration:
                  const InputDecoration(

                labelText:
                    "Notes",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(
                height: 30),

            SizedBox(

              height: 50,

              child:
                  ElevatedButton(

                onPressed: saving
                    ? null
                    : updateCrop,

                child: saving

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Update Crop",
                      ),

              ),

            ),

          ],

        ),

      ),

    );

  }
}
