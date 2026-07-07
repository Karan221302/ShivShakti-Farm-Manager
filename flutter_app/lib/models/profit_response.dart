class CropRevenue {

  final String cropName;

  final double revenue;

  CropRevenue({

    required this.cropName,

    required this.revenue,

  });

  factory CropRevenue.fromJson(Map<String, dynamic> json) {

    return CropRevenue(

      cropName: json["cropName"],

      revenue: (json["revenue"] as num).toDouble(),

    );

  }
}

class ProfitResponse {

  final double totalRevenue;

  final double totalExpenses;

  final double netProfit;

  final List<CropRevenue> cropWiseRevenue;

  ProfitResponse({

    required this.totalRevenue,

    required this.totalExpenses,

    required this.netProfit,

    required this.cropWiseRevenue,

  });

  factory ProfitResponse.fromJson(Map<String, dynamic> json) {

    return ProfitResponse(

      totalRevenue:
          (json["totalRevenue"] as num).toDouble(),

      totalExpenses:
          (json["totalExpenses"] as num).toDouble(),

      netProfit:
          (json["netProfit"] as num).toDouble(),

      cropWiseRevenue:
          (json["cropWiseRevenue"] as List)
              .map(
                (e) => CropRevenue.fromJson(e),
              )
              .toList(),

    );
  }
}