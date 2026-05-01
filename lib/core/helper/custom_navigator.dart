import 'package:flutter/material.dart';

enum NavigatorType { push, pushReplacement, pushAndRemoveUntil}

goTo(context, Widget destination, [NavigatorType type = NavigatorType.push]) {
  if(type == NavigatorType.pushReplacement){
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => destination)
    );
  }
  else if(type == NavigatorType.pushAndRemoveUntil){
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => destination),
            (route) => false
    );
  }
  else{
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => destination)
    );
  }

}