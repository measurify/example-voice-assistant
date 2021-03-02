import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:notify/homePage.dart';
import 'package:notify/measurementModel.dart';
import 'tokenModel.dart';
import 'userModel.dart';
import 'homePage.dart';
import 'measurementModel.dart';

void main() => runApp(MyApp());

TokenModel myToken;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'notify'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<TokenModel> notifyToken(String username, String password) async {
  final String loginUrl = 'http://students.atmosphere.tools/v1/login';

  final loginResponse = await http.post(loginUrl, body: {
    "username": username,
    "password": password,
  });

  if (loginResponse.statusCode == 200) {
    final String loginResponseString = loginResponse.body;

    return tokenFromJson(loginResponseString);
  } else {
    print(loginResponse.statusCode);
    return null;
  }
}

Future<UserModel> notifyThing(String myToken) async {
  final String thingUrl = 'http://students.atmosphere.tools/v1/things';
  String thingResponseString;

  final thingResponse = await http.get(thingUrl, headers: {
    "Authorization": myToken,
  });

  if (thingResponse.statusCode == 200) {
    thingResponseString = thingResponse.body;
    //print(thingResponse.body);

    return userModelFromJson(thingResponseString);
  } else {
    print(thingResponse.statusCode);
    thingResponseString = thingResponse.body;
    //print(thingResponse.body);
    return null;
  }
}

Future<MeasurementModel> getMeasurement(String token) async {
  final String measurementsUrl =
      'http://students.atmosphere.tools/v1/measurements';
  String getResponseString;

  final getResponse =
      await http.get(measurementsUrl, headers: {"Authorization": token});

  if (getResponse.statusCode == 200) {
    getResponseString = getResponse.body;

    return measurementModelFromJson(getResponseString);
  } else {
    print(getResponse.statusCode);
    getResponseString = getResponse.body;
    print(getResponseString);
    return null;
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 75.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final usernameField = TextField(
      controller: usernameController,
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: Icon(Icons.person),
        hintText: "Username",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: Icon(Icons.lock),
          hintText: "Password",
          filled: true,
          fillColor: Colors.white,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green[400],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          'Login',
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          final String username = usernameController.text;
          final String password = passwordController.text;

          myToken = await notifyToken(username, password);
          print(myToken.token);

          UserModel myUser = await notifyThing(myToken.token);
          print('User: ${myUser.docs[0].id}');

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(30),
          children: <Widget>[
            logo,
            SizedBox(height: 20.0),
            usernameField,
            SizedBox(
              height: 25.0,
            ),
            passwordField,
            SizedBox(
              height: 35.0,
            ),
            loginButton,
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
