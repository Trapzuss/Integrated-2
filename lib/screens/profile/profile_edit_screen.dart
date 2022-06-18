import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  Widget _textFormFied() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.black),
                focusColor: Colors.black,
                icon: Icon(Icons.person),
                hintText: 'FirstName',
                hintStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.black),
                focusColor: Colors.black,
                icon: Icon(Icons.person),
                hintText: 'Surname',
                hintStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.black),
                focusColor: Colors.black,
                icon: Icon(Icons.email),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.black),
                focusColor: Colors.black,
                icon: Icon(Icons.flag),
                hintText: 'Country',
                hintStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.black),
                focusColor: Colors.black,
                icon: Icon(Icons.home),
                hintText: 'District',
                hintStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(90, 20, 20, 20),
                blurRadius: 10,
                offset: Offset(6, 6),
              ),
            ],
          ),
          child: SizedBox(
            child: ElevatedButton(
              child: Text("Save Changes"),
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.notWhite,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xfff6f6f6),
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 250, left: 20, right: 20),
            child: SingleChildScrollView(
              child: _textFormFied(),
            ),
          ),
          Container(
            height: 180,
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 190,
            margin: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(90, 20, 20, 20),
                    blurRadius: 0.8,
                    offset: Offset(9, 9),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 45,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 42,
                    backgroundImage: AssetImage('assets/images/shark.png'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'CatShark',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'No. 1 ,Soi Kanchanaphisek',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
