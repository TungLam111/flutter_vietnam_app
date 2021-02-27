import 'package:flutter/material.dart';

class AddPeople extends StatefulWidget {
  @override
  _AddPeopleState createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 540, width: MediaQuery.of(context).size.width ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearch(),
                _buildCreateNewGroup(),
                Container(
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Column(children: [
                      Text("Gợi ý:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      
                    ])),
                _buildRecommendation()
              ],
            ));
  }

  Widget _buildSearch() {
    return Column(
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(child: Icon(Icons.clear), onTap: (){
              Navigator.pop(context);
            })
        ],),
        Container(
      height: 40,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200])),
          hintText: "Gửi đến:",
          hintStyle: TextStyle(color: Colors.grey[500]),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: EdgeInsets.only(left: 20),
        ),
      ),
    )
      ]
    );
  }

  _buildCreateNewGroup() {
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  CircleAvatar(
                      backgroundColor: Colors.grey,
                      child:
                          Icon(Icons.people_alt_rounded, color: Colors.white)),
                  SizedBox(width: 10),
                  Text("Tạo một nhóm mới")
                ]),
                Icon(Icons.arrow_forward_ios_rounded, size: 10)
              ],
            )));
  }

  _buildRecommendation() {
    return Container(
      //color: Colors.red,
     // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Expanded(
            child: GridView.builder(
            //    primary: false,
           //     shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                itemCount: 8,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10.0,
                 //   mainAxisSpacing: 5.0,
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                     String image = "assets/images/avt3.jpeg";
                  return GestureDetector(
                    child: Container(
                     //   padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(image),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text("@phandamtunglam", style: TextStyle(color: Colors.grey[300], fontSize: 12, fontStyle: FontStyle.italic)),
                              Text("PhamBinhMinh",style: TextStyle(fontSize: 13))
                            ],)
                          ],
                        )),
                    onTap: () {},
                  );
                })));
  }
}
