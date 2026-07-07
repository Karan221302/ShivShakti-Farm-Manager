import 'package:flutter/material.dart';

import '../../models/labour.dart';
import '../../models/labour_summary.dart';
import '../../services/labour_payment_service.dart';
import 'add_payment_screen.dart';

class LabourSummaryScreen extends StatefulWidget {

  final Labour labour;

  const LabourSummaryScreen({
    super.key,
    required this.labour,
  });

  @override
  State<LabourSummaryScreen> createState() =>
      _LabourSummaryScreenState();
}

class _LabourSummaryScreenState
    extends State<LabourSummaryScreen> {

  final LabourPaymentService paymentService =
      LabourPaymentService();

  LabourSummary? summary;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSummary();
  }

  Future<void> loadSummary() async {

    try {

      final result =
          await paymentService.getSummary(
              widget.labour.id);

      setState(() {

        summary = result;

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

  Widget moneyCard(

    String title,

    double value,

    Color color,

  ) {

    return Card(

      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),

      child: ListTile(

        title: Text(title),

        trailing: Text(

          "₹${value.toStringAsFixed(2)}",

          style: TextStyle(

            fontWeight: FontWeight.bold,

            fontSize: 18,

            color: color,

          ),

        ),

      ),

    );

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
          "Labour Summary",
        ),

      ),

      floatingActionButton:

          FloatingActionButton.extended(

        onPressed: () async {

          final result =
              await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const AddPaymentScreen(),

            ),

          );

          if (result == true) {

            loadSummary();

          }

        },

        icon: const Icon(Icons.payments),

        label: const Text("Pay"),

      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            Card(

              child: Padding(

                padding:
                    const EdgeInsets.all(20),

                child: Column(

                  children: [

                    const CircleAvatar(

                      radius: 35,

                      child: Icon(

                        Icons.person,

                        size: 40,

                      ),

                    ),

                    const SizedBox(height: 15),

                    Text(

                      summary!.labourName,

                      style: const TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(height: 20),

            moneyCard(

              "Earned Amount",

              summary!.earnedAmount,

              Colors.blue,

            ),

            moneyCard(

              "Paid Amount",

              summary!.paidAmount,

              Colors.green,

            ),

            moneyCard(

              "Pending Amount",

              summary!.pendingAmount,

              Colors.red,

            ),

          ],

        ),

      ),

    );

  }

}