import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/labour.dart';
import '../../models/work_entry.dart';
import '../../services/labour_service.dart';
import '../../services/work_entry_service.dart';

class EditWorkEntryScreen extends StatefulWidget {
  final WorkEntry workEntry;

  const EditWorkEntryScreen({
    super.key,
    required this.workEntry,
  });

  @override
  State<EditWorkEntryScreen> createState() =>
      _EditWorkEntryScreenState();
}

class _EditWorkEntryScreenState
    extends State<EditWorkEntryScreen> {

  final WorkEntryService workEntryService =
      WorkEntryService();

  final LabourService labourService =
      LabourService();

  final remarksController =
      TextEditingController();

  List<Labour> labours = [];

  Labour? selectedLabour;

  late DateTime selectedDate;

  late String workType;

  late String manday;

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

    remarksController.text =
        widget.workEntry.remarks ?? "";

    selectedDate =
        DateTime.parse(widget.workEntry.workDate);

    workType =
        widget.workEntry.workType;

    manday =
        widget.workEntry.manday;

    loadLabours();
  }

  Future<void> loadLabours() async {

    final result =
        await labourService.getAll();

    selectedLabour = result.firstWhere(

      (e) => e.id == widget.workEntry.labourId,

      orElse: () => result.first,

    );

    setState(() {

      labours = result;

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

  Future<void> updateWorkEntry() async {

    if (selectedLabour == null) return;

    setState(() {

      saving = true;

    });

    await workEntryService.updateWorkEntry(

      id: widget.workEntry.id,

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
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Work Entry"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            DropdownButtonFormField<Labour>(

              value: selectedLabour,

              decoration: const InputDecoration(
                labelText: "Labour",
                border: OutlineInputBorder(),
              ),

              items: labours.map((labour) {

                return DropdownMenuItem<Labour>(
                  value: labour,
                  child: Text(labour.name),
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

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(),
              ),

              title: Text(
                DateFormat("dd MMM yyyy")
                    .format(selectedDate),
              ),

              trailing: const Icon(
                Icons.calendar_month,
              ),

              onTap: pickDate,

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(

              value: workType,

              decoration: const InputDecoration(
                labelText: "Work Type",
                border: OutlineInputBorder(),
              ),

              items: workTypes.map((type) {

                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  workType = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(

              value: manday,

              decoration: const InputDecoration(
                labelText: "Manday",
                border: OutlineInputBorder(),
              ),

              items: mandays.map((type) {

                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
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

              controller: remarksController,

              maxLines: 3,

              decoration: const InputDecoration(
                labelText: "Remarks",
                border: OutlineInputBorder(),
              ),

            ),

            const SizedBox(height: 30),

            SizedBox(

              height: 50,

              child: ElevatedButton(

                onPressed:
                    saving ? null : updateWorkEntry,

                child: saving

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Update Work Entry",
                      ),

              ),

            )

          ],

        ),

      ),

    );

  }

}