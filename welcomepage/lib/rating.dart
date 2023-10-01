import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'Dashboard.dart';
import 'constants.dart';

void main() {
  runApp(MaterialApp(
    home: RatingApp(),
  ));
}

class Doctor {
  final String name;
  final String specialty;
  final double rate;

  Doctor({required this.name, required this.specialty, required this.rate});
}

class RatingApp extends StatefulWidget {
  @override
  _RatingAppState createState() => _RatingAppState();
}

class _RatingAppState extends State<RatingApp> {
  List<Doctor> doctors = [];

  @override
  void initState() {
    super.initState();
    fetchDoctors().then((doctorsList) {
      setState(() {
        doctors = doctorsList;
      });
    });
  }

  Future<List<Doctor>> fetchDoctors() async {
    final apiUrl = endpoint + '/Users/liste_des_docteur.php';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData); // Print response body for debugging

      if (jsonData['code'] == 'success' && jsonData.containsKey('data')) {
        List<Doctor> doctors = [];

        for (var doctorData in jsonData['data']) {
          if (doctorData is Map &&
              doctorData.containsKey('nomPrenom') &&
              doctorData.containsKey('specialite') &&
              doctorData.containsKey('rate')) {
            Doctor doctor = Doctor(
              name: doctorData['nomPrenom'].toString(),
              specialty: doctorData['specialite'].toString(),
              rate: double.parse(doctorData['rate'].toString()),
            );
            doctors.add(doctor);
          }
        }

        return doctors;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception(
          'Erreur lors de l\'appel à l\'API : ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    doctors.sort((a, b) => b.rate.compareTo(a.rate));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liste des médecins ',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Liste des médecins'),
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RateDoctorScreen(doctor: doctors[index]),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctors[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Spécialité: ${doctors[index].specialty}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            'Rate: ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16.0,
                          ),
                          Text(
                            doctors[index].rate.toStringAsFixed(1),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RateDoctorScreen extends StatefulWidget {
  final Doctor doctor;

  RateDoctorScreen({required this.doctor});

  @override
  _RateDoctorScreenState createState() => _RateDoctorScreenState();
}

class _RateDoctorScreenState extends State<RateDoctorScreen> {
  double overallRating = 0.0;

  void _updateOverallRating(double rating) {
    setState(() {
      overallRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate ${widget.doctor.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Overall Rating:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            RatingBar.builder(
              initialRating: overallRating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: _updateOverallRating,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 60)),
              onPressed: () {
                rate();
                // Save the rating to a database or file
                // and return to the doctor list screen
                Navigator.pop(context);
              },
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }

  void rate() async {
    final apiUrl = endpoint + '/rate/rate.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({
        'rate': overallRating.toString(),
        'nom_docteur': widget.doctor.name,
      }),
    );

    if (response.statusCode == 200) {
      // Rating successfully saved
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      // Handle the error
      print('Failed to save rating: ${response.statusCode}');
    }
  }
}
