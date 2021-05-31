import 'package:cs310_app/database.dart';
import 'package:cs310_app/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../utils/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:cs310_app/FirebaseOperations.dart';


class CreatePost with ChangeNotifier{
  TextEditingController captionController = TextEditingController();
  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  UploadTask imagePostUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async
  {
    final uploadPostImageVal = await picker.getImage(source: source);
    uploadPostImageVal == null ? print('Select Image'): uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImageVal.path);

    uploadPostImage != null ? showPostImage(context) :
        print('Image Upload Error');

    notifyListeners();
  }

  Future uploadPostImageToFirebase() async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'posts/${uploadPostImage.path}/${TimeOfDay.now()}'
    );

    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete((){
      print('Post image uploaded to storage');
    });
    imageReference.getDownloadURL().then((imageUrl)
    {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }


  selectPostImageType(BuildContext context)
  {
    return showModalBottomSheet(context: context, builder: (context)
    {
      return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color:Colors.blueGrey,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Divider(
                thickness: 4.0,
                color: Colors.white,
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
            [
              MaterialButton(
                  child: Text('Gallery',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                  )
                  ),
                  onPressed: ()
              {
                pickUploadPostImage(context, ImageSource.gallery);
              }),
              MaterialButton(
                  child: Text('Camera',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      )
                  ),
                  onPressed: () {
                    pickUploadPostImage(context, ImageSource.camera);
                  })

            ],)
          ]
        ),
      );

    });
  }

  showPostImage(BuildContext context)
  {
    return showModalBottomSheet(
        context: context,
        builder: (context)
    {
      return Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.38,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8.0, right: 8.0),
                  child: Container(height: 200.0,
                      width: 400.0,
                      child: Image.file(uploadPostImage, fit: BoxFit.contain)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            color: Colors.amber,
                            child: Text('Confirm',
                                style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,)),
                            onPressed: () {
                              uploadPostImageToFirebase().whenComplete(() {
                                editPostSheet(context);
                                print('Image is uploaded');
                              });
                            }
                        ),
                        MaterialButton(
                            color: Colors.amber,
                            child: Text('Reselect',
                                style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,)),
                            onPressed: () {
                              selectPostImageType(context);
                            }
                        ),
                      ]
                  ),
                )
              ]
          )
      );
    });
  }

  selectPostImage(BuildContext context)
  {
    return showModalBottomSheet(context: context, builder: (context)
    {
      return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:Colors.blueGrey,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
            children:[
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white,
                  )
              ),
              CircleAvatar(backgroundColor: Colors.transparent,
              radius: 60.0,
              backgroundImage: FileImage(uploadPostImage),),
              Row(children : [
                MaterialButton(
                  color: Colors.amber,
                  child: Text('Confirm',
                  style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,)),
                  onPressed: () {

                  }
                ),
                MaterialButton(
                    color: Colors.amber,
                    child: Text('Reselect',
                        style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,)),
                    onPressed: (
                        ) { selectPostImageType(context); }
                ),

              ])
            ]
        ),
      );

    });

  }

  editPostSheet(BuildContext context)
  {
    return showModalBottomSheet(isScrollControlled: true, context: context, builder: (context) {

      return Container(
          child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    )
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(icon: Icon(Icons.image_aspect_ratio, color: Colors.deepPurple),
                                onPressed: () {}),
                            IconButton(icon: Icon(Icons.fit_screen, color: Colors.amberAccent),
                                onPressed: () {})
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.file(uploadPostImage, fit: BoxFit.contain),
                      ),
                    ]
                  )
                ),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                        ),
                        Container(
                            height: 110.0,
                            width: 5.0,
                            color: Colors.amber
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Container(
                            height: 120.0,
                            width: 330.0,
                            child:TextField(
                              maxLines: 5,
                              textCapitalization: TextCapitalization.words,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              maxLengthEnforced: true,
                              maxLength: 100,
                              controller: captionController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                              decoration: InputDecoration(
                                hintText: 'give some details to us',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              )

                            ),
                          ),
                        )
                      ],
                    )
                ),
                MaterialButton(
                    child: Text('Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    ),)
                  ,
                    onPressed: () async
                {
                  Provider.of<FirebaseOperations>(context, listen: false).uploadPostData(
                    captionController.text, {
                      'caption': captionController.text,
                    'username': user_glob.displayName,
                    //getUserImage
                    'date': DateTime.now(),
                  }).whenComplete(()
                  {
                    Navigator.pop(context);
                  }
                  );
                },
                  color: Colors.blueGrey,
                )
              ]
          ),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(12.0),
          )

      );

    });
  }
}
