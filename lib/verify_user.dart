import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_interview/utils/globals.dart';
import 'package:graphql_interview/widgets/button.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyUser extends StatefulWidget {
  @override
  _VerifyUserState createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  String mutation = """
  mutation verifyUserInput(\$code: Int!){
   verifyUser(data: {
    code: \$code
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
  }
}
  """;
  String _otp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mutation(
        options: MutationOptions(
          documentNode: gql(mutation),
        ),
        builder: (runMutation, result) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: OTPTextField(
                  width: 20,
                  length: 6,
                  fieldStyle: FieldStyle.box,
                  onChanged: (v) => {
                    setState(() {
                      _otp = v;
                    })
                  },
                  onCompleted: (v) => {
                    setState(() {
                      _otp = v;
                    })
                  },
                ),
              ),
            ),
            AuthButton(
              buttonColor: Colors.greenAccent[700],
              name: Text(
                "Verify",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              ),
              tap: () {
                runMutation({"code": _otp});
              },
              height: MediaQuery.of(context).size.height / 18,
              width: MediaQuery.of(context).size.width / 5,
            ),
            Text(result.data == null
                ? "expecting"
                : "arrived")
          ],
        ),
      ),
    );
  }
}
