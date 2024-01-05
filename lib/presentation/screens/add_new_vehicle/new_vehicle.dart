import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicle_no_assignment/model/VehicleModel.dart';
import 'package:vehicle_no_assignment/presentation/home/home.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  String selectedVehicleType = 'Car'; // Default value
  String selectedFuelType = 'Petrol'; // Default value







  Future<void> _uploadDataToFirebase() async {
    try {
      print('the upload_to_firebase function is started');
      FirebaseAuth auth = FirebaseAuth.instance;

      // Show a SnackBar with the "Your video is uploaded" message
      // -----------------------------------------------------------------------

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final vehiclemodel = VehicleModel(
          vehicleno : vehicleNoController.text,
          brand: brandNameController.text,
          type: selectedVehicleType,
          fuel: selectedFuelType);
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('Vehicles')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set(vehiclemodel.toJson());

      print("---------------------> Updated in firestore database also");

      // -----------------------------------------------------------------------



      print('snackbar is completly run!');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );

      print('snackbar is showed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your Vehicle Details is Uploded!'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
          backgroundColor: Colors.green,
        ),
      );


      print('navigation push replacement is done!');
    } catch (error) {
      // Handle errors
      print('Error uploading data to Firebase: $error');
      // You may want to show an error message to the user
      Navigator.of(context).pop();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle No. TextField
              TextField(
                controller: vehicleNoController,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  hintText: 'Vehicle No. (ex. GJ06PN4321)',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'[A-Z0-9]')), // Allow only uppercase letters and digits
                  LengthLimitingTextInputFormatter(
                      10), // Limit the length to 10 characters
                  // You can adjust the length limit as needed
                ],
              ),

              SizedBox(height: 16.0),

              // Brand Name TextField

              TextField(
                controller: brandNameController,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  hintText: 'Brand Name (hundai , Maruti Suzuki , etc.)',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.0),

              // Vehicle Type Dropdown

              DropdownButtonFormField<String>(
                value: selectedVehicleType,
                onChanged: (newValue) {
                  setState(() {
                    selectedVehicleType = newValue!;
                  });
                },
                items: ['Car', 'Bike'].map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black)), // Customize the text style
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Vehicle Type',
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                style: TextStyle(
                    fontSize: 16.0), // Customize the overall dropdown style
                icon: Icon(Icons.arrow_drop_down,
                    size: 30.0,
                    color: Colors.blue), // Customize the dropdown icon
                iconSize: 30.0, // Set the size of the dropdown icon
                elevation: 8, // Set the elevation of the dropdown
                isExpanded:
                    true, // Make the dropdown button take the full width
              ),

              SizedBox(height: 16.0),

              // Fuel Type Dropdown

              DropdownButtonFormField<String>(
                value: selectedFuelType,
                onChanged: (newValue) {
                  setState(() {
                    selectedFuelType = newValue!;
                  });
                },
                items: ['Petrol', 'Diesel', 'Electric','CNG','Petrol+CNG'].map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Fuel Type',
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: 16.0),
                icon:
                    Icon(Icons.arrow_drop_down, size: 30.0, color: Colors.blue),
                iconSize: 30.0,
                elevation: 8,
                isExpanded: true,
              ),

              SizedBox(height: 16.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: () {

                      _uploadDataToFirebase();
                      // Add logic to handle the form submission
                      // You can access the entered values using the controllers
                      String vehicleNo = vehicleNoController.text;
                      String brandName = brandNameController.text;
                      // Handle the selectedVehicleType and selectedFuelType accordingly

                      // For now, just print the values
                      print('Vehicle No.: $vehicleNo');
                      print('Brand Name: $brandName');
                      print('Vehicle Type: $selectedVehicleType');
                      print('Fuel Type: $selectedFuelType');

                      // Once the form is submitted, you can navigate back
                      Navigator.pop(context);
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
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
