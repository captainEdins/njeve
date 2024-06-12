
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:njeve/dialog/dialogGood.dart';
import 'package:njeve/resources/color.dart';
import 'package:njeve/resources/string.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  var bottomBackground = ColorList.backgroundColor;
  var titleColor = ColorList.cloudColor;
  var moreColor = ColorList.nightColor;
  var activeDot = ColorList.cloudColor;
  var notActiveDot = ColorList.nightColor;
  bool nextPage = false;

  late AssetImage assetImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      pageList("Rained when we said it would? Now that's good!","No more weather woes, with ${Strings.appName} the forecast flows!",0),
      pageList("Sunshine's gleam, or stormy stream","${Strings.appName} knows the weather scene. Easy to use, clear and bright, ${Strings.appName} makes planning a delight.",1),
      pageList("Don't get caught in a downpour's frown","${Strings.appName}'s weather keeps you crown Prepared for all, with a smile so wide, with ${Strings.appName}, by your side!",2),
    ];

    return Scaffold(
      backgroundColor: ColorList.backgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                  height: ((MediaQuery.of(context).size.height * 3) / 4) - 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/black_happy_people.jpg'),
                    ),
                  ))),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                "images/landing_bottom.png",
                color: bottomBackground,
              )),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                child: Center(
                  child: Column(
                    children: [

                      SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect:  WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: activeDot,
                          dotColor: notActiveDot,
                          type: WormType.thin,
                          // strokeWidth: 5,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 240,
                        child: PageView.builder(
                          controller: controller,
                          onPageChanged: (indexed){
                            var index = indexed % pages.length;
                            setState(() {

                              if(index == 2){
                                nextPage = true;
                              }else{
                                nextPage = false;
                              }

                              bottomBackground = index == 1 ? ColorList.nightColor : index == 2 ? ColorList.cloudColor : ColorList.backgroundColor;
                              titleColor = index == 1 ? ColorList.cloudColor : index == 2 ? ColorList.backgroundColor : ColorList.cloudColor;
                              moreColor = index == 1 ? ColorList.backgroundColor : index == 2 ? ColorList.backgroundColor : ColorList.nightColor;
                              activeDot = index == 1 ? ColorList.cloudColor : index == 2 ? ColorList.backgroundColor : ColorList.cloudColor;
                              notActiveDot = index == 1 ? ColorList.backgroundColor : index == 2 ? ColorList.nightColor : ColorList.nightColor;
                            });
                          },
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget buttonSkip() {
    return Visibility(
      visible: nextPage,
      child: InkWell(
        onTap: (){
          checkLocationPermissionAndOpen();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorList.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: ColorList.cloudColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkLocationPermissionAndOpen() async {

    var locationStatus = await Permission.location.status;

    if(locationStatus.isGranted){

    }else{
      showAlertDialogGood(buttonOk: buttonOk(),title: "Info!",message: "Thanks for your interest in Njeve! To experience the app's full functionality, allowing location access is the last step. This helps ${Strings.appName} provide accurate weather updates for your area.");
    }

  }

  Widget pageList(String title, String more, int index) {

    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                  fontSize: 22),
            ),
            Text(
              more,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: moreColor,
                  fontSize: 13),
            ),
            buttonSkip()
          ],
        ),
      ),
    );
  }

  showAlertDialogGood({required String message, required Widget buttonOk, required String title}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogGood(message: message, title: title,buttons: buttonOk,);
      },
    );
  }

  Widget buttonOk() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorList.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorList.grey,width: 1)
              ),
              child: const Text(
                'cancel',
                style: TextStyle(
                  color: ColorList.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
          child: InkWell(
            onTap: () async {

              Navigator.of(context, rootNavigator: true).pop();
              
              //make the request


            },
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorList.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'ok',
                style: TextStyle(
                  color: ColorList.backgroundColor,
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


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      showAlertDialogGood(title: "Error!", buttonOk: buttonErrorSuccessful(takeMessage: "Error!"), message: "Location services are disabled.");
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

        showAlertDialogGood(title: "Error!", buttonOk: buttonErrorSuccessful(takeMessage: "Error!"), message: "Location services are denied.");

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showAlertDialogGood(title: "Error!", buttonOk: buttonErrorSuccessful(takeMessage: "Error!"), message: "Location permissions are permanently denied, we cannot request permissions. Go to setting and activate the permission from there.");


      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  
}
