import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:njeve/resources/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color topColor = ColorList.sunColor;

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
                    otherReads()
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
              const Row(
                children: [
                  Text(
                    "Kangemi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorList.backgroundColor,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
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
    return Lottie.asset("lottie/sun.json", width: 350, height: 350);
  }


  Widget feelsLikeTemp(){
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Text(
            "62.3°C",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorList.textColor,
                fontSize: 60),
          ),
          SizedBox(width: 5,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rain, Partially cloudy",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ColorList.textColor,
                    fontSize: 12),
              ),
              Text(
                "Feels Like 60.3°",
                textAlign: TextAlign.center,
                style: TextStyle(
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

  Widget textItems({required String key,required String value}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: ColorList.textColor,
              fontSize: 11),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorList.textColor,
              fontSize: 11),
        )
      ],
    );
  }

  Widget otherReads(){
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                textItems(key: 'Humidity', value: '18%'),
                textItems(key: 'Wind', value: '12km/hr'),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                textItems(key: 'Air Quality', value: '63'),
                textItems(key: 'Visibility', value: '13km'),
              ],
            ),
          ),
        ],
      ),
    );
  }

}