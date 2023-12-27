import 'package:flutter/material.dart';

import '../model/usermodel.dart';
import '../services/servicefile.dart';
class AddPage extends StatefulWidget {
  final ValueChanged<User>onSavedUser;
  const AddPage({Key? key,
    required this.onSavedUser,
  }):  super(key:key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController character_cntrllr;
  late TextEditingController real_cntrllr;
  late TextEditingController role_cntrllr;
  late TextEditingController age_cntrllr;


  @override
  void initState(){
    super.initState();
    initUser();
  }
  void initUser(){
    character_cntrllr=TextEditingController();
    real_cntrllr=TextEditingController();
    role_cntrllr=TextEditingController();
    age_cntrllr=TextEditingController();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Superhero Form'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: character_cntrllr,
                decoration: InputDecoration(labelText: 'Character Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a character name';
                  }
                  return null;
                },
                onSaved: (value) {
                  // superhero.characterName = value!;
                },
              ),
              TextFormField(
                controller: real_cntrllr,
                decoration: InputDecoration(labelText: 'Real Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a real name';
                  }
                  return null;
                },
                onSaved: (value) {
                  // superhero.realName = value!;
                },
              ),
              TextFormField(
                controller: age_cntrllr,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  // age_cntrllr = int.parse(value!);
                },
              ),
              TextFormField(
                controller: role_cntrllr,
                decoration: InputDecoration(labelText: 'Role'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a role';
                  }
                  return null;
                },
                onSaved: (value) {
                  // superhero.role = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed:() async {
                  final form =_formKey.currentState!;
                  final isValid=form.validate();
                  if(isValid){
                    final user =User(
                      character_name:character_cntrllr.text,
                      real_name:real_cntrllr.text,
                      role:role_cntrllr.text,
                      age:int.parse(age_cntrllr.text), id: null
                    );
                    await UserSheetsApi.insert(user.toJson());
                    widget.onSavedUser(user);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}
