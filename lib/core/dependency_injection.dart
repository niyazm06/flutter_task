import 'package:get_it/get_it.dart';
import 'package:untitled/bloc/ship_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  _blocCubit();
}

void _blocCubit() {
  getItInstance.registerFactory<ShipCubit>(
    () => ShipCubit(),
  );
}
