import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/detail.dart';

class DetailCard extends StatelessWidget {
  final Detail detail;
  DetailCard({this.detail});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2,
              height:MediaQuery.of(context).size.width/2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/img11.jpg',fit: BoxFit.cover,)
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 5,),
                Text('MÓN ĂN',style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Text('8.7'),
                Icon(Icons.star,color: Colors.amber,)
              ],
            ),
            Row(
              children: [
                SizedBox(width: 5),
                Expanded(child: Text('Bún đậu Phan Dam Tung Lam',maxLines: 3, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on,color:Colors.blue),
                Text('Lorem ipsum',style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                ),),
                Spacer(),
                Container(
                  child: Card(
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1)
                    ),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      child: Text('\$200', style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                ),
                //SizedBox(width: 5,)
              ],
            ),
            SizedBox(height:10),
          ],
        )
    );
  }
}