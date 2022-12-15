<<<<<<< HEAD
import 'dart:developer';
import 'dart:ui';

=======
>>>>>>> main
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:get/get.dart';
import 'package:project_flutter/controllers/global_controller.dart';
import 'package:project_flutter/widgets/current_weather_widget.dart';
import 'package:project_flutter/widgets/header_widget.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loding extends StatefulWidget {
  const Loding({Key? key}) : super(key: key);
  @override
  _LodingState createState() => _LodingState();
}

class _LodingState extends State<Loding> {
  int _selectedIndex = 0;
  int pageIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  //-----------------------------------------------
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  //-----------------------------------------------
  final RxBool _isLoading = true.obs;
    //-------------------------------------
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Menu',
      style: optionStyle,
    ),
    Text(
      'Index 1: 알림',
      style: optionStyle,
    ),
    Text(
      'Index 2: My page',
      style: optionStyle,
    ),
  ];
  // ignore: prefer_final_fields
  //boxShadow: [
  //          BoxShadow(
  //            color: Colors.grey,
  //            blurRadius: 5.0,
  //            spreadRadius: 3.0,
  //          ),
  //        ],
  List<Widget> _demo = [
    Container(
      padding: EdgeInsets.all(75),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black, style: BorderStyle.solid, width: 5),
          image: DecorationImage(
              alignment: Alignment.centerLeft,
              image: AssetImage('assets/images/resizedsensor.png'),
              fit: BoxFit.scaleDown),
          borderRadius: BorderRadius.circular(15),
          color: Colors.red),
      child: Text('Sensor',
          style: TextStyle(color: Colors.black, fontSize: 25),
          textAlign: TextAlign.center),
      height: 200,
    ),
    Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black, style: BorderStyle.solid, width: 5),
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage('assets/images/cctv1.png'),
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Text('Camera',
          style: TextStyle(color: Colors.black, fontSize: 25),
          textAlign: TextAlign.center),
      height: 200,
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage('assets/images/plus.png'),
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue),
      child: Text('기기등록',
          style: TextStyle(color: Colors.black, fontSize: 25),
          textAlign: TextAlign.center),
      height: 200,
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage('assets/images/plus.png'),
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.green),
      child: Text('기기등록',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          textAlign: TextAlign.center),
      height: 200,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff1160aa)), //보류 (필요없을거같음)
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
                            
                )
                
      //--------------------------------
            :Center(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    CarouselIndicator(
                      count: _demo.length,
                      index: pageIndex,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        '우리집 수호천사',
                        style: TextStyle(
                            color: Color(0xff1160aa),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15,
                    ),
                    const HeaderWidget(),
                          CurrentWeatherWidget(
                            weatherDataCurrent:
                                globalController.getWeatherData().getCurrentWeather(),
                          ),
                    
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        print('기기등록');
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: PageView(
                          children: _demo,
                          onPageChanged: (index) {
                            setState(() {
                              pageIndex = index;
                            });
                          },
                        ),
                      ),
                    )
                    
                  ]),
            ),
        ),
      ),
      bottomNavigationBar: 
          BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff1160aa),
        onTap: _onItemTapped,
      ),
    );
  }
}
