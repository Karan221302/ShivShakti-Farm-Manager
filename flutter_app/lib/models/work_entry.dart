class WorkEntry {

  final String id;

  final String labourId;

  final String labourName;

  String workDate;

  String workType;

  String manday;

  String? remarks;

  double wageAmount;

  WorkEntry({

    required this.id,

    required this.labourId,

    required this.labourName,

    required this.workDate,

    required this.workType,

    required this.manday,

    this.remarks,

    required this.wageAmount,

  });

  factory WorkEntry.fromJson(Map<String,dynamic> json){

    return WorkEntry(

      id: json["id"],

      labourId: json["labour"]["id"],

      labourName: json["labour"]["name"],

      workDate: json["workDate"],

      workType: json["workType"],

      manday: json["manday"],

      remarks: json["remarks"],

      wageAmount:
          (json["wageAmount"] as num).toDouble(),

    );

  }

}