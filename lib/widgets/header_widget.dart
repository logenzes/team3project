import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:project_flutter/controllers/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String subloc = '';
  String city_sub = '';
  String date = DateFormat("yMMMMd").format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, long) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
      print(placemark);
      Placemark place = placemark[0];
      setState(() {
        city = place.administrativeArea!;
        subloc = place.subLocality!;
        city_sub = '$city $subloc';
        //city = place.locality!;
      });
    } catch (e) {
      print('Address was not retrieved, please fill out manually');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 0),
                alignment: Alignment.topLeft,
                child: Text(
                  city,
                  style: const TextStyle(
                      fontSize: 30, height: 2, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                alignment: Alignment.topLeft,
                child: Text(
                  subloc,
                  style: const TextStyle(
                      fontSize: 30, height: 2, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     city,
        //     style: const TextStyle(
        //         fontSize: 30, height: 2, fontWeight: FontWeight.bold),
        //   ),
        // ),
        // Container(
        //   margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     subloc,
        //     style: const TextStyle(
        //         fontSize: 20, height: 2, fontWeight: FontWeight.bold),
        //   ),
        // ),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
          ),
        )
      ],
    );
  }
}
