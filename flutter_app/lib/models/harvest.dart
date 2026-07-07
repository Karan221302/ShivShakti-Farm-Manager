class Harvest {

  final String id;

  final String cropId;

  final String cropName;

  String harvestDate;

  double quantity;

  String unit;

  double rate;

  double revenue;

  Harvest({

    required this.id,

    required this.cropId,

    required this.cropName,

    required this.harvestDate,

    required this.quantity,

    required this.unit,

    required this.rate,

    required this.revenue,

  });

  factory Harvest.fromJson(
      Map<String, dynamic> json) {

    return Harvest(

      id: json["id"],

      cropId: json["crop"]["id"],

      cropName: json["crop"]["cropName"],

      harvestDate: json["harvestDate"],

      quantity:
          (json["quantity"] as num).toDouble(),

      unit: json["unit"],

      rate:
          (json["rate"] as num).toDouble(),

      revenue:
          (json["revenue"] as num).toDouble(),

    );

  }

}