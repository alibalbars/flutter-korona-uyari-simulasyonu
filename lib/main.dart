
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:control_pad/control_pad.dart';
import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crud.dart';

BitmapDescriptor icon;
String karakter;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatelessWidget {
  addData() {

    Map<String,dynamic> demoData = {"name" : "The Growing Developer",
      "motto" : "Let's learn and grow together"};
    CollectionReference collectionReference = Firestore.instance.collection("path");
    collectionReference.add(demoData);
    print("Firebase ekleme işlemi tamamlandı!!!!!!!!!!!!!!!!!!!1");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/corona-virus.png'),
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Text(
                  'Koronapp',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                onTap: (){
                  addData();
                },
              ),

              SizedBox(
                height: 10,
              ),
              GridView.count(
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: [
                  Card(
                    color: Colors.blueAccent,
                    child: IconButton(
                      icon: Image.asset('assets/character-1.png'),
                      iconSize: 50,
                      onPressed: () {
                        crudMethods().addData();
                        karakter = "karakter_1";
                        BitmapDescriptor.fromAssetImage(
                                ImageConfiguration(size: Size(96, 96)),
                                'assets/character-1.png')
                            .then((onValue) {
                          icon = onValue;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapSample()),
                        );
                      },
                    ),
                  ),
                  Card(
                    color: Colors.blueAccent,
                    child: IconButton(
                      icon: Image.asset('assets/character-2.png'),
                      iconSize: 50,
                      onPressed: () {
                        karakter = "karakter_2";
                        BitmapDescriptor.fromAssetImage(
                                ImageConfiguration(size: Size(96, 96)),
                                'assets/character-2.png')
                            .then((onValue) {
                          icon = onValue;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapSample()),
                        );
                      },
                    ),
                  ),
                  Card(
                    color: Colors.blueAccent,
                    child: IconButton(
                      icon: Image.asset('assets/character-3.png'),
                      iconSize: 50,
                      onPressed: () {
                        karakter = "karakter_3";
                        BitmapDescriptor.fromAssetImage(
                                ImageConfiguration(size: Size(96, 96)),
                                'assets/character-3.png')
                            .then((onValue) {
                          icon = onValue;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapSample()),
                        );
                      },
                    ),
                  ),
                  Card(
                    color: Colors.blueAccent,
                    child: IconButton(
                      icon: Image.asset('assets/character-4.png'),
                      iconSize: 50,
                      onPressed: () {
                        karakter = "karakter_4";
                        BitmapDescriptor.fromAssetImage(
                                ImageConfiguration(size: Size(96, 96)),
                                'assets/character-4.png')
                            .then((onValue) {
                          icon = onValue;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapSample()),
                        );
                      },
                    ),
                  ),
                  Card(
                    color: Colors.blueAccent,
                    child: IconButton(
                      icon: Image.asset('assets/character-5.png'),
                      iconSize: 50,
                      onPressed: () {
                        karakter = "karakter_5";
                        BitmapDescriptor.fromAssetImage(
                                ImageConfiguration(size: Size(96, 96)),
                                'assets/character-5.png')
                            .then((onValue) {
                          icon = onValue;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapSample()),
                        );
                      },
                    ),
                  ),
                  Card(
                    color: Colors.blueAccent,
                    child: IconButton(
                      icon: Image.asset('assets/character-6.png'),
                      iconSize: 50,
                      onPressed: () {
                        karakter = "karakter_6";
                        BitmapDescriptor.fromAssetImage(
                                ImageConfiguration(size: Size(96, 96)),
                                'assets/character-6.png')
                            .then((onValue) {
                          icon = onValue;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapSample()),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition evim = CameraPosition(
    target: LatLng(40.215869704324035, 29.080262165543203),
    zoom: 14.00,
  );

  @override
  Widget build(BuildContext context) {
    List<Marker> allMarkers = [];
    allMarkers.add(Marker(
      markerId: MarkerId('ev'),
      icon: icon,
      position: evim.target,
    ));

    Set<Circle> circles = Set.from([
      Circle(
        circleId: CircleId("ev"),
        center: evim.target,
        radius: 500,
        fillColor: Color.fromRGBO(89, 182, 91, 0.6),
        strokeColor: Color.fromRGBO(0, 0, 0, 0),
      )
    ]);

    Future<void> konumuDegistir(
        double enlem_degisimi, double boylam_degisimi) async {
      final GoogleMapController controller = await _controller.future;

      CameraPosition yeni_konum = CameraPosition(
        target: LatLng(evim.target.latitude + enlem_degisimi,
            evim.target.longitude + boylam_degisimi),
        zoom: 14.00,
      );

      print(
          "Enlem: ${yeni_konum.target.latitude} - Boylam: ${yeni_konum.target.longitude}");

      evim = yeni_konum;

      FirebaseFirestore firestore = FirebaseFirestore.instance;


      controller.animateCamera(CameraUpdate.newCameraPosition(evim));
    }

    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: evim,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition position) {
              Marker updatedMarker = allMarkers[0].copyWith(
                positionParam: evim.target,
                iconParam: icon,
              );
              setState(() {
                allMarkers[0] = updatedMarker;
              });
            },
            markers: Set.from(allMarkers),
            circles: circles,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
              child: Container(
                width: 150,
                height: 150,
                child: JoystickView(
                  onDirectionChanged: (double aci, double mesafe) {
                    var acinin_radyani = aci * pi / 180;
                    var enlem_degisimi = mesafe * cos(acinin_radyani) / 10000;
                    var boylam_degisimi = mesafe * sin(acinin_radyani) / 10000;

                    konumuDegistir(enlem_degisimi, boylam_degisimi);
                  },
                  size: 150,
                  showArrows: false,
                  opacity: 0.8,
                  interval: Duration(seconds: 1),
                  innerCircleColor: Colors.white,
                  backgroundColor: Colors.white38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
