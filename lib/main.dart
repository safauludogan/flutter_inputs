import 'package:flutter/material.dart';
import 'package:flutter_inputs/text_form_field_usage.dart';

import 'global_key_usage.dart';

void main() => runApp(const TextFieldsOperations());

class TextFieldsOperations extends StatefulWidget {
  const TextFieldsOperations({Key? key}) : super(key: key);

  @override
  State<TextFieldsOperations> createState() => _TextFieldsOperationsState();
}

class _TextFieldsOperationsState extends State<TextFieldsOperations> {
  late TextEditingController _emailController;
  late FocusNode _focusNode;
  int maxLineCount = 1;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'safa@safa.com');
    _focusNode = FocusNode();
    _focusNode.addListener(() {//Buradaki amacımız, text'imize focuslandığımız zaman yüksekliğini 3 yapıyoruz, değilse 1
      setState(() {
        if (_focusNode.hasFocus) {
          maxLineCount = 3;
        } else {
          maxLineCount = 1;
        }
      });
    });
  }

  @override
  void dispose() {
    //Bu aktivite sonlansa bile listenerlar ve Controllerlar hafızadan silinmiyor. Bu yüzden bunları dispose ediyoruz.
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: GlobalKeyUsage(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              focusNode: _focusNode,
              controller: _emailController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autofocus: true,
              maxLines: maxLineCount,
              maxLength: 20,
              onChanged: (String value) {
                setState(() {
                  _emailController.value = TextEditingValue(
                      text: value,
                      selection:
                          TextSelection.collapsed(offset: value.length));
                });
              },
              onSubmitted: (String value) {
                print(value);
              },
              decoration: const InputDecoration(
                  labelText: 'Label text',
                  hintText: 'Gir ulan',
                  //icon: Icon(Icons.add),
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.access_alarms_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                  filled: true,
                  fillColor: Colors.orange),
              cursorColor: Colors.pink,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_emailController.text),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _emailController.text = 'newmail@gmail.com';
          });
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
