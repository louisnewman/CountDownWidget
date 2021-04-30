import 'dart:async';
import 'package:flutter/material.dart';

//false不开启倒计时
typedef bool Taping();

class CountDownWidget extends StatefulWidget {
  CountDownWidget({this.onTap});

  final Taping onTap;

  CountDownState createState() => CountDownState();
}

class CountDownState extends State<CountDownWidget> {
  int _num;
  Timer _timer;
  String _title;

  @override
    void dispose() {
      super.dispose();
      if(_timer != null){
        _timer.cancel();
        _timer = null;
      }
    }

  @override
    void initState() {
      super.initState();
      _num = 59;
      _title = '获取验证码';
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: _num < 59 ? null : _countDownAction,
        child: Text(_title, style: TextStyle(color: Colors.blue)),
      ),
    );
  }

  void _countDownAction() {

    bool sign = false;

    if(widget.onTap != null) {
      sign = widget.onTap();
    }
    
    if(sign == false) {
      return;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      if(mounted) {
        setState(() {
              if(_num > 0) {
                _title = '${_num--}s后重新获取';
              }else {
                _title = '获取验证码';
                _num = 59;
                _timer.cancel();

              }
            });
      }
    });
  }
}