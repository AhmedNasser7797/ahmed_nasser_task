import 'dart:io';

import 'package:fiction_task/model/product_model.dart';
import 'package:fiction_task/ui/widgets/error_pop_up.dart';
import 'package:fiction_task/ui/widgets/red_custom_button.dart';
import 'package:fiction_task/ui/widgets/simple_textfield.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AppBar _appbar = AppBar();
  bool _isLoading = true;
  bool _autoValidate = false;
  ProductModel _product = ProductModel();

  ///////////// image picker from user ///////////
  Future<void> pickImage() async {
    final pFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pFile != null) {
      _product.imageFile = File(pFile.path);
      if (mounted) setState(() {});
    }
  }

  Future<void> takeImage() async {
    final pFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pFile != null) _product.imageFile = File(pFile.path);
    if (mounted) setState(() {});
  }

  void removeImage() => setState(() => _product.imageFile = null);

  //////////////// firebase storage /////////////

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    if (_product.imageFile == null) {
      return showDialog(
        context: context,
        builder: (ctx) => ErrorPopUp(message: 'please Choose Product Image!'),
      );
    }
    _formKey.currentState.save();

    try {} catch (e) {
      showDialog(
        context: context,
        builder: (ctx) =>
            ErrorPopUp(message: "Something Went Wrong! please try again."),
      );

      print('error add product ${e.code}');
    }
  }

  void openWithPopUp() {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Choose how to put photo"),
        content: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    takeImage();
                  },
                  child: Text("Camera"),
                  textColor: Colors.white,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    pickImage();
                  },
                  child: Text("Gallery"),
                  textColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.size.height -
              (_appbar.preferredSize.height + size.padding.top),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_product.imageFile == null) ...{
                GestureDetector(
                  onTap: openWithPopUp,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1a000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/product-placeholder.png',
                        width: 103,
                        height: 103,
                      ),
                    ),
                  ),
                )
              } else ...{
                GestureDetector(
                  onTap: () => removeImage(),
                  child: Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1a000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            _product.imageFile,
                            fit: BoxFit.fill,
                            width: 103,
                            height: 103,
                          ),
                        ),
                        Icon(
                          Icons.close,
                          color: Color(0xFFe04f5f),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              },
              SizedBox(
                height: 36,
              ),
              Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleTextField(
                      onSaved: (v) => _product.title = v,
                      hintText: "Name",
                      label: "Name",
                      validationError: Validator(rules: [
                        RequiredRule(),
                      ]),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////
                    SimpleTextField(
                      onSaved: (v) => _product.description = v,
                      hintText: "Description",
                      label: "Description",
                      validationError: Validator(rules: [
                        RequiredRule(),
                      ]),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////
                    SimpleTextField(
                      onSaved: (v) => _product.price = double.parse(v),
                      hintText: "Price",
                      label: "Price",
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      validationError: Validator(rules: [
                        RequiredRule(),
                      ]),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////

                    SimpleTextField(
                      onSaved: (v) => _product.priceForSale = double.parse(v),
                      hintText: "optional",
                      label: "Sale price",
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////
                    SimpleTextField(
                      onSaved: (v) => _product.numberInStock = int.parse(v),
                      hintText: "Product Stock",
                      label: "Product Stock",
                      validationError: Validator(rules: [
                        RequiredRule(),
                      ]),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomButton(function: _submit, title: "Proceed")
            ],
          ),
        ),
      ),
    );
  }
}
