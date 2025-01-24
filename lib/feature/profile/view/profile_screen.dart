import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/text_field/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = true;

  void getValue(String? txt){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/040/965/696/small/ai-generated-red-sports-car-with-smoke-coming-out-of-it-photo.jpg'),
                      fit: BoxFit.cover, // Ensures the image fills the circle
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Action to perform when the button is pressed
                  print("TextButton pressed!");
                },
                child: Text('Update Image', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), // The text displayed on the button
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.grey[200], // Button background color
                  padding: EdgeInsets.symmetric(horizontal: 15), // Padding around the text
                ),
              ),
              SizedBox(height: 40),
              if (isEdit)
                Column(
                  children: [
                    Text("Rayhan Chy", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                    SizedBox(height: 7),
                    Text("Phone: 012123456789", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
                    SizedBox(height: 7),
                    Text("Email: wxyz@gmail.com", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),

                  ],
                ),
              if (!isEdit)
                Column(
                  children: [
                    CustomTextField(hintText: "Name", onValue: getValue),
                    SizedBox(height: 10),
                    CustomTextField(hintText: "Phone", onValue: getValue),
                    SizedBox(height: 10),
                    CustomTextField(hintText: "Email", onValue: getValue),
                  ],
                ),
              SizedBox(height: 40),
              if (isEdit)
                TextButton(
                  onPressed: () {
                    setState(() {
                      isEdit = false;
                    });
                  },
                  child: Text('Edit Profile', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), // The text displayed on the button
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.grey[200], // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 15), // Padding around the text
                  ),
                ),
              if (isEdit == false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEdit = true;
                        });
                      },
                      child: Text('Update', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), // The text displayed on the button
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.grey[200], // Button background color
                        padding: EdgeInsets.symmetric(horizontal: 15), // Padding around the text
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEdit = true;
                        });
                      },
                      child: Text('Cancel', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), // The text displayed on the button
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.grey[200], // Button background color
                        padding: EdgeInsets.symmetric(horizontal: 15), // Padding around the text
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
