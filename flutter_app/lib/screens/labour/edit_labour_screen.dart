import 'package:flutter/material.dart';

import '../../models/labour.dart';
import '../../services/labour_service.dart';

class EditLabourScreen extends StatefulWidget {
  final Labour labour;

  const EditLabourScreen({
    super.key,
    required this.labour,
  });

  @override
  State<EditLabourScreen> createState() => _EditLabourScreenState();
}

class _EditLabourScreenState extends State<EditLabourScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _name;
  late TextEditingController _mobile;
  late TextEditingController _village;
  late TextEditingController _wage;

  final LabourService labourService = LabourService();

  bool saving = false;

  @override
  void initState() {
    super.initState();

    _name = TextEditingController(text: widget.labour.name);
    _mobile = TextEditingController(text: widget.labour.mobile);
    _village = TextEditingController(text: widget.labour.village);
    _wage = TextEditingController(
      text: widget.labour.dailyWage.toString(),
    );
  }

  Future<void> updateLabour() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => saving = true);

    try {
      widget.labour.name = _name.text;
      widget.labour.mobile = _mobile.text;
      widget.labour.village = _village.text;
      widget.labour.dailyWage = double.parse(_wage.text);

      await labourService.updateLabour(widget.labour);

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
      setState(() => saving = false);
    }
  }

  Widget field(
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
        title: const Text("Edit Labour"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              field("Name", _name),
              field(
                "Mobile",
                _mobile,
                keyboard: TextInputType.phone,
              ),
              field("Village", _village),
              field(
                "Daily Wage",
                _wage,
                keyboard: TextInputType.number,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      saving ? null : updateLabour,
                  child: saving
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Update Labour"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}