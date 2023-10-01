import 'package:flutter/material.dart';
import 'package:welcomepage/check.dart';


void main()  {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Container(


          width: double.infinity,
          height: MediaQuery
              .of(context)
              .size
              .height,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
          child:Container(

                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/promed+.png",)

                      )
                  ),
                ),),

SizedBox(height: 80,),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/hethy.jpeg",)

                      )
                  ),
                ),
SizedBox(height: 80,),
                Align(

                  alignment: Alignment.centerLeft,
                  child: Row(
                      children: <Widget>[
                        Icon(
                            Icons.arrow_circle_right,
                            color: Colors.blue,
                            size: 50),
                        TextButton(style: TextButton.styleFrom(
                            primary: Colors.blue
                        ),

                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => checkpage()));
                          },
                          child: Text(
                              "Commencer", style: TextStyle(fontSize: 30,)),),
                      ]
                  ),

                ),
              ]
          ),
        ),
      ),
    );
  }
}