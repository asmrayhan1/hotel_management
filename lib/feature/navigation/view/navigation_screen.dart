import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/feature/home/view/home_screen.dart';
import 'package:hotel_management/feature/login/view/login_screen.dart';
import 'package:hotel_management/feature/profile/view/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
      print("index = $index");
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProfileScreen()
  ];

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("QuickBook Hotel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>LoginScreen())
                );
              },
              child: Icon(Icons.logout, color: Colors.white)
            ),
          )
        ],
      ),

      body: RefreshIndicator(
          onRefresh: _refreshData,
          child: _widgetOptions.elementAt(_selectedIndex), backgroundColor: Color(0xffF5F5F5)
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // This will keep track of the selected index
        onTap: (int index){
          _onItemTapped(index, context);
        }, // Function to handle tap events
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: Color(0xff105866),  // Change text color for the selected label
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home, size: 25,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person, size: 25),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
