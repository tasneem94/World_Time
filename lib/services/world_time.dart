import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; // location name for the ui
  String time; //time for that location
  String flag; //url to asset flag icon
  String url; //location url for api endpoint
  bool isDaytime; //true or false whether day time or not

  WorldTime({this.location, this.flag, this.url});


  Future<void> getTime() async
  {
    //make the request
    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;

      //set the time property
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('Caught error: $e');
      time = "Could not set time";
    }


  }


}


