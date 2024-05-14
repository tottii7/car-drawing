import 'dart:ffi';

import 'package:arduino_app/screens/arduino_page.dart';
import 'package:arduino_app/screens/connection_page.dart';
import 'package:arduino_app/screens/servo_page.dart';
import 'package:arduino_app/screens/speed_page.dart';
import 'package:arduino_app/screens/switch_test.dart';
import 'package:arduino_app/screens/team_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kdgaugeview/kdgaugeview.dart';

class Control_Page extends StatefulWidget {
  static String id = 'Control_Page';

  @override
  State<Control_Page> createState() => _Control_PageState();
}

class _Control_PageState extends State<Control_Page> {
  double _currentSpeed = 100.0;
  bool isPressedRight = false;
  bool isPressedUp = false;
  bool isPressedDown = false;
  bool isPressedLeft = false;
  bool isOn = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      isPressedUp = true;
      isOn = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      isPressedUp = false;
      isOn = false;
    });
  }

  void _handleTapDown2(TapDownDetails details) {
    setState(() {
      isPressedLeft = true;
      isOn = true;
    });
  }

  void _handleTapUp2(TapUpDetails details) {
    setState(() {
      isPressedLeft = false;
      isOn = false;
    });
  }

  void _handleTapDown3(TapDownDetails details) {
    setState(() {
      isPressedRight = true;
      isOn = true;
    });
  }

  void _handleTapUp3(TapUpDetails details) {
    setState(() {
      isPressedRight = false;
      isOn = false;
    });
  }

  void _handleTapDown4(TapDownDetails details) {
    setState(() {
      isPressedDown = true;
      isOn = true;
    });
  }

  void _handleTapUp4(TapUpDetails details) {
    setState(() {
      isPressedDown = false;
      isOn = false;
    });
  }

  final databaseReference = FirebaseDatabase.instance.reference();

  void _updateCarState(int direction) {
    setState(() {
      databaseReference.child('esp').set({'direction': direction});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Arduino_Page.id);
              },
              icon: Icon(Icons.home),
              iconSize: 45.sp,
            ),
            SizedBox(
              width: 70.sp,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Team_Page.id);
              },
              icon: Icon(Icons.people_outline),
              iconSize: 45.sp,
            ),
            SizedBox(
              width: 70.sp,
            ),
            IconButton(
              color: Color.fromARGB(255, 242, 244, 245),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return SpeedometerScreen();
                // },
                //));
              },
              icon: Icon(Icons.control_camera_sharp),
              iconSize: 45.sp,
            ),
          ],
        ),
        height: 75.h,
        color: Colors.black87,
        padding: EdgeInsets.symmetric(horizontal: 19),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('assets/images/backgr.png'),
                fit: BoxFit.cover),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.sp,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 38, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.keyboard_double_arrow_left),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Control The Robot',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              SpeedMotor(),
              // InkWell(
              //   onLongPress: () {},
              //   highlightColor: Colors.amber,
              //   splashColor: Colors.amber,
              //   overlayColor: MaterialStatePropertyAll(Colors.amber),
              //   focusColor: Colors.amber,
              //   hoverColor: Colors.amber,
              //   onTap: () {},
              //   child: Image.asset('assets/images/speed.png'),
              // ),
              SizedBox(
                height: 40.h,
              ),

              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedUp = !isPressedUp;
                  });
                  if (isPressedUp == true) {
                    setState(() {
                      _updateCarState(1);
                    });
                  } else {
                    setState(() {
                      isPressedUp = false;
                      _updateCarState(0);
                    });
                  }
                },
                onLongPressUp: () {
                  setState(() {
                    isPressedUp = !isPressedUp;
                  });
                  if (isPressedUp == true) {
                    setState(() {
                      _updateCarState(1);
                    });
                  } else {
                    setState(() {
                      isPressedUp = false;
                      _updateCarState(0);
                    });
                  }
                },
                child: Stack(
                  children: [
                    Image.asset(
                      isPressedUp
                          ? 'assets/images/up2.png'
                          : 'assets/images/uppp.png',
                    ),
                    Positioned(
                      child: Image.asset('assets/images/up.png'),
                      top: 20.h,
                      left: 80.w,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  // SizedBox(
                  //   width: 25.sp,
                  // ),
                  Spacer(),
                  GestureDetector(
                    onTapDown: (details) {
                      setState(() {
                        isPressedLeft = !isPressedLeft;
                      });
                      if (isPressedLeft == true) {
                        setState(() {
                          _updateCarState(3);
                        });
                      } else {
                        setState(() {
                          isPressedLeft = false;
                          _updateCarState(0);
                        });
                      }
                    },

                    onLongPressUp: () {
                      setState(() {
                        isPressedLeft = !isPressedLeft;
                      });
                      if (isPressedLeft == true) {
                        setState(() {
                          _updateCarState(3);
                        });
                      } else {
                        setState(() {
                          isPressedLeft = false;
                          _updateCarState(0);
                        });
                      }
                    },
                    // onTapDown: _handleTapDown2,
                    // onTapUp: _handleTapUp2,
                    // onLongPressDown: (details) => _updateCarState(3),
                    // onLongPressUp: () => _updateCarState(0),
                    child: Stack(
                      children: [
                        Image.asset(
                          isPressedLeft
                              ? 'assets/images/left2.png'
                              : 'assets/images/left.png',
                        ),
                        Positioned(
                          child: Image.asset('assets/images/arrow_left.png'),
                          top: 80.h,
                          left: 20.w,
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 10.sp,
                  // ),
                  Spacer(),
                  ImageSwitch(),

                  // SizedBox(
                  //   width: 10.sp,
                  // ),
                  Spacer(),
                  GestureDetector(
                    onTapDown: (details) {
                      setState(() {
                        isPressedRight = !isPressedRight;
                      });
                      if (isPressedRight == true) {
                        setState(() {
                          _updateCarState(4);
                        });
                      } else {
                        setState(() {
                          isPressedRight = false;
                          _updateCarState(0);
                        });
                      }
                    },

                    onLongPressUp: () {
                      setState(() {
                        isPressedRight = !isPressedRight;
                      });
                      if (isPressedRight == true) {
                        setState(() {
                          _updateCarState(4);
                        });
                      } else {
                        setState(() {
                          isPressedRight = false;
                          _updateCarState(0);
                        });
                      }
                    },
                    // onTapDown: _handleTapDown3,
                    // onTapUp: _handleTapUp3,
                    // onLongPressDown: (details) => _updateCarState(4),
                    // onLongPressUp: () => _updateCarState(0),
                    child: Stack(
                      children: [
                        Image.asset(
                          isPressedRight
                              ? 'assets/images/right2.png'
                              : 'assets/images/right.png',
                        ),
                        Positioned(
                          child: Image.asset('assets/images/arrow_right.png'),
                          top: 80.h,
                          left: 25.w,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),

                  // Container(

                  //   child: Image.asset('assets/images/right.png'),
                  // ),
                ],
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedDown = !isPressedDown;
                  });
                  if (isPressedDown == true) {
                    setState(() {
                      _updateCarState(2);
                    });
                  } else {
                    setState(() {
                      isPressedDown = false;
                      _updateCarState(0);
                    });
                  }
                },

                onLongPressUp: () {
                  setState(() {
                    isPressedDown = !isPressedDown;
                  });
                  if (isPressedDown == true) {
                    setState(() {
                      _updateCarState(2);
                    });
                  } else {
                    setState(() {
                      isPressedDown = false;
                      _updateCarState(0);
                    });
                  }
                },
                // onTapDown: _handleTapDown4,
                // onTapUp: _handleTapUp4,
                // onLongPressDown: (details) => _updateCarState(2),
                // onLongPressUp: () => _updateCarState(0),
                child: Stack(
                  children: [
                    Image.asset(
                      isPressedDown
                          ? 'assets/images/down2.png'
                          : 'assets/images/down.png',
                    ),
                    Positioned(
                      child: Image.asset('assets/images/arrow_down.png'),
                      top: 35.h,
                      left: 80.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.sp,
              )
              // Container(
              //   child: Image.asset('assets/images/down.png'),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
