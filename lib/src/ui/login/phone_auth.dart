import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_provider/src/provider/auth_provider.dart';
import 'package:movie_provider/src/ui/login/verify_screen.dart';
import 'package:movie_provider/src/ui/widgets/mp_button.dart';
import 'package:movie_provider/src/utils/error.dart';
import 'package:movie_provider/src/utils/validators.dart';
import 'package:movie_provider/src/utils/variable.dart';
import '../widgets/user_text_field.dart';
import '../widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {

  static const routeArgs = '/verify-screen';
  final phoneController = TextEditingController();

  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  String selectedCountryCode = '+91';

  verifyPhone(BuildContext context) {
    try {
      if (_phoneFormKey.currentState.validate()) {
        Provider.of<AuthProvider>(context, listen: false)
        // context.read<AuthProvider>()
            .verifyPhone(selectedCountryCode,
                selectedCountryCode + phoneController.text.toString())
            .then((value) {
          Navigator.of(context).pushNamed(VerifyScreen.routeArgs);
        }).catchError((e) {
          String errorMsg =
              'Error authenticating. Please try Again Later';
          if (e.toString().contains(
              'We have blocked all requests from this device due to unusual activity. Try again later.')) {
            errorMsg = 'Please wait as you have used limited number request';
          }
          showErrorDialog(context, errorMsg);
        });
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  void _onCountryChange(CountryCode countryCode) {
    selectedCountryCode = countryCode.toString();
    print("New Country selected: " + countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    cWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _phoneFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Login/Signup with your mobile number',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  UserTextField(
                    autofocus: true,
                    validator: Validators.validatePhone,
                    titleLabel: 'Enter your mobile number',
                    maxLength: 10,
                    icon: Icons.smartphone,
                    controller: phoneController,
                    inputType: TextInputType.phone,
                    prefix: CountryCodePicker(
                      initialSelection: selectedCountryCode,
                      onChanged: _onCountryChange,
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MPRButton(
                        title: 'Send OTP',
                        height: cHeight * 0.0625,
                        onPressed: () {
                          verifyPhone(context);
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
