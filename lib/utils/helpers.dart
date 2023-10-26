class Helpers {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address';
    }
    // Regular expression for a simple email validation
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null; // Return null to indicate that the input is valid
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    // You can add additional password validation rules here.
    // For example, you can check for minimum length or special characters.
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    // Add more validation rules as needed.

    return null; // Return null to indicate that the password is valid
  }
}
