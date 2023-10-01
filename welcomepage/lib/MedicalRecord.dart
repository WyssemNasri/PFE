import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Dashboard.dart';
import 'constants.dart';
class MedicalRecord extends StatelessWidget {
  const MedicalRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dossier médical',
      home: const MedicalRecordPage(),
    );
  }
}

class MedicalRecordPage extends StatefulWidget {
  const MedicalRecordPage({Key? key}) : super(key: key);

  @override
  _MedicalRecordPageState createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  final _formKey = GlobalKey<FormState>();
  String _patientcle = '';
  String _patientName = '';
  String _patientAge = '';
  String _patientWeakness = '';
  String _patientAllergies = '';
  String _patientMedkits = '';
  String _patientTemperature = '';
  String _patientWeight = '';
  String _patientRespiration = '';
  String _patientSymptoms = '';
  String _patientDiagnostic = '';
  String _patientTension = '';
  String _patientPulse = '';
  String _patientArrangement = '';
  String _patientObservation = '';

  final TextEditingController Name = TextEditingController();
  final TextEditingController Key = TextEditingController();
  final TextEditingController Age = TextEditingController();
  final TextEditingController Weakness = TextEditingController();
  final TextEditingController Allergies = TextEditingController();
  final TextEditingController Medkits = TextEditingController();
  final TextEditingController Temperature = TextEditingController();
  final TextEditingController Weight = TextEditingController();
  final TextEditingController Respiration = TextEditingController();
  final TextEditingController Symptoms = TextEditingController();
  final TextEditingController Diagnostic = TextEditingController();
  final TextEditingController Tension = TextEditingController();
  final TextEditingController Pulse = TextEditingController();
  final TextEditingController Arrangement = TextEditingController();
  final TextEditingController Observation = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dossier médical'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 16),
              Text('Patient key'),
              TextFormField(
                controller: Key,
                onSaved: (value) => _patientcle = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter your key' : null,
              ),
              const SizedBox(height: 16),
              Text('Age'),
              TextFormField(
                controller: Age,
                onSaved: (value) => _patientAge = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter an age' : null,
              ),
              const SizedBox(height: 16),
              Text('Weakness'),
              TextFormField(
                controller: Weakness,
                onSaved: (value) => _patientWeakness = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Allergies'),
              TextFormField(
                controller: Allergies,
                onSaved: (value) => _patientAllergies = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Medkits'),
              TextFormField(
                controller: Medkits,
                onSaved: (value) => _patientMedkits = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Temperature'),
              TextFormField(
                controller: Temperature,
                onSaved: (value) => _patientTemperature = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Weight'),
              TextFormField(
                controller: Weight,
                onSaved: (value) => _patientWeight = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Respiration'),
              TextFormField(
                controller: Respiration,
                keyboardType: TextInputType.number,
                onSaved: (value) => _patientRespiration = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Symptoms'),
              TextFormField(
                controller: Symptoms,
                onSaved: (value) => _patientSymptoms = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Diagnostic'),
              TextFormField(
                controller: Diagnostic,
                onSaved: (value) => _patientDiagnostic = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Tension'),
              TextFormField(
                controller: Tension,
                onSaved: (value) => _patientTension = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Pulse'),
              TextFormField(
                controller: Pulse,
                onSaved: (value) => _patientPulse =value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Arrangement'),
              TextFormField(
                controller: Arrangement,
                onSaved: (value) => _patientArrangement = value ?? '',
              ),
              const SizedBox(height: 16),
              Text('Observation'),
              TextFormField(
                controller: Observation,
                onSaved: (value) => _patientObservation = value ?? '',
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              Center(
                child : ElevatedButton(

                  style:TextButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10,horizontal: 80)

                  ),
                  onPressed:() {
                    MedRec();
                  },
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  void MedRec() async {
    String cle = Key.text;
    String age =Age.text;
    String weakness = Weakness.text;
    String allergies = Allergies.text;
    String medkits = Medkits.text;
    String temperature = Temperature.text;
    String weight = Weight.text;
    String respiration = Respiration.text;
    String symptoms = Symptoms.text;
    String diagnostic = Diagnostic.text;
    String tension = Tension.text;
    String pulse = Pulse.text;
    String arrangement = Arrangement.text;
    String opbservation = Observation.text;

    {
      http.Response response = await http.post(
        Uri.parse(endpoint +
            "dossier_medical/ModifierUnDossier.php"),
        body: json.encode(
          {
            "patient_key": cle,
            "age":age,
            "wikness": weakness,
            "allergies": allergies,
            "medkits": medkits,
            "temperature": temperature,
            "weight": weight,
            "respiration": respiration,
            "symptoms": symptoms,
            "diagnostic": diagnostic,
            "tension": tension,
            "pulse": pulse,
            "arrangement": arrangement,
            "observation": opbservation
          },
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    }
  }
}