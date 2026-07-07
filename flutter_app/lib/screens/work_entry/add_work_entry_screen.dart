import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/labour.dart';
import '../../services/labour_service.dart';
import '../../services/work_entry_service.dart';

class AddWorkEntryScreen extends StatefulWidget {
  const AddWorkEntryScreen({super.key});

  @override
  State<AddWorkEntryScreen> createState() =>
      _AddWorkEntryScreenState();
}

class _AddWorkEntryScreenState
    extends State<AddWorkEntryScreen> {

  final WorkEntryService workEntryService =
      WorkEntryService();

  final LabourService labourService =
      LabourService();

  final remarksController =
      TextEditingController();

  List<Labour> labours = [];

  Labour? selectedLabour;

  DateTime selectedDate = DateTime.now();

  String workType = "IRRIGATION";

  String manday = "FULL_DAY";

  bool loading = true;

  bool saving = false;

  final List<String> workTypes = [

    "LAND_PREPARATION",
    "PLOUGHING",
    "SEED_SOWING",
    "FERTILIZER_APPLICATION",
    "IRRIGATION",
    "PESTICIDE_SPRAYING",
    "WEED_REMOVAL",
    "HARVESTING",
    "TRANSPORTATION",
    "OTHER"

  ];

  final List<String> mandays = [

    "HALF_DAY",
    "FULL_DAY"

  ];

  @override
  void initState() {
    super.initState();
    loadLabours();
  }

  Future<void> loadLabours() async {

    final result =
        await labourService.getAll();

    setState(() {

      labours = result;

      if (labours.isNotEmpty) {
        selectedLabour = labours.first;
      }

      loading = false;

    });

  }

  Future<void> pickDate() async {

    final picked =
        await showDatePicker(

      context: context,

      initialDate: selectedDate,

      firstDate: DateTime(2024),

      lastDate: DateTime(2035),

    );

    if (picked != null) {

      setState(() {

        selectedDate = picked;

      });

    }

  }

  Future<void> save() async {

    if (selectedLabour == null) return;

    setState(() {

      saving = true;

    });

    await workEntryService.addWorkEntry(

      labourId: selectedLabour!.id,

      workDate:
          DateFormat("yyyy-MM-dd")
              .format(selectedDate),

      workType: workType,

      manday: manday,

      remarks: remarksController.text,

    );

    if (!mounted) return;

    Navigator.pop(context, true);

  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Scaffold(

        body: Center(

          child:
              CircularProgressIndicator(),

        ),

      );

    }

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Add Work Entry",
        ),

      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            DropdownButtonFormField<Labour>(

              value: selectedLabour,

              decoration:
                  const InputDecoration(

                labelText: "Labour",

                border:
                    OutlineInputBorder(),

              ),

              items: labours.map((e) {

                return DropdownMenuItem(

                  value: e,

                  child: Text(e.name),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  selectedLabour = value;

                });

              },

            ),

            const SizedBox(height: 20),

            ListTile(

              title: Text(

                DateFormat(
                        "dd MMM yyyy")
                    .format(selectedDate),

              ),

              trailing: const Icon(

                  Icons.calendar_today),

              onTap: pickDate,

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(

              value: workType,

              decoration:
                  const InputDecoration(

                labelText: "Work Type",

                border:
                    OutlineInputBorder(),

              ),

              items: workTypes.map((e) {

                return DropdownMenuItem(

                  value: e,

                  child: Text(e),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  workType = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(

              value: manday,

              decoration:
                  const InputDecoration(

                labelText: "Manday",

                border:
                    OutlineInputBorder(),

              ),

              items: mandays.map((e) {

                return DropdownMenuItem(

                  value: e,

                  child: Text(e),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  manday = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            TextField(

              controller:
                  remarksController,

              decoration:
                  const InputDecoration(

                labelText: "Remarks",

                border:
                    OutlineInputBorder(),

              ),

              maxLines: 3,

            ),

            const SizedBox(height: 30),

            SizedBox(

              height: 50,

              child: ElevatedButton(

                onPressed:
                    saving ? null : save,

                child: saving

                    ? const CircularProgressIndicator()

                    : const Text(
                        "Save Work Entry"),

              ),

            )

          ],

        ),

      ),

    );

  }

}