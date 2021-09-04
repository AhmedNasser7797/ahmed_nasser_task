import 'package:fiction_task/ui/screens/products_screen.dart';
import 'package:fiction_task/ui/widgets/red_custom_button.dart';
import 'package:fiction_task/ui/widgets/simple_textfield.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AppBar _appbar = AppBar();

  bool _autoValidate = false;
  String _email;
  String _phone;
  String _name;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      if (mounted)
        setState(() {
          _autoValidate = true;
        });
      return;
    }
    _formKey.currentState.save();
//nasser
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductsScreen(),
        ),
      );
      // final String type =
      //     await context.read<AuthProvider>().logIn(_email, _password);

    } catch (e) {
      print(' error $e');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fiction Apps Task',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: size.size.height -
              (_appbar.preferredSize.height + size.padding.top),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                ),
                SimpleTextField(
                  onSaved: (v) => _name = v,
                  hintText: "Name:",
                  label: "Name",
                  validationError: Validator(rules: [
                    RequiredRule(),
                  ]),
                ),
                SizedBox(
                  height: 12,
                ),
                SimpleTextField(
                  onSaved: (v) => _phone = v,
                  hintText: "Phone:",
                  label: "Phone",
                  textInputType: TextInputType.phone,
                  validationError: Validator(rules: [
                    RequiredRule(),
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                SimpleTextField(
                  onSaved: (v) => _email = v,
                  hintText: "Email:",
                  label: "Email",
                  textInputType: TextInputType.emailAddress,
                  validationError: Validator(rules: [
                    EmailRule(),
                  ]),
                ),
                //////////////////////////////////////////////
                SizedBox(
                  height: 40,
                ),
                Spacer(),
                CustomButton(
                  title: 'Proceed',
                  function: _submit,
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
