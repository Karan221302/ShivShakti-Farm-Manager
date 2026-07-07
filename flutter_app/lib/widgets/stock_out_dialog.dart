import 'package:flutter/material.dart';

class StockOutDialog extends StatefulWidget {
  const StockOutDialog({super.key});

  @override
  State<StockOutDialog> createState() =>
      _StockOutDialogState();
}

class _StockOutDialogState
    extends State<StockOutDialog> {

  final quantityController = TextEditingController();
  final remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text("Stock Out"),

      content: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          TextField(

            controller: quantityController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(

              labelText: "Quantity",

            ),

          ),

          const SizedBox(height: 15),

          TextField(

            controller: remarksController,

            decoration: const InputDecoration(

              labelText: "Remarks",

            ),

          ),

        ],

      ),

      actions: [

        TextButton(

          onPressed: () {

            Navigator.pop(context);

          },

          child: const Text("Cancel"),

        ),

        ElevatedButton(

          onPressed: () {

            Navigator.pop(

              context,

              {

                "quantity": double.parse(
                  quantityController.text,
                ),

                "remarks": remarksController.text,

              },

            );

          },

          child: const Text("Save"),

        ),

      ],

    );

  }

}