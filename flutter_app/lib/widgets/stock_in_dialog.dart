import 'package:flutter/material.dart';

class StockInDialog extends StatefulWidget {

  const StockInDialog({super.key});

  @override
  State<StockInDialog> createState() =>
      _StockInDialogState();

}

class _StockInDialogState
    extends State<StockInDialog> {

  final quantityController =
      TextEditingController();

  final remarksController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text("Stock In"),

      content: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          TextField(

            controller: quantityController,

            keyboardType:
                TextInputType.number,

            decoration:

                const InputDecoration(

              labelText: "Quantity",

            ),

          ),

          const SizedBox(height: 15),

          TextField(

            controller: remarksController,

            decoration:

                const InputDecoration(

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

                "quantity":

                    double.parse(
                      quantityController.text,
                    ),

                "remarks":
                    remarksController.text,

              },

            );

          },

          child: const Text("Save"),

        ),

      ],

    );

  }

}