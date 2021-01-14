
import 'package:flutter/material.dart';
import 'package:sda/events/event.dart';
import 'package:dio/dio.dart';

class AllEvents extends StatefulWidget {
  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
 Future<List> events;

 Future<List> getEvents() async{
    var response = await Dio().get("https://restcountries.eu/rest/v2/all");
    return response.data;
  }


  @override
  void initState() {
    events = getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Event'),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
    child: FutureBuilder<List>(
    future: events, // a previously-obtained Future<String> or null
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData)
          {
            return ListView.builder(
                itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>event(snapshot.data[index]['name']),
                  ),
                );
                },

                child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      child:Text(snapshot.data[index]['name'], style: TextStyle(fontSize: 18)),)
                ),
              );
            }
            );

          }

        return null;
    }
    ),
    ),

      );

  }
}