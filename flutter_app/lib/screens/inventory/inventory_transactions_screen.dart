import 'package:flutter/material.dart';

import '../../models/inventory_transaction.dart';

import '../../services/inventory_service.dart';

import '../../widgets/inventory_transaction_card.dart';

class InventoryTransactionsScreen
    extends StatefulWidget {

  final String inventoryId;

  const InventoryTransactionsScreen({

    super.key,

    required this.inventoryId,

  });

  @override
  State<InventoryTransactionsScreen>
      createState() =>
          _InventoryTransactionsScreenState();

}

class _InventoryTransactionsScreenState
    extends State<
        InventoryTransactionsScreen> {

  final InventoryService service =
      InventoryService();

  List<InventoryTransaction> transactions = [];

  bool loading = true;

  @override
  void initState() {

    super.initState();

    load();

  }

  Future<void> load() async {

    transactions = await service
        .getTransactions(widget.inventoryId);

    setState(() {

      loading = false;

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
            const Text("Transactions"),

      ),

      body: loading

          ? const Center(

              child:
                  CircularProgressIndicator(),

            )

          : ListView.builder(

              itemCount:
                  transactions.length,

              itemBuilder:

                  (_, index) {

                return InventoryTransactionCard(

                  transaction:
                      transactions[index],

                );

              },

            ),

    );

  }

}