import 'package:flutter/material.dart';
import 'package:sda/events/eventlist.dart';
import 'package:sda/log/view_activity_log.dart';
import 'package:sda/news/newslist.dart';
import 'package:sda/profile/view_profile.dart';
import 'package:sda/profile/view_all_alumni.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sda/auth/login.dart';
import 'landing_page.dart';
class MainDrawer extends StatefulWidget{
  final Map alumni;
  const MainDrawer({Key key, this.alumni}):super(key: key);
  @override
  _MainDrawerState createState() => _MainDrawerState();
}


class _MainDrawerState extends State<MainDrawer> {

  Map alumni;
  _MainDrawerState({this.alumni});
  final GlobalKey<_MainDrawerState> _mainDrawerState = GlobalKey<_MainDrawerState>();

  SharedPreferences sharedPreferences;

  BuildContext get context => null;

  @override
  void initState() {
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {

   return Drawer(
     child: Column(
       children: <Widget>[
         Container(
           width: double.infinity,
           padding: EdgeInsets.all(20),
           color: Theme.of(context).primaryColor,
           child: Center(
             child: Column(
               children: <Widget>[
                 Container(
                   width: 100,
                   height: 100,
                   margin: EdgeInsets.only(
                     top: 30,
                     bottom: 10,
                   ),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     image: DecorationImage(image :NetworkImage('https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png'
                     ),
                       fit: BoxFit.fill
                     ),
                   ),
                 ),
                 // Text(
                 //   widget.alumni['alumniName'].toString(),
                 //   style: TextStyle(
                 //     fontSize: 22,
                 //     color: Colors.white,
                 //   ),
                 // ),
                 //
                 Text(
                  widget.alumni['alumniEmail'],
                   style: TextStyle(
                     color: Colors.white,
                   ),
                 ),
               ],
             ),
           ),
         ),

         ListTile(
           leading: Icon(Icons.home),
           title: Text('Home',
             style: TextStyle(fontSize: 18,),),
           onTap: () {
             //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Landing(alumni: widget.alumni)));
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Landing(alumni: widget.alumni)),(Route<dynamic> route) => false);
           },
         ),


         ListTile(
           leading: Icon(Icons.person),
           title: Text('Profile',
           style: TextStyle(fontSize: 18,),),
           onTap: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Profile(alumni: widget.alumni)),(Route<dynamic> route) => false);
                  },
         ),

         ListTile(
           leading: Icon(Icons.calendar_today),
           title: Text('Events',
             style: TextStyle(fontSize: 18,),),
           onTap: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AllEvents(alumni: widget.alumni)),(Route<dynamic> route) => false);
           },
         ),

         ListTile(
           leading: Icon(Icons.article),
           title: Text('News',
             style: TextStyle(fontSize: 18,),),
           onTap: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AllNews(alumni: widget.alumni)),(Route<dynamic> route) => false);
           },
         ),

         ListTile(
           leading: Icon(Icons.insert_chart),
           title: Text('Report Involvement',
             style: TextStyle(fontSize: 18,),),
           onTap: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LogActivityPage(alumni: widget.alumni)),(Route<dynamic> route) => false);
           },
         ),
         ListTile(
           leading: Icon(Icons.attribution_outlined),
           title: Text('Connect With Others',
             style: TextStyle(fontSize: 18,),),
           onTap: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AllProfile(alumni: widget.alumni)),(Route<dynamic> route) => false);
           },
         ),
         ListTile(
           leading: Icon(Icons.arrow_back),
           title: Text('Logout',
             style: TextStyle(fontSize: 18,),),
           onTap: () {
             sharedPreferences.clear();
             sharedPreferences.commit();
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
           },
         ),

       ],
     ),
   );
  }
}