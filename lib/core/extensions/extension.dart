import 'package:flutter/material.dart';

extension Navigation on BuildContext{
  Future<dynamic>pushNamed ({required String routeName})
  {
    return Navigator.pushNamed(this, routeName);
  }
  Future<dynamic>pushReplacementNamed ({required String routeName})
  {
    return Navigator.pushReplacementNamed(this, routeName);
  }
  Future<dynamic>pushNamedAndRemoveUntil ({required String routeName})
  {
    return Navigator.pushNamedAndRemoveUntil(this, routeName,(route)=>false);
  }
  Future<dynamic>push ({ required Widget widget})
  {
    return Navigator.push(this, MaterialPageRoute(builder: (_) {
      return widget;
    },));
  }
  void pop ()
  {
     Navigator.pop(this);
  }


}