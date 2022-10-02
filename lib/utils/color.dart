import 'package:flutter/material.dart';

const Color _mainColor = Color(0xFFF2B05E);

final int redMainColor = _mainColor.red;
final int greenMainColor = _mainColor.green;
final int blueMainColor = _mainColor.blue;

final Map<int, Color> mainColors = <int, Color>{
  50: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .1,
  ),
  100: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .2,
  ),
  200: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .3,
  ),
  300: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .4,
  ),
  400: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .5,
  ),
  500: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .6,
  ),
  600: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .7,
  ),
  700: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .8,
  ),
  800: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    .9,
  ),
  900: Color.fromRGBO(
    redMainColor,
    greenMainColor,
    blueMainColor,
    1,
  ),
};
