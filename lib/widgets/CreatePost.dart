import 'package:cs310_app/database.dart';
import 'package:cs310_app/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../utils/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyCustomForm extends StatefulWidget {
  final User user;

  MyCustomForm({this.user});
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  void new_post(String text, File _image){ //will work from here
    var p= new Post(Author:user_glob.displayName,text: text, date: DateTime.now(), image: _image);
    p.setId(savePost(p));
  }

  Future getImage() async {
    final picker = ImagePicker();
    final picked_file = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (picked_file != null) {
        _image = File(picked_file.path);
      } else {
        print('No image selected.');
      }
    });
  }


  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  File _image;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Add Post'),
        ),
        body:postText(),
        floatingActionButton:
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        _getFAB(),
      );
    }
  }


  Widget postText() {
    {
      return Scaffold(
        body: TextField(
          controller: myController,
        ),
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field
      );
    }
  }

  Widget PostImage()
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Retrieve Image Input'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }


  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Colors.orange,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.assignment_turned_in),
            backgroundColor: Color(0xFF801E48),
            onTap: () async {
              //setState(() {
              new_post(myController.text, _image);
             // }
            },
            label: 'Send Post',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48)),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.add_a_photo),
            backgroundColor: Color(0xFF801E48),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostImage()));
            },
            label: 'Add Image',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48))
      ],
    );
  }

}

