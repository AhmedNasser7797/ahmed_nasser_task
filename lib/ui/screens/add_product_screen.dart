import 'dart:io';

import 'package:fiction_task/model/product_model.dart';
import 'package:fiction_task/ui/widgets/error_pop_up.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = true;
  bool _autoValidate = false;
  ProductModel _product;

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

  Future<void> _submit(BuildContext context) async {
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

    try {
      final uId = context.read<AuthProvider>().uid;
      await uploadFile(context);
      await context.read<ProductsProvider>().addProduct(
            ProductModel(
              imagePath: _imagesFolderPath,
              uploadedDate: DateTime.now(),
              type: widget.type,
              pounds: _pounds,
              name: _productName,
              expireDate: _dateTime,
              description: _description,
              imageUrl: _uploadedFileURL,
              farmerId: uId,
            ),
          );
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) =>
            ErrorPopUp(message: "Something Went Wrong! please try again."),
      );

      print('error add product ${e.code}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Products',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.88,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_product.imageFile == null) ...{
                GestureDetector(
                  onTap: () async {
                    Alert(
                      context: context,
                      title: "Choose how to put photo",
                      buttons: [
                        DialogButton(
                          color: Color(0xff055261),
                          width: 120,
                          child: Text(
                            'Camera',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 16,
                              color: const Color(0xffb9cc66),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            await takeImage();
                          },
                        ),
                        DialogButton(
                          color: Color(0xff055261),
                          width: 120,
                          child: Text(
                            'Gallery',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 16,
                              color: const Color(0xffb9cc66),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            await pickImage();
                          },
                        ),
                      ],
                    ).show();
                  },
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
                        'assets/images/intro.png',
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
                        Icon(Icons.close,
                          color: Color(0xFFe04f5f),
                          size: 24,),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Product Name',
                                style: TextStyle(
                                  fontFamily: 'SF Mono',
                                  fontSize: 10,
                                  color: const Color(0xff055261),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          onSaved: (value) => _product.title = value,
                          validator: Validator(
                            rules: [
                              RequiredRule(
                                  validationMessage: 'name is required'),
                            ],
                          ),
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xff055261),
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            hintText: 'enter your food name..',
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 12,
                              color: const Color(0x4d055261),
                              fontWeight: FontWeight.w500,
                            ),
                            fillColor: Color(0xff055261).withOpacity(0.05),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Pounds',
                                      style: TextStyle(
                                        fontFamily: 'SF Mono',
                                        fontSize: 10,
                                        color: const Color(0xff055261),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  if (value.length > 4) return;
                                },
                                keyboardType: TextInputType.number,
                                onSaved: (value) => _product. = int.parse(value),
                                validator: Validator(
                                  rules: [
                                    MaxLengthRule(
                                      3,
                                    ),
                                    RequiredRule(
                                        validationMessage:
                                            'pounds is Required'),
                                  ],
                                ),
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 16,
                                  color: const Color(0xff055261),
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  hintText: 'ex: 30',
                                  hintStyle: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 12,
                                    color: const Color(0x4d055261),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  fillColor:
                                      Color(0xff055261).withOpacity(0.05),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Expire Date',
                                      style: TextStyle(
                                        fontFamily: 'SF Mono',
                                        fontSize: 10,
                                        color: const Color(0xff055261),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              GestureDetector(
                                onTap: () => _showDateTime(),
                                child: Container(
                                  height: 51.0,
                                  width: 157.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: Color(0xff055261).withOpacity(0.05),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 11.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _pickedDate ?? 'pick date',
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Display',
                                            fontSize: 12,
                                            color: const Color(0xff055261),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff055261),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ////////////
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontFamily: 'SF Mono',
                                  fontSize: 10,
                                  color: const Color(0xff055261),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          minLines: 3,
                          maxLines: 6,
                          onSaved: (value) => _description = value,
                          validator: Validator(
                            rules: [
                              MinLengthRule(6,
                                  validationMessage: 'at least 6 character'),
                              RequiredRule(
                                  validationMessage: 'description is Required'),
                            ],
                          ),
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xff055261),
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            hintText: 'describe you product..',
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 12,
                              color: const Color(0x4d055261),
                              fontWeight: FontWeight.w500,
                            ),
                            fillColor: Color(0xff055261).withOpacity(0.05),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //////////////////////////////////////////////////////////

              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 144,
                        alignment: Alignment.center,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: const Color(0x00ffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xffff5858)),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xffff5858),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => _submit(
                        context,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: const Color(0xff055261),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
