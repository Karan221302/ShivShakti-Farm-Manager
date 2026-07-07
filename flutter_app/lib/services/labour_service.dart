import '../core/api/api_client.dart';
import '../models/labour.dart';

class LabourService {

  // Get all labours
  Future<List<Labour>> getAll() async {

    final response =
        await ApiClient.dio.get("/api/labours");

    return (response.data as List)
        .map((e) => Labour.fromJson(e))
        .toList();
  }

  // Add Labour
  Future<void> addLabour({
    required String name,
    required String mobile,
    required String village,
    required double wage,
  }) async {

    await ApiClient.dio.post(
      "/api/labours",
      data: {
        "name": name,
        "mobile": mobile,
        "village": village,
        "dailyWage": wage,
        "active": true,
      },
    );
  }

  // Update Labour
  Future<void> updateLabour(
      Labour labour,
      ) async {

    await ApiClient.dio.put(
      "/api/labours/${labour.id}",
      data: {
        "name": labour.name,
        "mobile": labour.mobile,
        "village": labour.village,
        "dailyWage": labour.dailyWage,
        "active": labour.active,
      },
    );
  }

  // Disable Labour
  Future<void> disableLabour(
      String id,
      ) async {

    await ApiClient.dio.delete(
      "/api/labours/$id",
    );
  }

}