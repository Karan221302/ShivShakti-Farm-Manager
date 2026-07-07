class RecentActivity {

  final String type;
  final String title;
  final String subtitle;
  final double amount;

  RecentActivity({

    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,

  });

  factory RecentActivity.fromJson(
      Map<String, dynamic> json) {

    return RecentActivity(

      type: json["type"],

      title: json["title"],

      subtitle: json["subtitle"],

      amount:
          (json["amount"] as num).toDouble(),

    );

  }

}