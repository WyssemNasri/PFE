import 'package:flutter/material.dart';
import 'package:welcomepage/MedicalRecord.dart';
import 'package:welcomepage/appointment.dart';
import 'package:welcomepage/mymedrec.dart';
import 'package:welcomepage/TableauxApp.dart';
import 'package:welcomepage/rating.dart';
import 'package:welcomepage/rendez-vous.dart';

import 'Aujourdhui.dart';
import 'connexion.dart';
import 'conversation.dart';
import 'home/login_db.dart';
import 'index.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bienvenue.png'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                // Handle onTap for Home icon
                // Example: navigate to Home screen
              },
              child: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                // Handle onTap for Calendar icon
                // Example: navigate to Calendar screen
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.blue,
              ),
            ),
            label: 'Rendez-vous',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                // Handle onTap for Person icon
                // Example: navigate to Patient screen
              },
              child: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
            label: 'Evaluation',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                // Handle onTap for Vote icon
                // Example: navigate to Vote screen
              },
              child: Icon(
                Icons.bar_chart,
                color: Colors.blue,
              ),
            ),
            label: 'tableau de bord ',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Doct()));
              },
              child: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
            ),
            label: 'Paramétres',
          ),
        ],
        iconSize: 33.0,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(""),
              accountEmail: new Text(""),
            ),
            ListTile(
              leading: Icon (
                Icons.bar_chart,
                color: Colors.blue,
              ),
              title: Text("tableaux de bord"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardApp()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.receipt,
                color: Colors.blue,
              ),
              title: Text("Dossier médical"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicalRecordPage()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.receipt,
                color: Colors.blue,
              ),
              title: Text("mon dossier médical"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicalRecordsInterface()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: Colors.blue,
              ),
              title: Text("Rendez-Vous"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Doct()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.update,
                color: Colors.blue,
              ),
              title: Text("Rendez-vous en attente "),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RendezVousList()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.chat,
                color: Colors.blue,
              ),
              title: Text("Conversation"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ConnexionPage()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.blue,
              ),
              title: Text("Mes Rendez Vous"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Aujourdhui()));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.star_rate_sharp,
                color: Colors.blue,
              ),
              title: Text("Evaluation"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RatingApp()));
              },
            ),
            SizedBox(
              height: 135,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              title: Text('Se déconnecter'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Loginpage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
