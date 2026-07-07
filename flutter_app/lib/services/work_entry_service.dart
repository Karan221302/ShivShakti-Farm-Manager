import '../core/api/api_client.dart';
import '../models/work_entry.dart';

class WorkEntryService {

  Future<List<WorkEntry>> getAll() async {

    final response =
        await ApiClient.dio.get("/api/work-entries");

    return (response.data as List)
        .map((e) => WorkEntry.fromJson(e))
        .toList();
  }

  Future<void> addWorkEntry({

    required String labourId,

    required String workDate,

    required String workType,

    required String manday,

    String? remarks,

  }) async {

    await ApiClient.dio.post(

      "/api/work-entries",

      data: {

        "labourId": labourId,

        "workDate": workDate,

        "workType": workType,

        "manday": manday,

        "remarks": remarks,

      },

    );

  }
  Future<void> updateWorkEntry({

  required String id,

  required String labourId,

  required String workDate,

  required String workType,

  required String manday,

  String? remarks,

}) async {

  await ApiClient.dio.put(

    "/api/work-entries/$id",

    data: {

      "labourId": labourId,

      "workDate": workDate,

      "workType": workType,

      "manday": manday,

      "remarks": remarks,

    },

  );

}
Future<void> deleteWorkEntry(String id) async {

  await ApiClient.dio.delete(
    "/api/work-entries/$id",
  );

}

}