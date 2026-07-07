import '../core/api/api_client.dart';
import '../models/inventory.dart';
import '../models/inventory_transaction.dart';

class InventoryService {

  Future<List<Inventory>> getAll() async {

    final response =
        await ApiClient.dio.get(
      "/api/inventory",
    );

    return (response.data as List)

        .map(
          (e) => Inventory.fromJson(e),
        )

        .toList();

  }

  Future<void> addInventory({

    required String name,

    required String category,

    required String unit,

    required double currentStock,

    required double minimumStock,

    required double purchasePrice,

    double? sellingPrice,

  }) async {

    await ApiClient.dio.post(

      "/api/inventory",

      data: {

        "name": name,

        "category": category,

        "unit": unit,

        "currentStock": currentStock,

        "minimumStock": minimumStock,

        "purchasePrice": purchasePrice,

        "sellingPrice": sellingPrice,

        "active": true,

      },

    );

  }

  Future<void> deleteInventory(
      String id) async {

    await ApiClient.dio.delete(

      "/api/inventory/$id",

    );

  }
Future<void> stockIn({

  required String id,

  required double quantity,

  required String remarks,

}) async {

  await ApiClient.dio.put(

    "/api/inventory/$id/stock-in",

    data: {

      "quantity": quantity,

      "remarks": remarks,

    },

  );

}

Future<void> stockOut({

  required String id,

  required double quantity,

  required String remarks,

}) async {

  await ApiClient.dio.put(

    "/api/inventory/$id/stock-out",

    data: {

      "quantity": quantity,

      "remarks": remarks,

    },

  );

}

Future<Inventory> getInventoryById(
    String id) async {

  final response = await ApiClient.dio.get(
    "/api/inventory/$id",
  );

  return Inventory.fromJson(response.data);

}

Future<List<InventoryTransaction>>
    getTransactions(String id) async {

  final response = await ApiClient.dio.get(

    "/api/inventory/$id/transactions",

  );

  return (response.data as List)

      .map(

        (e) => InventoryTransaction.fromJson(e),

      )

      .toList();

}


Future<void> updateInventory({

  required String id,

  required String name,

  required String category,

  required String unit,

  required double currentStock,

  required double minimumStock,

  required double purchasePrice,

  double? sellingPrice,

}) async {

  await ApiClient.dio.put(

    "/api/inventory/$id",

    data: {

      "name": name,

      "category": category,

      "unit": unit,

      "currentStock": currentStock,

      "minimumStock": minimumStock,

      "purchasePrice": purchasePrice,

      "sellingPrice": sellingPrice,

      "active": true,

    },

  );

}

}