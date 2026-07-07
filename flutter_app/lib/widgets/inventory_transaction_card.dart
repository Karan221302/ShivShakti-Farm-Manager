import 'package:flutter/material.dart';

import '../models/inventory_transaction.dart';

class InventoryTransactionCard
    extends StatelessWidget {

  final InventoryTransaction transaction;

  const InventoryTransactionCard({

    super.key,

    required this.transaction,

  });

  @override
  Widget build(BuildContext context) {

    final stockIn =
        transaction.type == "STOCK_IN";

    return Card(

      child: ListTile(

        leading: CircleAvatar(

          backgroundColor:

              stockIn
                  ? Colors.green.shade100
                  : Colors.red.shade100,

          child: Icon(

            stockIn
                ? Icons.add
                : Icons.remove,

            color: stockIn
                ? Colors.green
                : Colors.red,

          ),

        ),

        title: Text(transaction.remarks),

        subtitle: Text(

          transaction.transactionDate
              .toString(),

        ),

        trailing: Text(

          "${stockIn ? "+" : "-"}${transaction.quantity}",

          style: TextStyle(

            fontWeight: FontWeight.bold,

            color:
                stockIn
                    ? Colors.green
                    : Colors.red,

          ),

        ),

      ),

    );

  }

}