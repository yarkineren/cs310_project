import 'package:cs310_app/widgets/Feed_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Feed extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      drawer: Drawer(),
      appBar: Provider.of<FeedHelpers>(context, listen:false).appBar(context),
      body:Provider.of<FeedHelpers>(context, listen:false).feedBody(context),
    );
  }

}