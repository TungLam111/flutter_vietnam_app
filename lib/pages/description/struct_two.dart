import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/widgets/square_button.dart';
import 'hardcoded_province.dart';
import 'package:flutter_vietnam_app/models/struct_two_model.dart';
import 'package:flutter_vietnam_app/widgets/another_text_field.dart';
import 'package:flutter_vietnam_app/widgets/drop_down.dart';
import 'package:flutter/cupertino.dart';

class StructTwo extends StatefulWidget {
  @override
  _StructTwoState createState() => _StructTwoState();
}

class _StructTwoState extends State<StructTwo> {
  var _formKey = GlobalKey<FormState>();

  var selectedRange = RangeValues(0, 10);
  var structTwo = StructLocation();
  void showPicker(BuildContext cxt) {
    int n = 0;
    showCupertinoModalPopup(
        context: cxt,
        builder: (_) => Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xff999999), width: 0.0))),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            setState(() {
                              structTwo.province = HardcoredData.provinces[n];
                            });
                            Navigator.pop(cxt);
                          },
                        ),
                        Spacer(),
                        Text('Choose your province'),
                        Spacer(),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(cxt);
                          },
                        ),
                        SizedBox(width: 10)
                      ],
                    ),
                  ),
                  Container(
                      height: 200,
                      child: CupertinoPicker(
                          magnification: 1.2,
                          backgroundColor: Colors.white,
                          itemExtent: 30,
                          scrollController:
                              FixedExtentScrollController(initialItem: 0),
                          onSelectedItemChanged: (value) {
                            print(value);
                            setState(() {
                              n = value;
                            });
                          },
                          children: HardcoredData.provinces
                              .map((e) => Text(e,
                                  style: TextStyle(
                                    fontSize: 18,
                                  )))
                              .toList()))
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.green[400],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  expandedHeight: 200,
                  floating: true,
                  pinned: true,
                  snap: true,
                  elevation: 30,
                  title: Text('Find your destination',style:TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.bold
                  )),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset('assets/images/img2.png',fit:BoxFit.cover),
                  ),
                )
              ];
            },
            body: Container(
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SquareButton(
                              icon: Icons.emoji_transportation_rounded,
                              type: 'Transport',
                              backgroundColor: Colors.blue[100],
                              iconColor: Colors.indigo,
                            ),
                            Spacer(),
                            SquareButton(
                              icon: Icons.hotel,
                              type: 'Accommodation',
                              backgroundColor: Colors.green[100],
                              iconColor: Colors.green,
                            ),
                            Spacer(),
                            SquareButton(
                              icon: Icons.fastfood_rounded,
                              type: 'Food',
                              backgroundColor: Colors.yellow[100],
                              iconColor: Colors.amber,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            'Search Hotel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            'Find hotel as you need with demand',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AnotherTextField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Empty';
                            else {
                              setState(() {
                                structTwo.name = value;
                              });
                              print(value);
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        AnotherTextField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Empty';
                            else {
                              setState(() {
                                structTwo.address = value;
                              });
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Province',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showPicker(context);
                                    },
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
                                              structTwo.province,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tags',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Stack(
                                    children: [
                                      Stack(
                                          fit: StackFit.loose,
                                          children: [AnotherDropDown()]),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Range of Price',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        RangeSlider(
                            values: selectedRange,
                            onChanged: (newRange) {
                              setState(() {
                                selectedRange = newRange;
                              });
                            },
                            min: 0,
                            max: 10,
                            divisions: 10,
                            labels: RangeLabels('${selectedRange.start}',
                                '${selectedRange.end}')),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                print('Success');
                              }
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 15, 50, 15),
                                width: MediaQuery.of(context).size.width - 10,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(width: 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'SEARCH',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
    /*
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
        title: Text(
          'Search Hotels & Rooms',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            child: Container(
              child: Image.asset(
                'assets/images/img2.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 3 +
                  10,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0),
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20))),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SquareButton(
                              icon: Icons.emoji_transportation_rounded,
                              type: 'Transport',
                              backgroundColor: Colors.blue[100],
                              iconColor: Colors.indigo,
                            ),
                            Spacer(),
                            SquareButton(
                              icon: Icons.hotel,
                              type: 'Accommodation',
                              backgroundColor: Colors.green[100],
                              iconColor: Colors.green,
                            ),
                            Spacer(),
                            SquareButton(
                              icon: Icons.fastfood_rounded,
                              type: 'Food',
                              backgroundColor: Colors.yellow[100],
                              iconColor: Colors.amber,
                            ),
                          ],
                        ),
                        SizedBox(height:10),
                        Container(
                          child: Text(
                            'Search Hotel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            'Find hotel as you need with demand',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AnotherTextField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Empty';
                            else {
                              setState(() {
                                structTwo.name = value;
                              });
                              print(value);
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        AnotherTextField(
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Empty';
                            else {
                              setState(() {
                                structTwo.address = value;
                              });
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Province',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showPicker(context);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Container(
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              structTwo.province,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tags',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Stack(
                                    children: [
                                      Stack(
                                          fit: StackFit.loose,
                                          children: [AnotherDropDown()]),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Range of Price',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        RangeSlider(
                            values: selectedRange,
                            onChanged: (newRange) {
                              setState(() {
                                selectedRange = newRange;
                              });
                            },
                            min: 0,
                            max: 10,
                            divisions: 10,
                            labels: RangeLabels('${selectedRange.start}',
                                '${selectedRange.end}')),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                print('Success');
                              }
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 15, 50, 15),
                                width: MediaQuery.of(context).size.width - 10,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(width: 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'SEARCH',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }*/
  }
}