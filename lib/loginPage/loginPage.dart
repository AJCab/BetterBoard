import 'package:flutter/material.dart';
import 'package:team_k_csc_305/frontPage/FrntViewPage.dart';
import 'package:team_k_csc_305/menu.dart';
import 'package:team_k_csc_305/main.dart';
import 'package:team_k_csc_305/Clubs-Users-Events/Clubs-Users-Events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_k_csc_305/AccountCreationPage/AccountCrtPage.dart';



class LoginState extends StatelessWidget{
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future<void> loginError(String errorMsg, BuildContext context) async
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
                Text('Error logging in'),
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
          ],
        );
      },
    );
  }


  _authenticateUser(String name, BuildContext context){

    //Searches database for a user with that username
    Firestore.instance
        .collection('users')
        .where('username', isEqualTo: name)
        .limit(1).getDocuments()

        .then((result){
          List<DocumentSnapshot> documents = result.documents;

          //Check if one exits
          if(documents.length == 1){

            //Check password
            if(documents[0]['password'] == _password.text) {
                int userType;
                if(documents[0]['userType'] == '1') {
                  userType = 1;
                }else{
                  userType = 0;
                }
                //Authenticate
                MyApp.appUser =
                new User(documents[0]['realname'].toString(), _email.text, _password.text, userType);
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new FrntViewPage();
                        }));
              }
            else{
              loginError('Incorrect Password', context);
            }
        }else{
            loginError('No account exists for that email', context);
          }
    });
  }



  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection('users').document();

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
                      width: 100,
                      height: 20,
                    ),
                  ),

                  TextField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: null ,
                    controller: _email,
                    decoration: InputDecoration(
                        labelText: "Email",
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
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                        labelText: "Password",
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
                  SizedBox(height: 20),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () {_authenticateUser(_email.text, context);},
                      textColor: Colors.white,
                      color: Colors.green,
                      height: 50,
                      child: Text("LOGIN"),
                    ),
                  ),
                  SizedBox(height: 25),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new AccountCreationPage();
                        }));
                      },
                      textColor: Colors.white,
                      color: Colors.green,
                      height: 50,
                      child: Text("CREATE ACCOUNT"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}