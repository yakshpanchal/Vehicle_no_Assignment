import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_no_assignment/presentation/screens/add_new_vehicle/new_vehicle.dart';
import 'package:vehicle_no_assignment/presentation/profile/profile.dart';
import 'package:vehicle_no_assignment/presentation/screens/add_new_vehicle/subscreens/bikes.dart';
import 'package:vehicle_no_assignment/presentation/screens/add_new_vehicle/subscreens/cars.dart';

import '../authentication/loginpage.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Handle logout
                FirebaseAuth.instance.signOut();
                // Navigate to login screen or perform other actions
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  child: Text('Profile'),
                ),
                PopupMenuItem(
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),

      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Car'),
                Tab(text: 'Bike'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Cars(),
                  Bikes(),
                ],
              ),
            ),


            // Common button for both tabs
            ElevatedButton(
              onPressed: () {
                // Handle button click
                print('adding a new vihicle from shows');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddVehicleScreen()),
                );

                // Add your logic for adding vehicles
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                padding:
                EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_sharp), // Icon for adding a vehicle
                  SizedBox(width: 8.0), // Spacer between icon and text
                  Text('Add Vehicles'), // Text for the button
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
