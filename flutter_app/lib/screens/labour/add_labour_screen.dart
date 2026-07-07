import 'package:flutter/material.dart';

import '../../services/labour_service.dart';

class AddLabourScreen extends StatefulWidget {
  const AddLabourScreen({super.key});

  @override
  State<AddLabourScreen> createState() => _AddLabourScreenState();
}

class _AddLabourScreenState extends State<AddLabourScreen> {

  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _village = TextEditingController();
  final _wage = TextEditingController();

  final LabourService labourService = LabourService();

  bool saving = false;

  Future<void> saveLabour() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() => saving = true);

    try {

      await labourService.addLabour
      (
        name: _name.text,
        mobile: _mobile.text,
        village: _village.text,
        wage: double.parse(_wage.text),
      );

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

    }

    if (mounted) {
      setState(() => saving = false);
    }
  }

  Widget buildField(
      String label,
      TextEditingController controller, {
        TextInputType keyboard = TextInputType.text,
      }) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Labour"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              buildField("Name", _name),

              buildField(
                "Mobile",
                _mobile,
                keyboard: TextInputType.phone,
              ),

              buildField("Village", _village),

              buildField(
                "Daily Wage",
                _wage,
                keyboard: TextInputType.number,
              ),

              const SizedBox(height: 20),

              SizedBox(

                width: double.infinity,

                height: 50,

                child: ElevatedButton(

                  onPressed: saving ? null : saveLabour,

                  child: saving
                      ? const CircularProgressIndicator()
                      : const Text("Save Labour"),

                ),

              )

            ],

          ),

        ),

      ),

    );
  }
}