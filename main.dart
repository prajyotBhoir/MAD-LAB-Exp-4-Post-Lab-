import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = "My Form";
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
            backgroundColor: Color(0xFF555555),
          ),
          body: MyForm(),
        ));
  }
}

class MyForm extends StatefulWidget {
  @override
  MyFormState createState() {
    return MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  var genderOptions = ['Male', 'Female', 'Others'];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your name.',
              labelText: 'Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter valid name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_box_sharp),
              hintText: 'Enter your Roll number.',
              labelText: 'PRN',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter correct PRN';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.cake_outlined),
              hintText: 'Enter your DOB.',
              labelText: 'D.O.B.',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter correct DOB';
              }
              return null;
            },
          ),
          FormBuilderDropdown(
            name: 'Gender',
            decoration: const InputDecoration(
              labelText: 'Gender',
            ),
            allowClear: true,
            hint: const Text("Select Gender"),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: "Select your gender")
            ]),
            items: genderOptions
                .map((gender) => DropdownMenuItem(
              value: gender,
              child: Text('$gender'),
            ))
                .toList(),
          ),
          FormBuilderChoiceChip(
            name: 'choice',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: "Select your branch"),
            ]),
            decoration: const InputDecoration(
              labelText: "Select your branch",
            ),
            options: [
              FormBuilderFieldOption(value: "CE", child: Text('CE')),
              FormBuilderFieldOption(value: "IT", child: Text('IT')),
              FormBuilderFieldOption(value: "EXTC", child: Text('EXTC')),
              FormBuilderFieldOption(value: "MECH", child: Text('MECH')),
            ],
          ),
          CheckboxListTileFormField(
            title: Text('Agree to terms and condtions !'),
            onSaved: (bool? value) {
              print(value);
            },
            validator: (bool? value) {
              if (value!) {
                return null;
              } else {
                return 'This is required';
              }
            },
            onChanged: (value) {
              if (value) {
                print("ListTile Checked :)");
              } else {
                print("ListTile Not Checked :(");
              }
            },
            autovalidateMode: AutovalidateMode.always,
            contentPadding: EdgeInsets.all(1),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _formKey.currentState!.reset();
                },
              ),
              RaisedButton(
                child: Text('Submit',style: TextStyle(color:Color(0xFFFFFFFF),),),
                color: Color(0xFF555555),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Data is processing")));
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
