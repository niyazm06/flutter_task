import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/ship_cubit.dart';
import 'package:untitled/core/dependency_injection.dart';
import 'package:untitled/core/screen_utils.dart';
import 'package:untitled/model/ship_data.dart';
import 'package:untitled/ui/list_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ship Data'),
        backgroundColor: Colors.blue.shade900,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 4.h,
        ),
        child: _body(context),
      ),
    );
  }

  _body(context) {
    final cubit = getItInstance<ShipCubit>();
    return BlocBuilder<ShipCubit, List<ShipsData>>(
      bloc: cubit..getRockets(),
      builder: (_, state) {
        return state.isEmpty
            ? const CenterLoading()
            : ListView.separated(
                itemBuilder: (_, i) => ListItem(
                  name: state[i].shipName!,
                  image: state[i].image!,
                  portName: state[i].homePort!,
                  year: state[i].yearBuilt!.toString(),
                  id: state[i].shipId!,
                  onTap: () {
                    cubit.getShipDetails(context, state[i].shipId!);
                  },
                ),
                separatorBuilder: (_, i) => const Divider(),
                itemCount: state.length,
              );
      },
    );
  }
}

class CenterLoading extends StatelessWidget {
  const CenterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
      ),
    );
  }
}
