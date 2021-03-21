import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';

typedef StringCallback = String Function(String value);

class AnotherTextField extends StatelessWidget {
  final StringCallback validator;
  final bool obscureText;
  AnotherTextField({this.validator, this.obscureText: false});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
                obscureText: obscureText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 20),
                validator: validator)));
  }
}

class OnTapField extends AnotherTextField {
  final VoidCallback onTap;
  OnTapField({this.onTap, StringCallback validator, bool obscureText})
      : super(obscureText: obscureText, validator: validator);
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
                onTap: onTap,
                obscureText: obscureText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 20),
                validator: validator)));
  }
}

class StreamField extends StatelessWidget {
  final StreamController<String> stringStream;
  final VoidCallback callback;
  StreamField({this.stringStream, this.callback});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stringStream.stream,
      builder: (context, snapshot) {
        if(stringStream.isClosed&&snapshot.data!=null){
          return GestureDetector(
                  onTap: callback,
                  child: Container(
                      decoration: BoxDecoration(
                      border: Border.all(width: 0),
                      borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            snapshot.data,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )),
                );
        }
        if(snapshot.data!=null){
          print('Farrr ${snapshot.data}');
          stringStream.sink.add(snapshot.data);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (snapshot.data != null)
            print(snapshot.data);
          else
            print('Fuck up');
          print('Waiting');
        }
        if ((snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active)) {
          if (snapshot.data != null)
            return Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: callback,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            snapshot.data,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )),
                ));
          else
            print('Fuck up again');
        }
        return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0),
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
              onTap: callback,
              child: Container(
                  padding: EdgeInsets.all(4),
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        'None',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )),
            ));
      },
    );
  }
}