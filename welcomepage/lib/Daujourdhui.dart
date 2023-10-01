import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'constants.dart';

class Appointment {
  final String patientName;
  final DateTime dateTime;

  Appointment({
    required this.patientName,
    required this.dateTime,
  });
}

class Daujourdhui extends StatefulWidget {
  const Daujourdhui({Key? key}) : super(key: key);

  @override
  _DaujourdhuiState createState() => _DaujourdhuiState();
}

class _DaujourdhuiState extends State<Daujourdhui> {
  List<Appointment> appointments = [];
  TextEditingController doctorKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchAppointments() async {
    final String doctorKey = doctorKeyController.text;

    http.Response response = await http.post(
      Uri.parse(endpoint + "/Rendezvous/docteurRendezVousAujourdhui.php"),
      body: json.encode({'docteur_key': doctorKey}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['result'] == 'success' && jsonData.containsKey('message')) {
        final data = jsonData['message'];

        final appointmentsList = data.map<Appointment>((appointmentJson) {
          final time = DateFormat.Hm().parse(appointmentJson['time'].toString());
          final dateTime = DateTime.now().toLocal().add(Duration(hours: time.hour, minutes: time.minute));

          return Appointment(
            patientName: appointmentJson['patient_name'].toString(),
            dateTime: dateTime,
          );
        }).toList();

        setState(() {
          appointments = appointmentsList;
        });
      } else if (jsonData['result'] == 'empty') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Empty'),
            content: Text(jsonData['message'].toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Invalid response format'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch appointments'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vos rendez-vous'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: doctorKeyController,
              decoration: InputDecoration(
                labelText: 'Clé du docteur',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: fetchAppointments,
            child: Text('Voir les rendez-vous'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Card(
                  elevation: 2.0,
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      'Patient: ${appointment.patientName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          'Heure: ${DateFormat.Hm().format(appointment.dateTime)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}