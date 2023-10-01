import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

class MedicalRecord {
  final String key;
  final String name;
  final String age;
  final String weakness;
  final String allergies;
  final String medKits;
  final String temperature;
  final String weight;
  final String respiration;
  final String symptoms;
  final String diagnostic;
  final String tension;
  final String pulse;
  final String arrangement;
  final String observation;

  MedicalRecord({
    required this.key,
    required this.name,
    required this.age,
    required this.weakness,
    required this.allergies,
    required this.medKits,
    required this.temperature,
    required this.weight,
    required this.respiration,
    required this.symptoms,
    required this.diagnostic,
    required this.tension,
    required this.pulse,
    required this.arrangement,
    required this.observation,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      key: json['patient_key'] ?? '',
      name: json['nomPrenom'] ?? '',
      age: json['age'] ?? '',
      weakness: json['weakness'] ?? '',
      allergies: json['allergies'] ?? '',
      medKits: json['medKits'] ?? '',
      temperature: json['temperature'] ?? '',
      weight: json['weight'] ?? '',
      respiration: json['respiration'] ?? '',
      symptoms: json['symptoms'] ?? '',
      diagnostic: json['diagnostic'] ?? '',
      tension: json['tension'] ?? '',
      pulse: json['pulse'] ?? '',
      arrangement: json['arrangement'] ?? '',
      observation: json['observation'] ?? '',
    );
  }
}

class MedicalRecordsInterface extends StatefulWidget {
  @override
  _MedicalRecordsInterfaceState createState() =>
      _MedicalRecordsInterfaceState();
}

class _MedicalRecordsInterfaceState extends State<MedicalRecordsInterface> {
  late TextEditingController _keyController;
  MedicalRecord? _medicalRecord;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController();
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  Future<MedicalRecord> _fetchMedicalRecord(String key) async {
    final apiUrl = endpoint + '/dossier_medical/consulterMonDossier.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(
        {"patient_key": key},
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['code'] == 'success' && jsonData.containsKey('data')) {
        final recordData = jsonData['data'];
        return MedicalRecord.fromJson(recordData);
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception(
          'Error fetching medical record: ${response.statusCode}');
    }
  }

  void _submitKey() {
    final key = _keyController.text;
    // Call the API to fetch medical record using the provided key
    _fetchMedicalRecord(key).then((record) {
      setState(() {
        _medicalRecord = record;
        _errorMessage = '';
        showDialog(
          context: context,
          builder: (BuildContext context) => MedicalRecordDialog(record: record),
        );
      });
    }).catchError((error) {
      setState(() {
        _errorMessage = 'Error fetching medical record. Please try again.';
        _medicalRecord = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon dossier médical'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _keyController,
              decoration: InputDecoration(
                labelText: 'Clé de sécurité ',
              ),
            ),
            SizedBox(height: 16.0),
            Center(
                child : ElevatedButton(

                  style:TextButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10,horizontal: 80)

                  ),
              onPressed: _submitKey,
              child: Text('Envoyer'),
            ),),
            SizedBox(height: 16.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class MedicalRecordDialog extends StatelessWidget {
  final MedicalRecord record;

  MedicalRecordDialog({required this.record});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dossier médical',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Name: ${record.name}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Age: ${record.age}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Weakness: ${record.weakness}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Allergies: ${record.allergies}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Med Kits: ${record.medKits}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Temperature: ${record.temperature}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Weight: ${record.weight}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Respiration: ${record.respiration}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Symptoms: ${record.symptoms}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Diagnostic: ${record.diagnostic}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Tension: ${record.tension}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Pulse: ${record.pulse}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Arrangement: ${record.arrangement}',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Observation: ${record.observation}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Center(
             child: ElevatedButton(
               style:TextButton.styleFrom(shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(50)
               ),
                   padding: EdgeInsets.symmetric(
                       vertical: 10,horizontal: 80)

               ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fermer'),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
