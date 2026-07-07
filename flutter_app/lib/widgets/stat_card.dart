import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.06),

            blurRadius: 10,

            offset: const Offset(0,4),

          )

        ],

      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          CircleAvatar(

            backgroundColor: color.withOpacity(.15),

            child: Icon(

              icon,

              color: color,

            ),

          ),

          const Spacer(),

          Text(

            value,

            style: const TextStyle(

              fontSize: 24,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height: 6),

          Text(

            title,

            style: TextStyle(

              color: Colors.grey.shade600,

            ),

          ),

        ],

      ),

    );

  }

}