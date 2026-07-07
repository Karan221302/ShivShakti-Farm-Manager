class Dashboard {

  final int totalLabours;

  final int totalCrops;

  final int totalHarvests;

  final int totalWorkEntries;

  final double totalExpenses;

  final double totalRevenue;

  final double totalWagesEarned;

  final double totalPaymentsMade;

  final double totalPendingPayments;

  final double netProfit;

  Dashboard({

    required this.totalLabours,

    required this.totalCrops,

    required this.totalHarvests,

    required this.totalWorkEntries,

    required this.totalExpenses,

    required this.totalRevenue,

    required this.totalWagesEarned,

    required this.totalPaymentsMade,

    required this.totalPendingPayments,

    required this.netProfit,

  });

  factory Dashboard.fromJson(
      Map<String, dynamic> json) {

    return Dashboard(

      totalLabours: json["totalLabours"],

      totalCrops: json["totalCrops"],

      totalHarvests: json["totalHarvests"],

      totalWorkEntries: json["totalWorkEntries"],

      totalExpenses:
          (json["totalExpenses"] as num).toDouble(),

      totalRevenue:
          (json["totalRevenue"] as num).toDouble(),

      totalWagesEarned:
          (json["totalWagesEarned"] as num).toDouble(),

      totalPaymentsMade:
          (json["totalPaymentsMade"] as num).toDouble(),

      totalPendingPayments:
          (json["totalPendingPayments"] as num).toDouble(),

      netProfit:
          (json["netProfit"] as num).toDouble(),

    );

  }

}