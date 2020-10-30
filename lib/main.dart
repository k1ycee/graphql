import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_interview/register.dart';
import 'package:graphql_interview/utils/globals.dart';
import 'package:graphql_interview/verify_user.dart';
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
    final AuthLink authlink = AuthLink(getToken: () => 'Bearer $authToken');
    final Link link = authlink.concat(httplink);

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: link,
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
        'login': (context) => GraphQLProvider(
              child: Login(),
              client: client,
            ),
        'verifyuser': (context) => GraphQLProvider(
              child: VerifyUser(),
              client: client,
            )
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                          color: Colors.greenAccent[700], fontSize: 32),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFields(
                    controller: emailController,
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
                    height: 15,
                  ),
                  TextFields(
                    controller: passwordController,
                    hint: "Password",
                    obscure: true,
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
                        // busy: result.loading,
                        buttonColor: Colors.greenAccent[700],
                        name: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14),
                        ),
                        tap: (){
                          runMutation({
                            "email": emailController.text,
                            "password": passwordController.text
                          });
                          authToken = result.data.data["login"]["token"].toString();
                          Navigator.pushNamed(context, "verifyuser");
                        },
                        height: MediaQuery.of(context).size.height / 18,
                        width: MediaQuery.of(context).size.width / 5,
                      ),
                    ],
                  ),
                  Text(result.data == null
                      ? "waiting..."
                      : result.data.data["login"]["token"].toString()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 25),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.greenAccent[700],
                            fontWeight: FontWeight.w300),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, "/");
                              },
                            text: 'Register',
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
