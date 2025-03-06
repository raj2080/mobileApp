import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginForm({Key? key, required this.emailController, required this.passwordController, required this.formKey})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    double textSize;
    EdgeInsetsGeometry textFieldPadding;
    double textFieldWidth;

    if (screenWidth < 360) {
      textSize = 14.0;
      textFieldPadding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0);
      textFieldWidth = screenWidth * 0.9;
    } else if (screenWidth < 600) {
      textSize = 16.0;
      textFieldPadding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0);
      textFieldWidth = screenWidth * 0.8;
    } else {
      textSize = 18.0;
      textFieldPadding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
      textFieldWidth = screenWidth * 0.7;
    }

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: textFieldWidth,
            child: _buildTextField(
              controller: emailController,
              label: 'Email or Phone Number',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email or phone number';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: textFieldWidth,
            child: _buildTextField(
              controller: passwordController,
              label: 'Password',
              icon: Icons.lock,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.purple),
        labelStyle: TextStyle(color: Colors.purple.shade700, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none, // Removes the sharp outline
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.purple.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.purple.shade700, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.purple.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
