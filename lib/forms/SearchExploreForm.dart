import 'package:flutter/material.dart';
import 'package:cs310_app/model.dart';
import 'package:cs310_app/utils/colors.dart';

//NOW NOT IN USE, BUT USEFUL WHEN WE IMPLEMENT BACKEND FOR THE SEARCH BAR

class NOTUSEDSearchExploreForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreen();
  }
}

  class SearchScreen extends State<NOTUSEDSearchExploreForm>
  {

  //EventCategory category;
  List <String> title = ['Concerts', 'Exhibitions', 'Meetings', 'Tutorials', 'Screenings' ];
  List <String> images = ['assets/concert.jpg', 'assets/exhibitions.jpg', 'assets/meetings.jpg','assets/tutorials.jpg', 'assets/screenings.jpg' ];


  Widget getTextWidgets(List<String> strings)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < strings.length; i++){
      list.add(new Text(strings[i],textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.27,
              color: AppColors.primary,)));
    }
    return new Row(children: list);
  }

  Widget getImageWidgets(List<String> strings)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < strings.length; i++){
      list.add(new Image.asset(strings[i]));
    }
    return new Row(children: list);
  }

  List filteredList = List();
  @override
  void initState() {
    super.initState();
    filteredList = title;
  }

  void filter(String inputString) {
    filteredList =
        title.where((i) => i.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search ',
              hintStyle: TextStyle(
                fontSize: 14,
              ),
            ),
            onChanged: (text) {
              text = text.toLowerCase();
              filter(text);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(filteredList[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Display(
                        text: filteredList[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

//EVENT
class Display extends StatelessWidget {
  final String text;

  const Display({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}

