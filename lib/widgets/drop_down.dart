import 'package:flutter/material.dart';
class AnotherDropDown extends StatefulWidget {
  @override
  _AnotherDropDownState createState() => _AnotherDropDownState();
}

class _AnotherDropDownState extends State<AnotherDropDown> {
  String temp='Select tag';
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(left:10),
      width: MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>
        (
          hint: Text(temp,style: TextStyle(color:Colors.black, fontSize: 20)),
          items: ['Foodstore','Coffee shop','Hotel'].map((value){
          return DropdownMenuItem<String>
          (
            value:value,
            child: Text(value,style: TextStyle(color:Colors.black, fontSize: 18),));
        }).toList(),
        onChanged: (_){
          setState(() {
            temp=_;        
          });
          print(temp);
        },
        onTap: (){},
        ),
      ),
    );
  }
}