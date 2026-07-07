import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/labour.dart';
import '../../models/labour_payment.dart';
import '../../services/labour_payment_service.dart';
import '../../services/labour_service.dart';

class EditPaymentScreen extends StatefulWidget {
  final LabourPayment payment;

  const EditPaymentScreen({
    super.key,
    required this.payment,
  });

  @override
  State<EditPaymentScreen> createState() =>
      _EditPaymentScreenState();
}

class _EditPaymentScreenState
    extends State<EditPaymentScreen> {

  final LabourPaymentService paymentService =
      LabourPaymentService();

  final LabourService labourService =
      LabourService();

  final amountController =
      TextEditingController();

  final remarksController =
      TextEditingController();

  List<Labour> labours = [];

  Labour? selectedLabour;

  late DateTime paymentDate;

  bool loading = true;

  bool saving = false;

  late String paymentMode;

  final List<String> paymentModes = [
    "CASH",
    "UPI",
    "BANK_TRANSFER",
  ];

  @override
  void initState() {
    super.initState();

    amountController.text =
        widget.payment.amount.toString();

    remarksController.text =
        widget.payment.remarks ?? "";

    paymentDate =
        DateTime.parse(widget.payment.paymentDate);

    paymentMode =
        widget.payment.paymentMode;

    loadLabours();
  }

  Future<void> loadLabours() async {

    try {

      final result =
          await labourService.getAll();

      selectedLabour = result.firstWhere(

        (labour) =>
            labour.id == widget.payment.labourId,

        orElse: () => result.first,

      );

      setState(() {

        labours = result;

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

      initialDate: paymentDate,

      firstDate: DateTime(2020),

      lastDate: DateTime(2035),

    );

    if (picked != null) {

      setState(() {

        paymentDate = picked;

      });

    }

  }

  Future<void> updatePayment() async {

    if (selectedLabour == null) return;

    if (amountController.text.isEmpty) return;

    setState(() {

      saving = true;

    });

    try {

      await paymentService.updatePayment(

        id: widget.payment.id,

        labourId: selectedLabour!.id,

        paymentDate:
            DateFormat("yyyy-MM-dd")
                .format(paymentDate),

        amount:
            double.parse(
                amountController.text),

        paymentMode: paymentMode,

        remarks:
            remarksController.text,

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
          "Edit Payment",
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

                borderRadius:
                    BorderRadius.circular(10),

                side: const BorderSide(),

              ),

              title: Text(

                DateFormat("dd MMM yyyy")
                    .format(paymentDate),

              ),

              trailing:
                  const Icon(Icons.calendar_month),

              onTap: pickDate,

            ),

            const SizedBox(height: 20),

            TextField(

              controller: amountController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(

                labelText: "Amount",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(

              value: paymentMode,

              decoration:
                  const InputDecoration(

                labelText:
                    "Payment Mode",

                border:
                    OutlineInputBorder(),

              ),

              items: paymentModes.map((mode) {

                return DropdownMenuItem(

                  value: mode,

                  child: Text(mode),

                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  paymentMode = value!;

                });

              },

            ),

            const SizedBox(height: 20),

            TextField(

              controller:
                  remarksController,

              maxLines: 3,

              decoration:
                  const InputDecoration(

                labelText: "Remarks",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 30),

            SizedBox(

              height: 50,

              child: ElevatedButton(

                onPressed:
                    saving ? null : updatePayment,

                child: saving

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Update Payment",
                      ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}