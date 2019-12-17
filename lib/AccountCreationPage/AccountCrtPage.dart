import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_k_csc_305/main.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:team_k_csc_305/frontPage/FrntViewPage.dart';
import 'package:team_k_csc_305/loginPage/loginPage.dart';

const AccountTypes = ['Club', 'Student'];
var selectedVal;

class AccountCreationPage extends StatefulWidget{

  AccountCreationState createState()=> AccountCreationState();
}

class AccountCreationState extends State<AccountCreationPage>{
  TextEditingController accEmail = TextEditingController();
  TextEditingController accName = TextEditingController();
  TextEditingController accPassword1 = TextEditingController();
  TextEditingController accPassword2 = TextEditingController();



  Future<void> AccExistError(String errorMsg, BuildContext context) async
  {
    return showDialog<void>(
      context: context,

      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Error creating account'),
                Text(
                    errorMsg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Try again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Return to login'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new LoginState();
                    }));
              },
            ),
          ],
        );
      },
    );
  }

  void _createUser(){
    Firestore.instance.collection('users').where('username', isEqualTo: accEmail.text).limit(1).getDocuments()
    .then((result) {
      List<DocumentSnapshot> documents = result.documents;
      int userType;
      if(documents.length == 0){
        if(selectedVal == 'Club'){
          userType = 1;
        }else{
          userType = 0;
        }

        if(accName.text.length == 0 || accEmail.text.length == 0 || accPassword1.text.length == 0){
          AccExistError('Missing Required Fields', context);
          return;
        }
        if(accPassword1.text == accPassword2.text){
          MyApp.appUser = new User(accName.text, accEmail.text, accPassword1.text, userType);

          Map<String, String> newEntry = new Map<String, String>();

          newEntry['username'] = accEmail.text;
          newEntry['password'] = accPassword1.text;
          newEntry['realname'] = accName.text;

          if(selectedVal == 'Club'){
            newEntry['userType'] = '1';
            Map<String, String> newClub = new Map<String, String>();
            newClub['name'] = accName.text;
            newClub['summary'] = 'Empty';
            Firestore.instance.collection('clubs').document().setData(newClub);

          }else{
            newEntry['userType'] = '0';
          }

          Firestore.instance.collection('users').document().setData(newEntry);
          print('Adding user...');

          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new FrntViewPage();
          }));
        }else{
          AccExistError('passwords do not match', context);
          print('passwords do not match...');
        }
      }else{
        AccExistError('user already exists', context);
        print('user already exists...');
      }

    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/URI_Logo.png',
                    width: 150,
                    fit: BoxFit.fitWidth,
                  ),
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 20,
                    ),
                  ),
                  Text(
                    'BetterBoard',
                    style: TextStyle(color: Colors.black, fontSize: 30.0),
            ),

                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 50),
                    TextField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: null ,
                    controller: accEmail,
                    decoration: InputDecoration(
                        labelText: "Enter your email",
                        hintText: "example@example.com",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),

                  ),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    controller: accName,
                    decoration: InputDecoration(
                        labelText: "Enter your name",
                        hintText: "John Smith",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),




                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    controller: accPassword1,
                    decoration: InputDecoration(
                        labelText: "Enter a password",
                        hintText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),

                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    controller: accPassword2,
                    decoration: InputDecoration(
                        labelText: "Enter password again",
                        hintText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),

                  ),
                  SizedBox(height: 25),
                  DropdownButton<String>(
                    hint: Text('Account Type'),
                    value: selectedVal,
                    isDense: true,
                    onChanged: (newValue){
                      setState(() {
                        selectedVal = newValue;
                      });

                    },
                    items: AccountTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),


                  ),
                  SizedBox(height: 50),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        _createUser();
                      },
                      textColor: Colors.white,
                      color: Colors.green,
                      height: 50,
                      child: Text("CREATE"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
