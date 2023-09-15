import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileDisplay extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userCity;
  final String userState;
  final int userPhoneNumber;
  final GeoPoint userLocation;

  ProfileDisplay({
    required this.userName,
    required this.userEmail,
    required this.userCity,
    required this.userState,
    required this.userPhoneNumber,
    required this.userLocation,
  });

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng userLatLng = LatLng(0,0);
  @override
  void initState() {
    super.initState();
    userLatLng = LatLng(widget.userLocation.latitude, widget.userLocation.longitude);

    // Initialize markers with the user's location
    markers.add(
      Marker(
        markerId: MarkerId('user_location'),
        position: userLatLng,
        infoWindow: InfoWindow(title: 'User Location'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4, // Add elevation for a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Name:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        widget.userName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Divider(), // Add a divider for visual separation
                    ListTile(
                      title: Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        widget.userEmail,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'City:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        widget.userCity,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'State:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        widget.userState,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Phone Number:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        widget.userPhoneNumber.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Divider(),
                    Text(
                      'Location:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 200, // Adjust the height as needed
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: userLatLng,
                          zoom: 15.0,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('user_location'),
                            position: userLatLng,
                            infoWindow: InfoWindow(title: 'User Location'),
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
