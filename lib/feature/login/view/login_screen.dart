import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/core/validation/validation.dart';
import 'package:hotel_management/shared/text_field/custom_password_field.dart';
import 'package:hotel_management/shared/text_field/custom_text_field.dart';
import 'package:hotel_management/shared/utils/toast.dart';

import '../../../core/service/authenticate_service.dart';
import '../../profile/view/profile_screen.dart';
import '../../register/view/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authServer = AuthService();
  String email = "", password = "";
  bool isEmail = false, isPassword = false;
  bool isRemember = false;

  void getEmail(String? email){
    setState(() {
      this.email = email!;
      isEmail = Validation.email(email);
    });
    if (!isEmail) Toast.showToast(context: context, message: "Invalid Email", isWarning: true);
  }
  void getPassword(String? password){
    setState(() {
      this.password = password!;
      isPassword = Validation.password(password);
    });
    if (!isPassword) Toast.showToast(context: context, message: "Invalid Password", isWarning: true);
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
              Center(child: Text("Hi, Welcome Back!", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),)),
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Email", style: TextStyle(color: Colors.black, fontSize: 20,)),
                ],
              ),
              SizedBox(height: 5),
              CustomTextField(hintText: "Email", onValue: getEmail),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Password", style: TextStyle(color: Colors.black, fontSize: 20,)),
                ],
              ),
              SizedBox(height: 5),
              CustomPasswordField(hintText: "Password", onSubmittedValue: getPassword),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isRemember = !isRemember;
                          });
                        },
                        child: Icon(isRemember? Icons.check_box_outlined : Icons.check_box_outline_blank, size: 29)
                      ),
                      SizedBox(width: 3),
                      Text("Remember me", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                    ],
                  ),
                  Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.red),),
                ],
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  try {
                    print("email: $email and $password");
                    if (isEmail && isPassword){

                      await authServer.signInWIthEmailPassword(email, password);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                      Toast.showToast(context: context, message: "Login Successfully", isWarning: false);
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
                  child: Center(child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white))),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                    child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.deepPurple))
                  ),
                ],
              ),
              //Text("${_emailController.text}", style: TextStyle(fontSize: 40),),
            ],
          ),
        ),
      ),
    );
  }
}