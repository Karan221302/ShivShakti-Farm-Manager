class Expense {

  final String id;

  String expenseDate;

  double amount;

  String category;

  String paymentMode;

  String? description;

  Expense({

    required this.id,

    required this.expenseDate,

    required this.amount,

    required this.category,

    required this.paymentMode,

    this.description,

  });

  factory Expense.fromJson(
      Map<String, dynamic> json) {

    return Expense(

      id: json["id"],

      expenseDate: json["expenseDate"],

      amount:
          (json["amount"] as num).toDouble(),

      category: json["category"],

      paymentMode: json["paymentMode"],

      description: json["description"],

    );

  }

}