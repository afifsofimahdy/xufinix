//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ufinix/brand_colors.dart';
import 'package:ufinix/dataprovider/appdata.dart';
import 'package:ufinix/helpers/helpermethods.dart';
//import 'package:ufinix/screens/loginpage.dart';
import 'dart:async';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:ufinix/screens/searchpage.dart';
import 'package:ufinix/styless.dart';
import 'package:ufinix/widgets/BrandDivier.dart';
//import 'dart:io';
import 'package:geolocator/geolocator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void signOut() async {
  _auth.signOut();
}

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double searchSheetHeight = 300;

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;

  var geoLocator = Geolocator();
  Position currentPosition;

  void setupPositionLocater() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

    String address = await HelperMethods.findCordinateAdress(position, context);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Container(
          width: 250,
          color: Colors.white,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 160,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'images/user_icon.png',
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "NAMA MITRA",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Brand-Bold'),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text("Lihat Profile"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                BrandDivider(),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.card_giftcard,
                  ),
                  title: Text("Bebas Order", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text("Pembayaran", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(
                    Icons.history,
                  ),
                  title: Text("Riwayat", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(Icons.contact_support),
                  title: Text("Dukung Kami", style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Tentang Kami", style: kDrawerItemStyle),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(bottom: mapBottomPadding),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;

                setState(() {
                  mapBottomPadding = 270;
                });

                setupPositionLocater();
              },
            ),

            Positioned(
              top: 44,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                            offset: Offset(
                              0.7,
                              0.7,
                            ))
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(Icons.menu),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: searchSheetHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 16.0,
                          spreadRadius: 0.5,
                          offset: Offset(
                            0.7,
                            0.7,
                          ))
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Senang melihat anda ",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Ingin pergi ke- ? ",
                        style:
                            TextStyle(fontSize: 28, fontFamily: 'Brand-Bold'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(
                                      0.7,
                                      0.7,
                                    ))
                              ]),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              Text("Tujuan Anda")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.home,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((Provider.of<AppData>(context)
                                          .pickupAddress !=
                                      null)
                                  ? Provider.of<AppData>(context)
                                      .pickupAddress
                                      .placeName
                                  : "Tambah Rumah"),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Tempat Tinggal Anda",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BrandDivider(),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.workOutline,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Tambah Kantor",
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Tempat Kerja Anda",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // RaisedButton(onPressed: () {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => LoginPage()));
            // })
          ],
        )
        // body: Center(
        //   child: MaterialButton(
        //     onPressed: () {
        //       DatabaseReference dbref =
        //           FirebaseDatabase.instance.reference().child("Tes Koneksi");
        //       dbref.set("IsConnected");
        //     },
        //     height: 50,
        //     minWidth: 300,
        //     color: Colors.green[50],
        //     child: Text("Test Connection"),
        //   ),
        // ),
        );
  }
}
