import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/api_repository/repository.dart';
import 'package:untitled/helper/db_helper.dart';
import 'package:untitled/model/ship_data.dart';
import 'package:untitled/ui/ship_details_screen.dart';

class ShipCubit extends Cubit<List<ShipsData>> {
  ShipCubit() : super([]);
  ApiRepository repository = ApiRepository();
  ShipsData? shipsData;
  var db = DatabaseHelper.instance;

  getRockets() async {
    emit([]);
    db.deleteData();
    try {
      List<ShipsData> list = [];
      final shipList = await repository.getAllShips();
      if (shipList.isNotEmpty) {
        list.addAll(shipList);
      }

      await db.addShipData(list);

      final items = await db.getShipDataFromDb();

      if (items.isNotEmpty) {
        emit(items);
      }
    } catch (e) {
      rethrow;
    }
  }

  getShipDetails(context, String shipId) async {
    try {
      final response = await repository.getShipDetails(shipId);
      shipsData = response;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShipDetailScreen(
            data: shipsData,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
