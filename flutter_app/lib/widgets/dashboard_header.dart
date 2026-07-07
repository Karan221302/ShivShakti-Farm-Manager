import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {

  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {

    return const Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(

          "👋 Good Morning",

          style: TextStyle(

            fontSize: 18,

          ),

        ),

        SizedBox(height: 8),

        Text(

          "ShivShakti Farm Manager",

          style: TextStyle(

            fontSize: 28,

            fontWeight: FontWeight.bold,

          ),

        ),

      ],

    );

  }

}