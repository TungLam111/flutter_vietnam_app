/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'Component11.dart';
void main(){
  runApp(MaterialApp(
    home:GooglePixel51(),
  ));
}
class GooglePixel51 extends StatelessWidget {
  const GooglePixel51({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 393.0,
          height: 851.0,
          child: Column(
            children: <Widget>[
              Container(
                width: 393.0,
                height: 262.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Spacer(flex: 22),
              Align(
                alignment: Alignment(-0.91, 0.0),
                child: SizedBox(
                  width: 393.0,
                  height: 30.0,
                  child: Row(
                    children: <Widget>[
                      Spacer(flex: 12),
                      SvgPicture.string(
                        // Icon material-location-on
                        '<svg viewBox="12.0 284.0 21.0 30.0" ><path transform="translate(4.5, 281.0)" d="M 18 3 C 12.19499969482422 3 7.5 7.695000171661377 7.5 13.5 C 7.5 21.375 18 33 18 33 C 18 33 28.5 21.375 28.5 13.5 C 28.5 7.695000171661377 23.80500030517578 3 18 3 Z M 18 17.25 C 15.93000030517578 17.25 14.25 15.56999969482422 14.25 13.5 C 14.25 11.43000030517578 15.93000030517578 9.75 18 9.75 C 20.06999969482422 9.75 21.75 11.43000030517578 21.75 13.5 C 21.75 15.56999969482422 20.06999969482422 17.25 18 17.25 Z" fill="#6b4c4c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        width: 21.0,
                        height: 30.0,
                      ),
                      Spacer(flex: 6),
                      Align(
                        alignment: Alignment(0.0, 0.33),
                        child: Text(
                          'Quảng Nam',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(flex: 244),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 9),
              Align(
                alignment: Alignment(-0.91, 0.0),
                child: SizedBox(
                  width: 393.0,
                  height: 27.0,
                  child: Row(
                    children: <Widget>[
                      Spacer(flex: 12),
                      SvgPicture.string(
                        // Icon awesome-place-of-worship
                        '<svg viewBox="12.0 326.74 21.0 19.53" ><path transform="translate(12.0, 326.74)" d="M 20.36376762390137 13.97962856292725 L 16.80000114440918 12.20429611206055 L 16.80000114440918 19.52682495117188 L 20.47500038146973 19.52682495117188 C 20.76506233215332 19.52682495117188 21 19.25375747680664 21 18.9166145324707 L 21 15.1012716293335 C 21 14.61317348480225 20.74976539611816 14.17199993133545 20.36378860473633 13.97963905334473 Z M 0 15.1012716293335 L 0 18.9166145324707 C 0 19.25375747680664 0.2349375188350677 19.52682495117188 0.5250000357627869 19.52682495117188 L 4.200000286102295 19.52682495117188 L 4.200000286102295 12.20429611206055 L 0.6362344026565552 13.97962856292725 C 0.2502546310424805 14.1719799041748 9.234746357833501e-06 14.61314678192139 0 15.1012716293335 Z M 15.24009418487549 9.408003807067871 L 13.65000057220459 8.298946380615234 L 13.65000057220459 3.914201498031616 C 13.65000057220459 3.590408325195313 13.53942203521729 3.280344724655151 13.34222030639648 3.051134586334229 L 10.87110996246338 0.1789484620094299 C 10.66603183746338 -0.05941512435674667 10.33364200592041 -0.05941512435674667 10.12889099121094 0.1789484620094299 L 7.657781600952148 3.051134586334229 C 7.460906505584717 3.279963493347168 7.34999942779541 3.590408325195313 7.34999942779541 3.914201498031616 L 7.34999942779541 8.298946380615234 L 5.759905815124512 9.408004760742188 C 5.443574905395508 9.628513336181641 5.250004768371582 10.02579021453857 5.25 10.45451831817627 L 5.25 19.52682495117188 L 8.40000057220459 19.52682495117188 L 8.40000057220459 15.86556148529053 C 8.40000057220459 14.51737594604492 9.34040641784668 13.42471694946289 10.5 13.42471694946289 C 11.65959453582764 13.42471694946289 12.60000038146973 14.51737594604492 12.60000038146973 15.86556148529053 L 12.60000038146973 19.52682495117188 L 15.75000095367432 19.52682495117188 L 15.75000095367432 10.45451736450195 C 15.75000095367432 10.02584457397461 15.55640697479248 9.628443717956543 15.24009418487549 9.408004760742188 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        width: 21.0,
                        height: 19.53,
                      ),
                      Spacer(flex: 6),
                      Text(
                        'Destination',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(flex: 250),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 16),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 383.0,
                  height: 53.0,
                  child: Stack(
                    children: <Widget>[
                      Text(
                        'Phố cổ Hội An',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 40.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: 383.0,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 383.0,
                  height: 20.0,
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment(-0.05, 0.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiusmod tempor \nincididunt ut labore et dolore magna \naliqua. Ut enim ad minim veniam, \nquis nostrud exercitation ullamco \nlaboris nisi ut aliquip ex ea commodo \nconsequat.',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 383.0,
                  height: 20.0,
                  color: Colors.white,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 373.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xFF8E7D7D),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF707070),
                  ),
                ),
                child: SizedBox(
                  width: 373.0,
                  height: 40.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment(-0.06, -0.38),
                        width: 187.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          border: Border.all(
                            width: 1.0,
                            color: const Color(0xFF707070),
                          ),
                        ),
                        child: Text(
                          'Photos',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(flex: 52),
                      Align(
                        alignment: Alignment(0.0, -0.38),
                        child: Text(
                          'Related',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(flex: 66),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 20),
              SizedBox(
                width: 393.0,
                height: 100.5,
                child: Row(
                  children: <Widget>[
                    Spacer(flex: 17),
                    const Component11(),
                    Spacer(flex: 28),
                    const Component11(),
                    Spacer(flex: 28),
                    const Component11(),
                    Spacer(flex: 17),
                  ],
                ),
              ),
              Spacer(flex: 42),
            ],
          ),
        ),
      ),
    );
  }
}
*/
