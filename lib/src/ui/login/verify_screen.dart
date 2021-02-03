import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_provider/src/provider/auth_provider.dart';
import 'package:movie_provider/src/ui/home/home_screen.dart';
import 'package:movie_provider/src/ui/widgets/common.dart';
import 'package:movie_provider/src/ui/widgets/mp_button.dart';
import 'package:movie_provider/src/ui/widgets/user_text_field.dart';
import 'package:movie_provider/src/utils/error.dart';
import 'package:movie_provider/src/utils/validators.dart';
import 'package:movie_provider/src/utils/variable.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  static const routeArgs = '/verify-screen';

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final otpController = TextEditingController();

  GlobalKey<FormState> _otpFormKey = GlobalKey();

  bool _isLoading = false;

  verifyOTP(BuildContext context) {
    setState(() {
      _isLoading = true;
    });
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyOTP(otpController.text.toString())
          .then((_) {
        // Navigator.of(context).pushNamed(HomeScreen.routeArgs);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeArgs);
      }).catchError((e) {
        String errorMsg = 'Error authenticating. Please Try again later!$e';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: MPText(
          text: "Verify OTP",
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _otpFormKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Please enter an OTP sent to your mobile number',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  UserTextField(
                    validator: Validators.validateOtp,
                    autofocus: true,
                    titleLabel: 'Enter 6 digit Code',
                    maxLength: 6,
                    icon: Icons.dialpad,
                    controller: otpController,
                    inputType: TextInputType.phone,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : MPRButton(
                              title: 'Verify Code',
                              height: cHeight * 0.0625,
                              onPressed: () {
                                verifyOTP(context);
                              },
                            ),
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
