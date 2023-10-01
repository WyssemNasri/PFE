import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import '../constants.dart';


class singuppage extends StatefulWidget {
  const singuppage({Key? key}) : super(key: key);

  @override
  State<singuppage> createState() => _SignupPageState();
}

class _SignupPageState extends State<singuppage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomprenomController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String emailError = '';
  final _emailFocusNode = FocusNode();
  final _phoneNumberController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _ispasswordValid = true;
  bool _isPhoneNumberValid = true;
  bool _isEmailValid = true;

  final _formKey = GlobalKey<FormState>();
  bool hide = true;
  String type1 = "patient";
  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    // RegExp pattern for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  void _validateInputsE() {
    setState(() {
      _isEmailValid = _validateEmail(_emailController.text);
    });
  }

  bool _validatePhone(String phone) {
    // RegExp pattern for phone validation
    final phoneRegExp = RegExp(r'^\d{8}$');
    return phoneRegExp.hasMatch(phone);
  }

  void _validateInputsN() {
    setState(() {
      _isPhoneNumberValid = _validatePhone(_phoneController.text);
    });
  }

  bool _validatepassword(String password) {
    // RegExp pattern for phone validation
    final phoneRegExp = RegExp(r'^.{7,}$');
    return phoneRegExp.hasMatch(password);
  }

  void _validateInputsP() {
    setState(() {
      _ispasswordValid = _validatepassword(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        key: _formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 40),
              child: Text(
                "Inscription",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.17),
              width: double.infinity,
              height: 650,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "S'inscrire :",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextField(
                    controller: _nomprenomController,
                    decoration: InputDecoration(
                      hintText: "Nom&Prénom / société",
                      suffixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        hintText: "Etablissement",
                        suffixIcon: Icon(Icons.house)),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextField(
                    controller: _phoneController,
                    focusNode: _phoneNumberFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Numéro de téléphone",
                        suffixIcon: Icon(Icons.phone),
                        errorText: _isPhoneNumberValid
                            ? null
                            : 'Please enter a valid phone number'),
                    onChanged: (_) => _validateInputsN(),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                        hintText: "Adresse Email",
                        suffixIcon: Icon(Icons.mail),
                        errorText: _isEmailValid
                            ? null
                            : 'Please enter a valid email'),
                    onChanged: (_) => _validateInputsE(),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    obscureText: hide,
                    decoration: InputDecoration(
                      hintText: "Mot de passe",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        icon: hide
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      errorText: _ispasswordValid
                          ? null
                          : ('Please enter a valid password'),
                    ),
                    onChanged: (_) => _validateInputsP(),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  RadioListTile(
                    value: "patient",
                    groupValue: type1,
                    onChanged: (value) {
                      setState(() {
                        type1 = value.toString();
                      });
                    },
                    title: Text("Patient"),
                  ),
                  RadioListTile(
                    value: "medecin",
                    groupValue: type1,
                    onChanged: (value) {
                      setState(() {
                        type1 = value.toString();
                      });
                    },
                    title: Text("Medecin"),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _specialiteController,
                    decoration: InputDecoration(
                        hintText: "spécialité",
                        suffixIcon: Icon(Icons.medical_services)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 80)),
                      onPressed: _isPhoneNumberValid &&
                          _isEmailValid &&
                          _ispasswordValid
                          ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginpage()));
                        _signup();
                      }
                          : null,
                      child: Text(
                        ("Envoyer"),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signup() async {
    String numero = _phoneController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String nomprenom = _nomprenomController.text;
    String privilege = type1;
    String address = _addressController.text;
    String specialite = _specialiteController.text;

    if (privilege == "patient") {
      http.Response response = await http.post(
        Uri.parse(endpoint +
            "Inscription/vendor/phpmailer/phpmailer/Nouveau_Inscription.php"),
        body: json.encode(
          {
            "nomprenom": nomprenom,
            "email": email,
            "address": address,
            "password": password,
            "privilege": privilege,
            "numero": numero
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
        );
      }
    } else {
      http.Response response = await http.post(
        Uri.parse(endpoint +
            "Inscription/vendor/phpmailer/phpmailer/Nouveau_Inscription.php"),
        body: json.encode(
          {
            "nomprenom": nomprenom,
            "email": email,
            "address": address,
            "password": password,
            "privilege": privilege,
            "numero": numero,
            "specialite": specialite
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
        );
      }
    }
  }
}



