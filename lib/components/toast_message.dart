import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

Function buildMyToastMessage({Color color, String text}) {
  return BotToast.showText(
    contentColor: color,
    text: text,
    animationDuration: Duration(milliseconds: 750),
    animationReverseDuration: Duration(milliseconds: 750),
    duration: Duration(milliseconds: 1500),
  );
}
