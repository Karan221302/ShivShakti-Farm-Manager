import 'package:flutter/material.dart';

import '../models/labour.dart';
import '../screens/payment/labour_summary_screen.dart';

class LabourCard extends StatelessWidget {
  final Labour labour;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const LabourCard({
    super.key,
    required this.labour,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LabourSummaryScreen(
              labour: labour,
            ),
          ),
        );
      },

      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        elevation: 2,

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Row(
                children: [

                  const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          labour.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Text(
                          labour.village,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 15),

              Text(
                "📞 ${labour.mobile}",
              ),

              const SizedBox(height: 6),

              Text(
                "💰 Daily Wage : ₹${labour.dailyWage.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Divider(height: 30),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: [

                  OutlinedButton.icon(
                    onPressed: onEdit,

                    icon: const Icon(Icons.edit),

                    label: const Text("Edit"),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    onPressed: onDelete,

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    icon: const Icon(
                      Icons.block,
                      color: Colors.white,
                    ),

                    label: const Text(
                      "Disable",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}