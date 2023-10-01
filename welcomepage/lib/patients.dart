import 'package:flutter/material.dart';

void main()  {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Pat(),
  ));
}
class Patient {
  final String name;
  final int age;
  final String gender;

  Patient({required this.name, required this.age, required this.gender});
}

class Pat extends StatelessWidget {
  final List<Patient> patients = [    Patient(name: 'John Doe', age: 30, gender: 'Male'),    Patient(name: 'Jane Doe', age: 25, gender: 'Female'),    Patient(name: 'Bob Smith', age: 45, gender: 'Male'),    Patient(name: 'Alice Johnson', age: 50, gender: 'Female'),  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste des Patients',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Liste des Patients'),
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: patients.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
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
                      patients[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Age: ${patients[index].age}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Gender: ${patients[index].gender}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}