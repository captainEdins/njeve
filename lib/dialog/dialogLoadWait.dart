
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:njeve/resources/color.dart';


class DialogLoadWait extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient:  const LinearGradient(
                        colors: [
                          ColorList.white,
                          ColorList.white,
                        ]
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                  child: Column(
                    children: [
                      Text("Almost There",style: TextStyle(
                        color: ColorList.textColor,
                        fontWeight: FontWeight.w900,
                      ),),
                      Text("we are fetch your data",style: TextStyle(
                        color: ColorList.textColor,
                      ),),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: - 50,
                  child: CircleAvatar(
                      backgroundColor: ColorList.white,
                      radius: 50,
                      child: LoadingAnimationWidget.beat(
                        color: ColorList.textColor,
                        size: 100,
                      ),
                  )
              )
            ],
          ),
        );
      }

    }
