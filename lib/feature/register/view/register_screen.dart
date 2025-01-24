import 'package:flutter/material.dart';
import 'package:hotel_management/feature/login/view/login_screen.dart';
import 'package:hotel_management/feature/navigation/view/navigation_screen.dart';
import 'package:hotel_management/shared/text_field/custom_password_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/service/authenticate_service.dart';
import '../../../core/validation/validation.dart';
import '../../../shared/text_field/custom_text_field.dart';
import '../../../shared/utils/toast.dart';
import '../../profile/view/profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authServer = AuthService();
  String _name = "", _phone = "", _email = "", _password = "", _confirmPassword = "";
  bool isName = false, isPhone = false, isEmail = false, isPassword = false, isConfirmPassword = false;

  void getName(String? name){
    setState(() {
      _name = name!;
      isName = Validation.name(name);
    });
    if (!isName) Toast.showToast(context: context, message: "Invalid Name", isWarning: true);
  }
  void getPhone(String? phone){
    setState(() {
      _phone = phone!;
      isPhone = Validation.phone(phone);
    });
    if (!isPhone) Toast.showToast(context: context, message: "Invalid Phone Number", isWarning: true);
  }
  void getEmail(String? email){
    setState(() {
      _email = email!;
      isEmail = Validation.email(email);
    });
    if (!isEmail) Toast.showToast(context: context, message: "Invalid Email", isWarning: true);
  }
  void getPassword(String? password){
    setState(() {
      _password = password!;
      isPassword = Validation.password(password);
    });
    if (!isPassword) Toast.showToast(context: context, message: "Invalid Password", isWarning: true);
  }
  void getConfirmPassword(String? confirmPassword){
    setState(() {
      _confirmPassword = confirmPassword!;
      isConfirmPassword = Validation.password(confirmPassword);
    });
    if (!isConfirmPassword) Toast.showToast(context: context, message: "Invalid Confirm Password", isWarning: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(child: Text("Create an account", style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w800),)),
              Center(child: Text("Connect with your friends today!", style: TextStyle(color: Colors.black, fontSize: 20),)),
              SizedBox(height: 50),
              CustomTextField(hintText: "Name", onValue: getName),
              SizedBox(height: 30),
              CustomTextField(hintText: "Phone", onValue: getPhone),
              SizedBox(height: 30),
              CustomTextField(hintText: "Email", onValue: getEmail),
              SizedBox(height: 30),
              CustomPasswordField(hintText: "Password", onSubmittedValue: getPassword),
              SizedBox(height: 30),
              CustomPasswordField(hintText: "Confirm Password", onSubmittedValue: getConfirmPassword),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  try {
                    if (isName && isPhone && isEmail && isPassword && _password == _confirmPassword){
                      await authServer.signUpWIthEmailPassword(
                          _email, _password
                      );
                      await Supabase.instance.client.from('users').insert({'name': _name, 'email' : _email, 'phone' : _phone, 'img_url' : ""});

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
                      Toast.showToast(context: context, message: "Account Created Successfully", isWarning: false);
                    } else {
                      Toast.showToast(context: context, message: "Invalid Input", isWarning: true);
                    }
                  } catch (e){
                    print(e);
                    Toast.showToast(context: context, message: "Error Found", isWarning: true);
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),  // Corrected: Use `borderRadius` instead of `border`
                    color: Colors.blue,
                  ),
                  child: Center(child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white))),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  SizedBox(width: 5),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
                      },
                      child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.deepPurple),)
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