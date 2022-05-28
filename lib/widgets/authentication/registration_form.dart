import 'package:flutter/material.dart';

class registrationForm extends StatefulWidget {
  var formKey = GlobalKey<FormState>();
  var controllerUsername = TextEditingController();
  var controllerPassword = TextEditingController();
  var controllerDisplayName = TextEditingController();
  Function submitForm;
  registrationForm(
      {Key? key,
      required this.formKey,
      required this.controllerUsername,
      required this.controllerPassword,
      required this.controllerDisplayName,
      required this.submitForm})
      : super(key: key);

  @override
  State<registrationForm> createState() => _registrationFormState();
}

class _registrationFormState extends State<registrationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: widget.controllerUsername,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Enter Username",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: widget.controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Enter Password",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: widget.controllerDisplayName,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Enter DisplayName",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                widget.submitForm();
              },
              icon: Icon(Icons.arrow_right),
              label: Text('Next'),
            )
          ],
        ));
  }
}
