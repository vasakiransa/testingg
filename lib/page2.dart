import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cng/booking_screen.dart';
import 'package:cng/car_registration_screen.dart';
import 'package:cng/detailed_screen.dart';
import 'package:cng/main_screen.dart';
import 'package:cng/order_tracking.dart';
import 'package:cng/petrol_pump.dart';
import 'package:cng/splash1.dart';
import 'package:flutter/cupertino.dart';
import 'package:cng/page4.dart' as page4;
import 'package:cng/page1.dart' as page1;
import 'package:cng/page2.dart' as page2;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cng/page3.dart' as page3;
import 'package:flutter/material.dart';
import 'page4.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class booking_screen extends StatefulWidget {
  @override
  State<booking_screen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<booking_screen> {
  late NotchBottomBarController _controller;
  late GoogleMapController _mapController;
  final Location _location = Location();
  LatLng? _currentLocation;

  // Fetch current location
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return; // Location service not enabled
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return; // Permission not granted
        }
      }

      LocationData locationData = await _location.getLocation();
      setState(() {
        _currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
      });

      print('Current location: $_currentLocation');
    } catch (e) {
      print('Error retrieving location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _controller = NotchBottomBarController(index: 0);
    // Fetch location on initialization
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller; // Assign the controller
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const page1.Page1(),
      const page2.Page2(),
      const page3.Page3(),
      page4.Page4(
        name1: name,
        email1: email,
        phone1: number,
      ),
    ];
    final PageController pageController = PageController();
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= 4)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.black,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: Colors.black87,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10),
              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_outlined,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 1',
                ),
                BottomBarItem(
                  inActiveItem:
                      Icon(Icons.send_outlined, color: Colors.blueGrey),
                  activeItem: Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.map_outlined,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 3',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 4',
                ),
              ],
              onTap: (index) {
                // log('current selected index $index');
                pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleMapController? _mapController;

    return Stack(
      children: [
        // Google Maps Widget
        FutureBuilder<LatLng>(
          future: _getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('Location not available'));
            }

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: snapshot.data!,
                zoom: 14.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            );
          },
        ),

        // UI Elements over the map
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 10, 75),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(31.5),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(3, 4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Container(), // Placeholder for details container
              ),
            ],
          ),
        ),

        // Address and Actions
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                '58-12 Queens Blvd, Suite 2  Queens, NY 11377',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  height: 1.4,
                  color: Color(0xFF8D8D8D),
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Book Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              page11(), // Replace with your screen
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF69454)),
                        borderRadius: BorderRadius.circular(14.4),
                        color: Color(0xFFF69454),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/group_9_x2.svg',
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Book',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Route Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              petrol_pump(), // Replace with your screen
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(14.4),
                        color: Colors.black,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/route.png',
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Route',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Distance and Petrol Station Name
        Positioned(
          top: 10,
          left: 20,
          child: Text(
            '~ 8 km',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: Text(
            'Indian Oil Petroleum',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }

  Future<LatLng> _getCurrentLocation() async {
    // Implement your location fetching logic here
    // For example, using the geolocator package:
    // final position = await Geolocator.getCurrentPosition();
    // return LatLng(position.latitude, position.longitude);

    // For now, returning a default location
    return LatLng(37.42796133580664, -122.085749655962);
  }
}
