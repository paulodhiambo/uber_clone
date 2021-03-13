import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/widgets/divider.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "main_screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController googleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //drawer header
              Container(
                height: 170.0,
                child: DrawerHeader(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/user_icon.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Name",
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text("Visit profile"),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
              DividerWidget(),
              SizedBox(
                height: 12.0,
              ),
              //Drawer body
              ListTile(
                leading: Icon(Icons.history),
                title: Text("Ride history"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Visit profile"),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              googleMapController = controller;
            },
          ),
          //Hamburger drawer icon
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                globalKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu_outlined,
                    color: Colors.black,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 270.0,
              width: 299.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Hi there, ",
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    Text(
                      "Where to?",
                      style: GoogleFonts.inter(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("Search drop off location"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add home"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Current home address",
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DividerWidget(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add work"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Current work address",
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
          ),
        ],
      ),
    );
  }
}
