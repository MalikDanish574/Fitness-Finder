import 'dart:async';

import 'package:fitness_finder/Screens/details.dart';
import 'package:fitness_finder/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Utils/images.dart';

class Home extends StatefulWidget{
 

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 final searchController = TextEditingController();
  LatLng startLocation = LatLng(0, 0);
  Completer<GoogleMapController> _controller = Completer();

   Set<Marker> markers = Set(); 
   static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.65192994, 73.08141522),
    zoom: 16.4746,
  );
   GoogleMapController? mapController;

  void initState(){
    current();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Stack(
        children: [
           GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              markers: markers, //markers to show on map
              // polylines: Set<Polyline>.of(polylines.values), //polylines
              mapType: MapType.normal, //map type
              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  mapController = controller;
                });
              },
            ),

                 
                  Padding(
                    padding:  EdgeInsets.only(right:24.w,left: 24.w,top: 50.h),
                    child: Card(
                      elevation: 4,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Container(
                        height: 50.h,
                        width: 400.w,
                        decoration: BoxDecoration(
                          color: whiteContainer,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w,),
                             Icon(Icons.location_pin,),
                             SizedBox(width: 10.w,),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                width: 300.w,
                                              
                                child: TextFormField(
                                  controller: searchController ,
                                  keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Search',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: blacktext,
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: blacktext,
                                              fontFamily: 'Montserrat',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                  
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: 24.w,top: 110.h),
                    child: Row(
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            width: 100.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: whiteContainer,
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center ,
                              children: [
                               Container(
                                height: 20.h,width: 20.w,
                                child: Image.asset(soccer,)),
                                SizedBox(width: 5.w,),
                               Text('Soccer',style: TextStyle(
                                fontSize: 16,
                               ),)
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            width: 110.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: whiteContainer,
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center ,
                              children: [
                               Container(
                                height: 30.h,width: 30.w,
                                child: Image.asset(tenis)),
                                SizedBox(width: 5.w,),
                               Text('Tennis',style: TextStyle(
                                fontSize: 16,
                               ),)
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            width: 100.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: whiteContainer,
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center ,
                              children: [
                               Container(
                                height: 30.h,width: 30.w,
                                child: Image.asset(gym,)),
                                SizedBox(width: 5.w,),
                               Text('Gym',style: TextStyle(
                                fontSize: 16,
                               ),)
                              ],
                            ),
                          ),
                        )
                     
                      ],
                    ),
                  )
                ],
              ), 
    );
  }
  void current() async {
    getLocation().then((value) async {
      debugPrint('' + value.latitude.toString());
      setState(() {
        startLocation = LatLng(value.latitude, value.longitude);
        markers.add(Marker(
          onTap: (){
            Get.to(()=>DetailScreen());
          },
          markerId: MarkerId('Current'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'usercurrent postion'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        ));
      });
      CameraPosition campos = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);

      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(campos));
    });
  }

  Future<Position> getLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

}