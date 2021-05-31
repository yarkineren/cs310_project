import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cs310_app/widgets/CreatePost.dart';


class FeedHelpers with ChangeNotifier
{
  Widget appBar(BuildContext context)
  {
    return AppBar(
      backgroundColor: Colors.deepPurple.withOpacity(0.6),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.camera_enhance_rounded), color: Colors.amber, onPressed: (){
          Provider.of<CreatePost>(context, listen:false).selectPostImageType(context);
        },)
      ],
      title: RichText(
        text: TextSpan(
          text: 'Social',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Feed',
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )
            )
          ]
        )
    )

    );
  }

  Widget feedBody(BuildContext context)
  {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context). size.width,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))
        ),
      ),
    );
  }
}