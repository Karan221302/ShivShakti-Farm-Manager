import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {

  final IconData icon;

  final String title;

  final VoidCallback onTap;

  const QuickActionButton({

    super.key,

    required this.icon,

    required this.title,

    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,

      child: Column(

        children: [

          CircleAvatar(

            radius: 30,

            backgroundColor: Colors.green,

            child: Icon(

              icon,

              color: Colors.white,

            ),

          ),

          const SizedBox(height: 8),

          Text(title),

        ],

      ),

    );

  }

}