class LabourPayment {

  final String id;

  final String labourId;

  final String labourName;

  String paymentDate;

  double amount;

  String paymentMode;

  String? remarks;

  LabourPayment({

    required this.id,

    required this.labourId,

    required this.labourName,

    required this.paymentDate,

    required this.amount,

    required this.paymentMode,

    this.remarks,

  });

  factory LabourPayment.fromJson(
      Map<String, dynamic> json) {

    return LabourPayment(

      id: json["id"],

      labourId: json["labour"]["id"],

      labourName: json["labour"]["name"],

      paymentDate: json["paymentDate"],

      amount:
          (json["amount"] as num).toDouble(),

      paymentMode: json["paymentMode"],

      remarks: json["remarks"],

    );

  }

}