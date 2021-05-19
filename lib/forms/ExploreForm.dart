import 'package:flutter/material.dart';
import 'package:cs310_app/model.dart';
import 'package:cs310_app/utils/colors.dart';

import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


class SearchExploreForm extends StatefulWidget {
  const SearchExploreForm({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  SearchExploreFormState createState() => SearchExploreFormState();

}

class SearchExploreFormState extends State<SearchExploreForm>
{
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchExploreScreen extends StatelessWidget {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Whats around?'),
          backgroundColor: AppColors.headingColor,
          centerTitle: true,
        ),
        body: new Column(
            children: <Widget>[
        new Padding(
    padding: new EdgeInsets.all(8.0),
    child: new TextField(
    controller: searchController,
    decoration: InputDecoration(
    hintText: 'Search Events',
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0)),
    ), ),),


          new Expanded(
          child: new ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                Event(data[index]),
            itemCount: data.length,
          ),
        ),
    ],
        )),
    );
  }
}

  class Event extends StatelessWidget {
  const Event(this.entry);

  final EventCategory entry;

  Widget buildTiles(EventCategory context) {
  if (context.children.isEmpty) return ListTile(title: Text(context.title));
    return ExpansionTile(
      title: Text(
        context.title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          minHeight: 100,
          maxWidth: 100,
          maxHeight: 100,
        ),
        child: Image.asset(context.imagePath, fit: BoxFit.cover),
      ),

        children: context.children.map(buildTiles).toList(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return buildTiles(entry);
  }
}
