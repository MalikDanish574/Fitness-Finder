import 'package:fitness_finder/Utils/Colors.dart';
import 'package:fitness_finder/Utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget{

  String name;
  String ratingtotal;
  String rating;
  String address;
  String time;
  String icon;

  DetailScreen({
    required this.name,
    required this.rating,
    required this.address,
    required this.time,
    required this.ratingtotal,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greybg,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.h),
        child: Column(children: [
           SizedBox(height: 50.h,),
          Row(
            children: [
             
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back)),
            ],
          ),
           SizedBox(height: 30.h,),
          Image.asset(logo),
           SizedBox(height: 50.h,),

          Text(
            name,style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),
          ),
      
           SizedBox(height: 20.h,),
          Row(
            children: [
              Icon(Icons.location_pin,size: 30,),
              SizedBox(width: 15.w,),
              Container(
                child:ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 30,
                    maxHeight: 100,
                    minWidth: 270,
                    maxWidth: 270
                  ),
                   child: Text(address,style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal
                          ),),
                )
               
              )
            ],
          ),

          SizedBox(height: 20.h,),
          Row(
            children: [
              Icon(Icons.timelapse_sharp,size: 30,),
              SizedBox(width: 15.w,),
              Text(time,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),)
            ],
          ),
          SizedBox(height: 20.h,),
      
          Row(
            children: [
              Icon(Icons.star_rate_rounded,size: 30,),
              SizedBox(width: 15.w,),
              Text(rating,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),)
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Icon(Icons.star_rate_rounded,size: 30,),
              SizedBox(width: 15.w,),
              Text("User Total Rating:"+ratingtotal,
              style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.normal
            ),)
              
            ],
          )
        ]),
      ),
    );
  }

}