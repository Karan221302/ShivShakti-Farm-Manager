class Labour {
  final String id;
  String name;
  String mobile;
  String village;
  double dailyWage;
  bool active;

  Labour({
    required this.id,
    required this.name,
    required this.mobile,
    required this.village,
    required this.dailyWage,
    required this.active,
  });

  factory Labour.fromJson(Map<String, dynamic> json) {
    return Labour(
      id: json["id"],
      name: json["name"],
      mobile: json["mobile"] ?? "",
      village: json["village"] ?? "",
      dailyWage: (json["dailyWage"] as num).toDouble(),
      active: json["active"] ?? true,
    );
  }
}