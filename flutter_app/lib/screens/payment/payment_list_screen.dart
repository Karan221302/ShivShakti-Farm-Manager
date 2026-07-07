import 'package:flutter/material.dart';

import '../../models/labour_payment.dart';
import '../../services/labour_payment_service.dart';
import '../../widgets/labour_payment_card.dart';
import 'add_payment_screen.dart';
import 'edit_payment_screen.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() =>
      _PaymentListScreenState();
}

class _PaymentListScreenState
    extends State<PaymentListScreen> {

  final LabourPaymentService paymentService =
      LabourPaymentService();

  final TextEditingController searchController =
      TextEditingController();

  List<LabourPayment> payments = [];

  List<LabourPayment> filteredPayments = [];

  bool loading = true;

  double totalPaid = 0;

  @override
  void initState() {
    super.initState();
    loadPayments();
  }

  Future<void> loadPayments() async {

    try {

      final result =
          await paymentService.getAll();

      setState(() {

        payments = result;

        filteredPayments = result;

        totalPaid = result.fold(
          0,
          (sum, item) => sum + item.amount,
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

      filteredPayments = payments.where((payment) {

        return payment.labourName
                .toLowerCase()
                .contains(value.toLowerCase()) ||

            payment.paymentMode
                .toLowerCase()
                .contains(value.toLowerCase()) ||

            (payment.remarks ?? "")
                .toLowerCase()
                .contains(value.toLowerCase());

      }).toList();

    });

  }

  Future<void> openAddPayment() async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const AddPaymentScreen(),

      ),

    );

    if (result == true) {

      loadPayments();

    }

  }

  Future<void> openEditPayment(
      LabourPayment payment) async {

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            EditPaymentScreen(
              payment: payment,
            ),

      ),

    );

    if (result == true) {

      loadPayments();

    }

  }

  Future<void> deletePayment(
      LabourPayment payment) async {

    final confirm = await showDialog<bool>(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text(
          "Delete Payment",
        ),

        content: Text(
          "Delete payment of ${payment.labourName}?",
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

    await paymentService.deletePayment(
      payment.id,
    );

    loadPayments();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Labour Payments",
        ),

      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: openAddPayment,

        child: const Icon(Icons.add),

      ),

      body: loading

          ? const Center(

              child:
                  CircularProgressIndicator(),

            )

          : RefreshIndicator(

              onRefresh: loadPayments,

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

                            "Total Paid",

                            style: TextStyle(
                              fontSize: 18,
                            ),

                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(

                            "₹${totalPaid.toStringAsFixed(2)}",

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
                            "Search Payment",

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
                        filteredPayments.isEmpty

                            ? ListView(

                                children: const [

                                  SizedBox(
                                      height:
                                          200),

                                  Center(

                                    child: Text(

                                      "No Payments Found",

                                      style:
                                          TextStyle(
                                        fontSize:
                                            18,
                                      ),

                                    ),

                                  ),

                                ],

                              )

                            : ListView.builder(

                                itemCount:
                                    filteredPayments
                                        .length,

                                itemBuilder:
                                    (context,
                                        index) {

                                  final payment =
                                      filteredPayments[
                                          index];

                                  return LabourPaymentCard(

                                    payment:
                                        payment,

                                    onEdit: () {

                                      openEditPayment(
                                          payment);

                                    },

                                    onDelete: () {

                                      deletePayment(
                                          payment);

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