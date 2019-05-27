import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft), onPressed: () {}),
        title: Text("nama wilayah"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildcontainer(),
        ],
      ),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
        onPressed: () {
          zoomVal++;
          _plus(zoomVal);
        },
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
        onPressed: () {
          zoomVal--;
          _minus(zoomVal);
        },
      ),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(-6.853571574135314, 107.59486198425294), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(-6.853571574135314, 107.59486198425294), zoom: zoomVal)));
  }

  Widget _buildcontainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes('warung1.jpg',-6.853571574135314, 107.59486198425294, "warung om rudi"),
            ),
          ],
        ),
      ),
    ); 
  }

  Widget _boxes(String _image, double lat, double long, String warungName) {
    return GestureDetector(
      onTap: () {
        _gotLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196f3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(_image),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer(warungName),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer(String warungName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(
              warungName,
              style: TextStyle(
                  color: Color(0xff6200ee),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
          child: Text(
            "bandung",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Text(
            "tutup\u0087 buka 07:00",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _googlemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(-6.853571574135314, 107.59486198425294), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {warung1},
      ),
    );
  }
}

Future<void> _gotLocation(double lat, double long) async {
  var _controller;
    final GoogleMapController controller = await _controller.future;
  controller.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, long),
        zoom: 15,
        tilt: 50.0,
        bearing: 45,
      ),
    ),
  );
}

Marker omRudiMarker = Marker(
  markerId: MarkerId('omrudi'),
  position: LatLng(-6.85132, 107.59247),
  infoWindow: InfoWindow(title: 'warung om rudi'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
);

// Marker omRudiMarker = Marker(
//   markerId: MarkerId('omrudi'),
//   position: LatLng(0,0)
//   infoWindow: InfoWindow(title: 'warung om rudi')
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet
//   ),
// );

// Marker omRudiMarker = Marker(
//   markerId: MarkerId('omrudi'),
//   position: LatLng(0,0)
//   infoWindow: InfoWindow(title: 'warung om rudi')
//   icon: BitmapDescriptor.defaultMarkerWithHue(
//     BitmapDescriptor.hueViolet
//   ),
// );

Marker warung1 = Marker(
  markerId: MarkerId('warung1'),
  position: LatLng(-6.853571574135314, 107.59486198425294),
  infoWindow: InfoWindow(title: 'warung mangadeng'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
