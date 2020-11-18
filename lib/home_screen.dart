import 'package:flutter/material.dart';
import 'package:flutter_animation_test/item_details_screen.dart';
import 'package:flutter_animation_test/screen_title.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = [];
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    List<Item> list = [
      Item(id: 1, title: "title1", icon: Icons.access_alarm_sharp),
      Item(id: 2, title: "title2", icon: Icons.baby_changing_station),
      Item(id: 3, title: "title3", icon: Icons.videogame_asset_outlined),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future future = Future(() {});
      list.forEach((element) {
        future =
            future.then((_) => Future.delayed(Duration(milliseconds: 200), () {
                  items.add(element);
                  _listKey.currentState.insertItem(items.length - 1);
                }));
      });
    });
  }

  Tween<Offset> tween = Tween(
    begin: Offset(1, 0),
    end: Offset(0, 0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ScreenTitle(),
              AnimatedList(
                  key: _listKey,
                  initialItemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index, animation) {
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ItemDetailsScreen(
                                      item: items[index],
                                    ))),
                        title: Text(items[index].title),
                        leading: Hero(
                            tag: items[index].id,
                            child: Icon(items[index].icon)),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  int id;
  String title;
  IconData icon;

  Item({this.id, this.title, this.icon});
}
