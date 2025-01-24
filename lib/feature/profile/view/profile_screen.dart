import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/core/service/authenticate_service.dart';
import 'package:hotel_management/core/validation/validation.dart';
import 'package:hotel_management/feature/profile/model/user_model.dart';
import 'package:hotel_management/shared/utils/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/text_field/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = true;
  final SupabaseClient supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> uploadImage({required String email}) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() => _isUploading = true);

    try {
      final File file = File(pickedFile.path);
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

      final imageUrl = await supabase.storage.from('images').upload(fileName, file);

      try {
        await supabase.from('users').update({
          'img_url': imageUrl,
        }).eq('email', email);
        Toast.showToast(context: context, message: "Image Updated");
      } catch (e){
        Toast.showToast(context: context, message: "Error Found", isWarning: true);
        print(e);
      } finally {
        setState(() => _isUploading = false);
      }
    } catch (e) {
      Toast.showToast(context: context, message: "Upload Failed!", isWarning: true);
    } finally {
      setState(() => _isUploading = false);
    }
  }

  Future<void> updateProfile(String email, String phone, String name) async{
    await supabase.from('users').update({
      'phone' : phone,
      'name' : name
    }).eq('email', email);
    try {
      Toast.showToast(context: context, message: "Profile Updated Successfully");
    } catch (e) {
      Toast.showToast(context: context, message: "Update Failed", isWarning: true);
    }
  }


  String name = "", _name = "";
  String phone = "", _phone = "";
  String email = "", _email = "";
  String imageUrl = "";
  void getName(String? txt){
    setState(() {
      name = txt!;
    });
  }
  void getPhone(String? txt){
    setState(() {
      phone = txt!;
    });
  }
  void getEmail(String? txt){
    setState(() {
      email = txt!;
    });
  }

  final authServer = AuthService();

  Future<void> upLoadData({required email}) async {
    try {
      final data = await supabase.from('users').select().eq('email', authServer.getCurrentUserEmail().toString()).single();
      UserModel user = UserModel.fromMap(data);
      setState(() {
        _email = user.email;
        _phone = user.phone;
        _name = user.name;
        imageUrl = user.imgUrl;
      });
    } catch (e) {
      print("Error found in upLoadData $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      await upLoadData(email: authServer.getCurrentUserEmail().toString());
    });
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
                      image: (imageUrl.isNotEmpty)
                          ? NetworkImage("https://dkcsxccdmdunftexgdkc.supabase.co/storage/v1/object/public/$imageUrl") // Load network image if URL is provided
                          : AssetImage('assets/images/person.png') as ImageProvider,
                      fit: BoxFit.cover, // Ensures the image fills the circle
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  await uploadImage(email: authServer.getCurrentUserEmail().toString());
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
                    Text(_name, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                    SizedBox(height: 7),
                    Text("Phone: $_phone", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
                    SizedBox(height: 7),
                    Text("Email: $_email", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
              if (!isEdit)
                Column(
                  children: [
                    CustomTextField(hintText: "Name", onValue: getName),
                    SizedBox(height: 10),
                    CustomTextField(hintText: "Phone", onValue: getPhone),
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
                      onPressed: () async {
                        if (Validation.name(name) && Validation.phone(phone)){
                          await updateProfile(_email, phone, name);
                          await upLoadData(email: _email);
                          setState(() {
                            isEdit = true;
                          });
                        } else {
                          Toast.showToast(context: context, message: "Invalid Input", isWarning: true);
                        }
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
