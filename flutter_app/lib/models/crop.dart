class Crop {

  final String id;

  String cropName;

  String variety;

  String sowingDate;

  String expectedHarvestDate;

  String? notes;

  Crop({

    required this.id,

    required this.cropName,

    required this.variety,

    required this.sowingDate,

    required this.expectedHarvestDate,

    this.notes,

  });

  factory Crop.fromJson(
      Map<String, dynamic> json) {

    return Crop(

      id: json["id"],

      cropName: json["cropName"],

      variety: json["variety"],

      sowingDate: json["sowingDate"],

      expectedHarvestDate:
          json["expectedHarvestDate"],

      notes: json["notes"],

    );

  }

}