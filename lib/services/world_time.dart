import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{

  String location;  //location name for ui
  String time; //time in that location;
  String flag; // url to asset flag icon
  String url; //location url for api endpoint
  bool isDaytime;//true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

   try{
     //make the request
     Response response = await get('http://worldtimeapi.org/api/timezone/$url');
     Map data = jsonDecode(response.body);
     //print(data);

     //get properties from data
     String datetime = data['datetime'];
     String offset = data['utc_offset'].substring(0,3);
     String mins;
     if(offset[0].compareTo('+')==0 || data['utc_offset'].substring(4,6)=='00'){
      mins = data['utc_offset'].substring(4,6);
     }
     else if(offset[0].compareTo('-')==0){
       mins = '-' + data['utc_offset'].substring(4,6);
     }
    print(data['utc_offset']);
    print(offset);

     // create DateTime object
     DateTime now = DateTime.parse(datetime);
     now = now.add(Duration(hours:int.parse(offset),minutes: int.parse(mins)));

     //set the time property
     isDaytime = now.hour > 6 && now.hour < 19 ? true : false;
     time = DateFormat.jm().format(now);


   }

   catch(e){
     print('caught error: $e');
     time = 'could not get time data';
   }

  }

}

