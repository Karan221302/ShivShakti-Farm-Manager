class InventoryTransaction {

  final String id;

  final String type;

  final double quantity;

  final String remarks;

  final DateTime transactionDate;

  InventoryTransaction({

    required this.id,

    required this.type,

    required this.quantity,

    required this.remarks,

    required this.transactionDate,

  });

  factory InventoryTransaction.fromJson(
      Map<String, dynamic> json) {

    return InventoryTransaction(

      id: json["id"],

      type: json["type"],

      quantity:
          (json["quantity"] as num).toDouble(),

      remarks: json["remarks"],

      transactionDate:
          DateTime.parse(
              json["transactionDate"]),

    );

  }

}