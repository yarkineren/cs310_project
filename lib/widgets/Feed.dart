import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cs310_app/widgets/CreatePost.dart';

class FeedScreen extends StatefulWidget{
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      drawer: Drawer(),
        appBar: new AppBar(
          backgroundColor: Colors.deepOrangeAccent.withOpacity(0.6),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.camera_enhance_rounded), color: Colors.deepPurple, onPressed: (){
              Provider.of<CreatePost>(context, listen:false).selectPostImageType(context);
            },)
          ],
          title: RichText(
              text: TextSpan(
                  text: 'Event',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Buddy',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )
                    )
                  ]
              )
          )
    ),
      body: new SingleChildScrollView(
    child: Container(
    height: MediaQuery.of(context).size.height * 0.9,
    width: MediaQuery.of(context). size.width,
  decoration: BoxDecoration(
  color: Colors.deepOrangeAccent,
  borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))
  ),
  ),
    ),
      );
  }
}