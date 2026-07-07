import '../core/api/api_client.dart';
import '../models/dashboard.dart';
import '../models/profit_response.dart';
import '../models/recent_activity.dart';

class DashboardService {

  Future<Dashboard> getDashboard() async {

    final response =
        await ApiClient.dio.get(
      "/api/dashboard",
    );

    return Dashboard.fromJson(
      response.data,
    );
  }

  Future<ProfitResponse> getProfit() async {

    final response =
        await ApiClient.dio.get(
      "/api/dashboard/profit",
    );

    return ProfitResponse.fromJson(
      response.data,
    );
  }
  Future<List<RecentActivity>> getRecentActivities() async {

  final response =
      await ApiClient.dio.get(
    "/api/dashboard/recent",
  );

  return (response.data as List)

      .map(

        (e) => RecentActivity.fromJson(e),

      )

      .toList();

}
}