import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_finder/Screens/details.dart';
import 'package:fitness_finder/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '../Models/nearbymodel.dart';
import '../Utils/images.dart';

class Home extends StatefulWidget{
 

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 final searchController = TextEditingController();
 List<dynamic> _placesList = [];
 var uuid = Uuid();
 String _sessionToken = '1233';
 String googleAPiKey = "";
  LatLng startLocation = LatLng(0, 0);
  LatLng updateLocation = LatLng(0, 0);
  String startlan= '';
  String startlong= '';
  String pickuplocation = '';
  bool isShow = false;
  List <NearbyPlacesResponse> list=[];
  Completer<GoogleMapController> _controller = Completer();
  NearbyPlacesResponse nearbyPlacesResponse=new NearbyPlacesResponse();
  
   Set<Marker> markers = Set(); 
   static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.65192994, 73.08141522),
    zoom:0,
  );
   GoogleMapController? mapController;
   
  void initState(){
    searchController.addListener((){
      onChanged();
    }
    );
    currentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Stack(
        children: [
           GoogleMap(
              compassEnabled: false,

              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: markers,
               //markers to show on map
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
                        height: 60.h,
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
                              child: SizedBox(
                                width: 300.w,
                                height: 100.h,              
                                child: TextFormField(
                                  maxLines: 1,
                                  
                                  onTap: () {
                                    if(isShow!=true){
                                      setState(() {
                                      isShow=true;
                                    });
                                    }else{
                                      setState(() {
                                      isShow=false;
                                    });
                                    }
                                    
                                  },
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
                            // InkWell(
                            //   onTap: () {
                            //     setState(() {
                            //       isShow=false;
                            //     getNearBylocation(searchController.text);
                            //     });
                            //   },
                            //   child: Icon(Icons.search,))
                          ],
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 24.w,top: 120.h),
                    child: Container(
                      width: 400.w,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() => markers.clear(),);
                                currentLocation();
                                getNearBylocation('Soccer court');
                              },
                              child: Card(
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
                            ),
                            InkWell(
                              onTap: () {
                                setState(() => markers.clear(),);
                                currentLocation();
                                 getNearBylocation('Tennis court');
                              },
                              child: Card(
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
                            ),
                            InkWell(
                              onTap: () {
                                setState(() => markers.clear(),);
                                currentLocation();
                                getNearBylocation('Gym');
                              },
                              child: Card(
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
                              ),
                            ),
                            InkWell(
                              onTap:() {
                                setState(() => markers.clear(),);
                                currentLocation();
                                getNearBylocation('Basketball Court');
                              }, 
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Container(
                                  width: 130.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    color: whiteContainer,
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center ,
                                    children: [
                                     Container(
                                      height: 20.h,width: 20.w,
                                      child: Image.asset(basketball,)),
                                      SizedBox(width: 5.w,),
                                     Text('Basketball',style: TextStyle(
                                      fontSize: 16,
                                     ),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() => markers.clear(),);
                                currentLocation();
                                getNearBylocation('Paddle Court');
                              },
                              child: Card(
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
                                      child: Image.asset(paddle,)),
                                      SizedBox(width: 5.w,),
                                     Text('Paddle',style: TextStyle(
                                      fontSize: 16,
                                     ),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                         
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: whiteContainer,

              onPressed: () async {
                currentLocation();
                setState(() {
                  
                });
              },
              child: Icon(Icons.my_location,color: blackicon,),
            ),
          ),
                  isShow
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 25.w, top: 110.h, right: 25.w),
                        child: Card(
                          elevation: 3,
                          child: SizedBox(
                            height: 500.h,
                            width: 377.w,
                            child: Container(
                                color: whiteContainer,
                                // height: 500,
                                width: 377.w,

                                child: ListView.builder(
                                    itemCount: _placesList.length,
                                    itemBuilder: (context, index) {
                                      //  Marker currentMarker=markers.firstWhere((marker) =>marker.markerId.value=='Current');
                                      return ListTile(
                                        onTap: () async {
                                          var  location =
                                              await locationFromAddress(
                                                  _placesList[index]
                                                      ['description']);
                                          searchController.text=_placesList[index]
                                                      ['description'];
                                          
                                               
                                      
                                          
                                          setState(() {
                                           markers.clear();
                                            
                                           getNearBylocation(_placesList[index]
                                                      ['description']);

                                            isShow = false;
                                            updateLocation = LatLng(
                                                location.last.latitude,
                                                location.last.longitude);

                                                updateMarker();
                                          });
                                      
                                        
                                        },
                                        title: Text(
                                          _placesList[index]['description'],
                                          style: TextStyle(color: blacktext),
                                        ),
                                      );
                                    })),
                          ),
                        ),
                      )
                    : Text('')
                ],
              ), 
    );
  }
  void currentLocation() async {
    getLocation().then((value) async {
      debugPrint('' + value.latitude.toString());
      setState(() {
        
        startLocation = LatLng(value.latitude, value.longitude);
        startlan=startLocation.latitude.toString();
        startlong=startLocation.longitude.toString();
         mapController?.animateCamera( 
        CameraUpdate.newCameraPosition(
              CameraPosition(target: startLocation, zoom: 11) 
              //17 is new zoom level
        )
      );
        markers.add(Marker(
          markerId: MarkerId('Current'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'usercurrent postion'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        ));
      });
      CameraPosition campos = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom:5);

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

    void getNearBylocation(String type) async {
     list.clear();
    String request =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$type&location=$startlan%2C$startlong&radius=10000&type=$type&key=$googleAPiKey';
    print(startLocation);
    var response = await http.get(Uri.parse(request),);
    // var data=response.body.toString()
    var result=jsonDecode(response.body);

         nearbyPlacesResponse = NearbyPlacesResponse.fromJson(jsonDecode(response.body));
      print(nearbyPlacesResponse.results![0].name);
    for(int i=0;i<nearbyPlacesResponse.results!.length; i++){
      double latitude=nearbyPlacesResponse.results![i].geometry!.location!.lat!.toDouble();
      double longitude=nearbyPlacesResponse.results![i].geometry!.location!.lng!.toDouble();
      print(latitude+longitude);
      markers.add( Marker(
        onTap: () {
          print(nearbyPlacesResponse.results![i].openingHours!.openNow);
          Get.to(()=>DetailScreen(
            address:nearbyPlacesResponse.results![i].vicinity.toString(),
            // icon:nearbyPlacesResponse.results![i].icon.toString(),
            name: nearbyPlacesResponse.results![i].name.toString(),
            rating: nearbyPlacesResponse.results![i].rating.toString(),
            ratingtotal: nearbyPlacesResponse.results![i].userRatingsTotal.toString(),
            time: nearbyPlacesResponse.results![i].openingHours!.openNow.toString(),
            ));
        },
    markerId: MarkerId(nearbyPlacesResponse.results![i].placeId.toString()),
    
    position: LatLng(latitude,longitude),
    infoWindow: InfoWindow(title:nearbyPlacesResponse.results![i].name),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
));
      
     
    }
    setState(() {
       
     });
     

    
  }


  void onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(searchController.text);
  }
  void getSuggestion(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$googleAPiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }
  void updateMarker() {
    setState(() {
       mapController?.animateCamera( 
        CameraUpdate.newCameraPosition(
              CameraPosition(target: updateLocation, zoom: 11) 
              //17 is new zoom level
        )
      );
    });
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId('Pickup'),
      position: updateLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed), //Icon for Marker
    ));
  }

}