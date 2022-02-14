import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextFormFieldUsage extends StatefulWidget {
  const TextFormFieldUsage({Key? key}) : super(key: key);

  @override
  _TextFormFieldUsageState createState() => _TextFormFieldUsageState();
}

class _TextFormFieldUsageState extends State<TextFormFieldUsage> {
  String _email = '', _password = '', _userName = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text form field kullanımı'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            //Değerimiz 4 karanterden az olduğunda hatayı göster
            child: Column(
              children: [
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    //errorStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Username',
                  ),
                  onSaved: (value) {
                    _userName = value!;
                  },
                  validator: (value) {
                    if (value!.length < 4) {
                      return 'Username en az  4 karakter olmalı';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: '',
                  decoration: const InputDecoration(
                    //errorStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Email',
                  ),
                  onSaved: (value) {
                    _email = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email boş olamaz';
                    } else if (!EmailValidator.validate(value!)) {
                      return 'Geçerli mail giriniz';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: '',
                  decoration: const InputDecoration(
                    //errorStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Password',
                  ),
                  onSaved: (value) {
                    _password = value!;
                  },
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Şifre en az 6 karakter olmalı';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      bool _validate = _formKey.currentState!.validate();
                      if (_validate) {
                        _formKey.currentState!.save();

                        String result =
                            'usernam: $_userName\nemail: $_email\nşifre: $_password';

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.orange.shade300,
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 24),
                            )));
                        _formKey.currentState!.reset();
                      }
                    },
                    child: Text('Onayla')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
