import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:welcomepage/constants.dart';
void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _formKey = GlobalKey<FormState>();
  String _patientKey = '';
  String acceptedCount = '0';
  String rejectedCount = '0';
  String pendingCount = '0';
  final TextEditingController _keyController = TextEditingController();

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  void _envoyerCle() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Envoyer la clé à l'API
      final url = endpoint + 'dashbord/dashbord.php';
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({'patient_key': _patientKey}), // Utilisez "patient_key" ici
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Analyser la réponse de l'API
        final data = json.decode(response.body);
        final countData = data['data'];

        setState(() {
          acceptedCount = countData['accepted_count'];
          rejectedCount = countData['refused_count'];
          pendingCount = countData['waiting_count'];
        });
      } else {
        // Gérer les erreurs de la requête HTTP
        print('Erreur lors de la requête API');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 0,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Patient key',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 200,
                    child: TextFormField(
                      controller: _keyController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      onSaved: (value) => _patientKey = value ?? '',
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your key' : null,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: ElevatedButton(
                    onPressed: _envoyerCle,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: Text('Envoyer'),
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircle('Acceptés', acceptedCount, Colors.green),
                    SizedBox(width: 20),
                    _buildCircle('Refusés', rejectedCount, Colors.red),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircle('En attente', pendingCount, Colors.yellow),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildCircle(String label, String count, Color color) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            count,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}