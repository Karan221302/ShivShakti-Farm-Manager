import '../core/api/api_client.dart';
import '../models/labour_payment.dart';
import '../models/labour_summary.dart';

class LabourPaymentService {

  Future<List<LabourPayment>> getAll() async {

    final response =
        await ApiClient.dio.get(
      "/api/payments",
    );

    return (response.data as List)

        .map(
          (e) =>
              LabourPayment.fromJson(e),
        )

        .toList();

  }

  Future<LabourSummary> getSummary(
      String labourId) async {

    final response =
        await ApiClient.dio.get(
      "/api/payments/summary/$labourId",
    );

    return LabourSummary.fromJson(
      response.data,
    );

  }

  Future<void> addPayment({

    required String labourId,

    required String paymentDate,

    required double amount,

    required String paymentMode,

    String? remarks,

  }) async {

    await ApiClient.dio.post(

      "/api/payments",

      data: {

        "labourId": labourId,

        "paymentDate": paymentDate,

        "amount": amount,

        "paymentMode": paymentMode,

        "remarks": remarks,

      },

    );

  }

  Future<void> updatePayment({

    required String id,

    required String labourId,

    required String paymentDate,

    required double amount,

    required String paymentMode,

    String? remarks,

  }) async {

    await ApiClient.dio.put(

      "/api/payments/$id",

      data: {

        "labourId": labourId,

        "paymentDate": paymentDate,

        "amount": amount,

        "paymentMode": paymentMode,

        "remarks": remarks,

      },

    );

  }

  Future<void> deletePayment(
      String id) async {

    await ApiClient.dio.delete(
      "/api/payments/$id",
    );

  }

}