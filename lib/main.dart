import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_interview/widgets/button.dart';
import 'package:graphql_interview/widgets/inputfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httplink =
        HttpLink(uri: "https://hagglex-backend.herokuapp.com/graphql");

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httplink,
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GraphQLProvider(
              child: Register(),
              client: client,
            ),
        'login': (context) => Login(),
        // 'register': (context) => Register()
      },
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mutation = """
  mutation userLogin(\$email: String!, \$password: String!){
   login(data:{
    email: \$email,
    password: \$password
  }){
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
                    padding: const EdgeInsets.only(left: 8.0, right: 220.0),
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                          color: Colors.greenAccent[400], fontSize: 32),
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
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFields(
                    controller: null,
                    hint: "Password",
                    styleFontSize: 12,
                    underlineBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
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
                        buttonColor: Colors.greenAccent,
                        name: Text(
                          "Login",
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
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w300),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context, "/"
                                );
                              },
                            text: 'Register',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.greenAccent,
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
                          color: Colors.greenAccent[400], fontSize: 32),
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
                      borderSide: BorderSide(color: Colors.greenAccent),
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
                      borderSide: BorderSide(color: Colors.greenAccent),
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
                    styleFontSize: 12,
                    underlineBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
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
                      borderSide: BorderSide(color: Colors.greenAccent),
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
                        buttonColor: Colors.greenAccent,
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
                            color: Colors.greenAccent,
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
                              color: Colors.greenAccent,
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
