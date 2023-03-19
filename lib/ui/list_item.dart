import 'package:flutter/material.dart';
import 'package:untitled/core/screen_utils.dart';

class ListItem extends StatelessWidget {
  final String image;
  final String name;
  final String portName;
  final String year;
  final String id;
  final GestureTapCallback? onTap;

  const ListItem({
    Key? key,
    required this.image,
    required this.name,
    required this.portName,
    required this.year,
    required this.id,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.network(
              image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          portName,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          id,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.black,
                              ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 8.w,
                    ),
                    child: Text(
                      year,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
