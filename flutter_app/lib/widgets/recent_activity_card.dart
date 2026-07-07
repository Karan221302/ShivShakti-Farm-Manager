import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {

  final IconData icon;

  final String title;

  final String subtitle;

  final String amount;

  const RecentActivityCard({

    super.key,

    required this.icon,

    required this.title,

    required this.subtitle,

    required this.amount,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        leading: CircleAvatar(

          child: Icon(icon),

        ),

        title: Text(title),

        subtitle: Text(subtitle),

        trailing: Text(

          amount,

          style: const TextStyle(

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

    );

  }

}