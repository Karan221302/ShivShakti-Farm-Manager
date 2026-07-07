class LabourSummary {

  final String labourName;

  final double earnedAmount;

  final double paidAmount;

  final double pendingAmount;

  LabourSummary({

    required this.labourName,

    required this.earnedAmount,

    required this.paidAmount,

    required this.pendingAmount,

  });

  factory LabourSummary.fromJson(
      Map<String, dynamic> json) {

    return LabourSummary(

      labourName: json["labourName"],

      earnedAmount:
          (json["earnedAmount"] as num)
              .toDouble(),

      paidAmount:
          (json["paidAmount"] as num)
              .toDouble(),

      pendingAmount:
          (json["pendingAmount"] as num)
              .toDouble(),

    );

  }

}