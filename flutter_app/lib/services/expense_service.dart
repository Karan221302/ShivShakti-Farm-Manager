import '../core/api/api_client.dart';
import '../models/expense.dart';

class ExpenseService {

  Future<List<Expense>> getAll() async {

    final response =
        await ApiClient.dio.get("/api/expenses");

    return (response.data as List)
        .map((e) => Expense.fromJson(e))
        .toList();

  }

  Future<void> addExpense({

    required String expenseDate,

    required double amount,

    required String category,

    required String paymentMode,

    String? description,

  }) async {

    await ApiClient.dio.post(

      "/api/expenses",

      data: {

        "expenseDate": expenseDate,

        "amount": amount,

        "category": category,

        "paymentMode": paymentMode,

        "description": description,

      },

    );

  }

  Future<void> updateExpense({

  required String id,

  required String expenseDate,

  required double amount,

  required String category,

  required String paymentMode,

  String? description,

}) async {

  await ApiClient.dio.put(

    "/api/expenses/$id",

    data: {

      "expenseDate": expenseDate,

      "amount": amount,

      "category": category,

      "paymentMode": paymentMode,

      "description": description,

    },

  );

}

Future<void> deleteExpense(
    String id) async {

  await ApiClient.dio.delete(
    "/api/expenses/$id",
  );

}

}