import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_interview/widgets/button.dart';
import 'package:graphql_interview/widgets/inputfield.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String mutation = """
  mutation registerUser(\$email: String!, \$username: String!, \$password: String!, \$phonenumber: String!, \$callingCode: String!, \$flag: String) {
   register(data: 
     {
       email: \$email,
       username: \$username,
       password: \$password,
       phonenumber: \$phonenumber,
       phoneNumberDetails: {
         phoneNumber: \$phonenumber, 
         callingCode: \$callingCode, 
         flag: \$flag
       }
     }) {
      user {
       id,
       email,
       username,
       phonenumber,
       phoneNumberDetails {
         phoneNumber,
         callingCode,
         flag
       },
     }
     token
   }
} 
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mutation(
        builder: (runMutation, result) {
          return Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 182.0),
                    child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                          color: Colors.greenAccent[700], fontSize: 32),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFields(
                    controller: null,
                    hint: "E-mail",
                    styleFontSize: 12,
                    underlineBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent[700]),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFields(
                    controller: null,
                    hint: "Username",
                    styleFontSize: 12,
                    underlineBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent[700]),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFields(
                    controller: null,
                    hint: "Password",
                    obscure: true,
                    styleFontSize: 12,
                    underlineBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.greenAccent[700]),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFields(
                    controller: null,
                    hint: "Phone Number",
                    styleFontSize: 12,
                    underlineBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent[700]),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AuthButton(
                        buttonColor: Colors.greenAccent[700],
                        name: Text(
                          "Register",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14),
                        ),
                        tap: () {},
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 5,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 25),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account! ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.greenAccent[700],
                            fontWeight: FontWeight.w300),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context, "login"
                                );
                              },
                            text: 'Sign In',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.greenAccent[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        options: MutationOptions(
          documentNode: gql(mutation),
        ),
      ),
    );
  }
}
