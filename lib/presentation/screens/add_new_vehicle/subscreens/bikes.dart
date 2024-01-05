import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../model/VehicleModel.dart';
class Bikes extends StatefulWidget {
  const Bikes({super.key});

  @override
  State<Bikes> createState() => _BikesState();
}

class _BikesState extends State<Bikes> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _deleteVehicle(DocumentReference documentReference) async {
    try {
      await documentReference.delete();
      print('Document deleted successfully!');
    } catch (e) {
      print('Error deleting document: $e');
      // Handle error, show a snackbar, etc.
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('Vehicles')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Data available.'));
          }

          // Extract video data from QuerySnapshot
          final vehicleDocs = snapshot.data!.docs;



          // return ListView.builder(
          //   itemCount: vehicleDocs.length,
          //   itemBuilder: (context, index) {
          //     // Assuming VideoModel has a constructor that takes a Map<String, dynamic>
          //     // Adjust the constructor according to your VideoModel structure
          //     final vehicleModel = VehicleModel.fromJson(vehicleDocs[index].data()as Map<String, dynamic>);
          //
          //     return vehicleModel.type == 'Car' ? Container() : Card(
          //       child: Column(
          //         children: [
          //           ListTile(
          //             leading: Icon(Icons.car_rental),
          //             title: Text(vehicleModel.brand),
          //             subtitle: Text('${vehicleModel.vehicleno}\n${vehicleModel.fuel}'),
          //           ),
          //           // Add other Card content or actions here
          //         ],
          //       ),
          //     );
          //   },
          // );
          return ListView.builder(
            itemCount: vehicleDocs.length,
            itemBuilder: (context, index) {
              final vehicleModel = VehicleModel.fromJson(vehicleDocs[index].data() as Map<String, dynamic>);

              // Check if the vehicle type is not 'Car'
              if (vehicleModel.type == 'Bike') {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(vehicleModel.brand),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Car Name: ${vehicleModel.vehicleno}'),
                            Text('Brand: ${vehicleModel.brand}'),
                            Text('Fuel Type: ${vehicleModel.fuel}'),
                            Text('Vehicle Number: ${vehicleModel.vehicleno}'),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {

                            _deleteVehicle(vehicleDocs[index].reference);
                            // Handle the action when the cross symbol is pressed
                            // For example, you can remove the card from the list or dismiss it
                            // You may want to use a Stateful widget for this purpose.
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // If it's a 'Car', return an empty Container
                return Container();
              }
            },
          );

        },
      ),
    );
  }
}
