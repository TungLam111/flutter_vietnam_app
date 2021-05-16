import 'package:flutter/material.dart';
class SquareButton extends StatelessWidget {
  final String type;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  SquareButton({this.type,this.icon,this.iconColor,this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
        width: MediaQuery.of(context).size.width/3.5,
        height: MediaQuery.of(context).size.width/3.5,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Column(
          children: [
            Icon(icon,color: iconColor,size:50),
            SizedBox(height:10),
            Text(type,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),)
          ],
        ),
      ),
    );
  }
}