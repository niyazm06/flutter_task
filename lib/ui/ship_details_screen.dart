import 'package:flutter/material.dart';
import 'package:untitled/core/screen_utils.dart';
import 'package:untitled/model/ship_data.dart';
import 'package:untitled/ui/home_screen.dart';

class ShipDetailScreen extends StatelessWidget {
  final ShipsData? data;

  const ShipDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data!.shipName ?? ''),
        backgroundColor: Colors.blue.shade900,
        centerTitle: false,
      ),
      body: data == null
          ? const CenterLoading()
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              child: Column(
                children: [
                  Image.network(
                    data!.image ?? 'https://i.imgur.com/ngYgFnn.jpg',
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    color: Colors.black,
                    thickness: 4.sp,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data!.shipName ?? 'Marmac 303',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    data!.homePort ?? ' Not available',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  SizedBox(height: 4.h),
                  Divider(
                    color: Colors.black,
                    thickness: 4.sp,
                  ),
                ],
              ),
            ),
    );
  }
}
