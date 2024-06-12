import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:njeve/dialog/dialogGood.dart';
import 'package:njeve/dialog/dialogLoadWait.dart';
import 'package:njeve/resources/color.dart';
import 'package:njeve/resources/string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color topColor = ColorList.sunColor;
  var weatherIcon = "lottie/sun.json";

  //this are the default values as the data loads for the first time but the next time will load on cached data
  var region = "Kangemi";
  var temperature = "62.3";
  var condition = "Rain, Partially cloudy";
  var feel = "60.6";
  var humidity = "18";
  var wind = "12";
  var airQuality = "63";
  var visibility = "13";

  //this are the default values as the data loads for the first time but the next time will load on cached data

  @override
  void initState() {
    super.initState();
    checkLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorList.backgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    stops: const [0.2, 1.0],
                    colors: [topColor, ColorList.backgroundColor])),
          ),
          Column(
            children: [
              topBar(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    iconLottie(),
                    feelsLikeTemp(),
                    const SizedBox(
                      height: 13,
                    ),
                    otherReads(),
                    // listHourReadings()
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget topBar() {
    var timeNow = DateTime.now().hour;
    var date = DateTime.now();

    return Container(
      padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: MediaQuery.of(context).viewPadding.top > 0 ? 35 : 5),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    region,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorList.backgroundColor,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.arrow_outward_rounded,
                    color: ColorList.backgroundColor,
                    size: 20,
                  )
                ],
              ),
              Text(
                DateFormat('d MMMM, EEEE').format(date),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorList.backgroundColor,
                    fontSize: 10),
              ),
            ],
          )),
          const Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.bar_chart_rounded,
                color: ColorList.backgroundColor,
                size: 35,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget iconLottie() {
    return Lottie.asset(weatherIcon, width: 350, height: 350);
  }

  Widget feelsLikeTemp() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Text(
            "$temperature°C",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorList.textColor,
                fontSize: 60),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                condition,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ColorList.textColor,
                    fontSize: 12),
              ),
              Text(
                "Feels like $feel°",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ColorList.textColor,
                    fontSize: 10),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget textItems({required String key, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: ColorList.textColor,
              fontSize: 12),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: ColorList.textColor,
              fontSize: 12),
        )
      ],
    );
  }

  Widget otherReads() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: IntrinsicWidth(
                child: Column(
                  children: [
                    textItems(key: 'Humidity', value: '$humidity%'),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(height: 1, color: ColorList.cardTestColor),
                    const SizedBox(
                      height: 5,
                    ),
                    textItems(key: 'Wind', value: '${wind}km/hr'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(width: 1, color: ColorList.cardTestColor),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: IntrinsicWidth(
                child: Column(
                  children: [
                    textItems(key: 'Air Quality', value: airQuality),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(height: 1, color: ColorList.cardTestColor),
                    const SizedBox(
                      height: 5,
                    ),
                    textItems(key: 'Visibility', value: '${visibility}km'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //sun_min_fill -- sun
  //cloud_sun_fill -- sun and clouds
  //cloud_sun_rain_fill -- sun and rain
  //cloud_moon_rain_fill -- moon and rain
  //cloud_moon_fill -- moon and clouds
  //cloud_fill -- clouds

  Widget listHourReadings() {
    return Column(
      children: [hourReadings()],
    );
  }

  Widget hourReadings() {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: ColorList.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.sun_min_fill,
            color: ColorList.sunColor,
            size: 40,
          ),
          Text(
            "60.3°",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorList.textColor,
                fontSize: 14),
          ),
          Text(
            "11am",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorList.textColor,
                fontSize: 11),
          ),
        ],
      ),
    );
  }

  //get the current location

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlertDialogGood(
          title: "Error!",
          buttonOk: buttonErrorSuccessful(takeMessage: "Error!"),
          message: "Location services are disabled.");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        showAlertDialogGood(
            title: "Error!",
            buttonOk: buttonErrorSuccessful(takeMessage: "Error!"),
            message: "Location services are denied.");

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showAlertDialogGood(
          title: "Error!",
          buttonOk: buttonErrorSuccessful(takeMessage: "Error!"),
          message:
              "Location permissions are permanently denied, we cannot request permissions. Go to setting and activate the permission from there.");

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  showAlertDialogGood(
      {required String message,
      required Widget buttonOk,
      required String title}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogGood(
          message: message,
          title: title,
          buttons: buttonOk,
        );
      },
    );
  }

  Widget buttonErrorSuccessful({required String takeMessage}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color:
                    takeMessage == 'Success!' ? ColorList.green : ColorList.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'ok',
                style: TextStyle(
                  color: ColorList.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //convert the lat and long to name address

  getPlaceName() async {
    showAlertDialog();

    try {


      Position position = await determinePosition();

      final latitude = position.latitude;
      final longitude = position.longitude;

      List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);


      final countryName = placeMarks[0].country;
      final placeName =  placeMarks[0].subLocality;
      print(countryName);
      print(placeName);

      setState(() {
        region = placeName.toString();
      });


      Map<String, String> data = {
        'unitGroup': 'us',
        'key': Strings.key,
      };


      final getUrl = Uri.parse('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${placeName.toString()} ${countryName.toString()}%2CK');

      print(getUrl);

      final uri = getUrl.replace(queryParameters: data);

      var response = await http.get(uri);

      var jsonResponse = json.decode(response.body.toString());

      print(jsonResponse);


      String jsonString = jsonEncode(jsonResponse);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('data', jsonString);

     // topColor
      setState(() {

         var icon = jsonResponse["days"][0]["icon"].toString();
         if(icon == "rain"){
           weatherIcon = "lottie/rain.json";
         }


         temperature = jsonResponse["days"][0]["temp"].toString();
         condition = jsonResponse["days"][0]["conditions"].toString();
         feel = jsonResponse["days"][0]["feelslikemin"].toString();
         humidity = jsonResponse["days"][0]["humidity"].toString();
         wind = jsonResponse["days"][0]["windspeed"].toString();
         airQuality = jsonResponse["days"][0]["dew"].toString();
         visibility = jsonResponse["days"][0]["visibility"].toString();
      });


      Navigator.pop(context);

    } catch (error) {

      Navigator.pop(context);
      print(error);
    }
  }

  //get the current location

  //know i start fetching the data from my api

  checkLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final getForecast = prefs.getString('data') ?? '';

    if (getForecast.isEmpty) {
      getPlaceName();
    }else{
      getPlaceName();
    }
  }

  fetchDataFromAPI() {}

  showAlertDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogLoadWait();
      },
    );
  }
}
