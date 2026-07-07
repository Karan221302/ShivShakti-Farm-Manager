class Inventory {

  final String id;

  final String name;

  final String category;

  final String unit;

  final double currentStock;

  final double minimumStock;

  final double purchasePrice;

  final double? sellingPrice;

  final bool active;

  Inventory({

    required this.id,

    required this.name,

    required this.category,

    required this.unit,

    required this.currentStock,

    required this.minimumStock,

    required this.purchasePrice,

    this.sellingPrice,

    required this.active,

  });

  factory Inventory.fromJson(
      Map<String, dynamic> json) {

    return Inventory(

      id: json["id"],

      name: json["name"],

      category: json["category"],

      unit: json["unit"],

      currentStock:
          (json["currentStock"] as num).toDouble(),

      minimumStock:
          (json["minimumStock"] as num).toDouble(),

      purchasePrice:
          (json["purchasePrice"] as num).toDouble(),

      sellingPrice:
          json["sellingPrice"] == null
              ? null
              : (json["sellingPrice"] as num)
                  .toDouble(),

      active: json["active"],

    );

  }

}