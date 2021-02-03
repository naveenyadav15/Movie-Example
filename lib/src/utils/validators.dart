
class Validators {

  static bool isValidPhone(String phone) {
    Pattern pattern = r'^^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(phone))
      return true;
    else
      return false;
  }
  static validatePhone(String phone) {
    // return _passwordRegExp.hasMatch(password);
    if (isValidPhone(phone))
      return null;
    else
      return 'Please enter a valid mobile number';
  }
  static validateOtp(String value) {
    // return _passwordRegExp.hasMatch(password);
    if (value == null || value.isEmpty)
      return 'Please enter a valid otp code';
    else
      return null;
  }
}
