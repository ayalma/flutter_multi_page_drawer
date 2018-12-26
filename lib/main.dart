import 'package:flutter/material.dart';
import 'package:flutter_multi_page_drawer/ui/navigation_drawer.dart';

void main() => runApp(MultiPageDrawerApp());

class MultiPageDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter multi page drawer',
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => FirstScreen(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/second': (context) => SecondScreen(),
      },
      builder: (context, child) {
        return DynamicApp(
          navigator: (child.key as GlobalKey<NavigatorState>),
          child: child,
        );
      },
    );
  }
}

class DynamicApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigator;
  final Widget child;
  List<DrawerItem> drawerItems = [
    DrawerItem("First Screen", Icons.first_page),
    DrawerItem("Second Screen", Icons.dashboard),
  ];

  DynamicApp({Key key, this.navigator, this.child}) : super(key: key);

  @override
  _DynamicAppState createState() => _DynamicAppState();
}

class _DynamicAppState extends State<DynamicApp> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        drawerItems: widget.drawerItems,
        headerView: Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://avatars3.githubusercontent.com/u/15701316?s=460&v=4"))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Ali Mohammadi",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onNavigationItemSelect: (index) {
          widget.navigator.currentState.pushNamed("/second");
          setState(() {
            _selectedIndex = index;
          });
          return true; // true means that drawer must close and false is Vice versa
        },
      ),
      body: widget.child,
    );
  }
}

class MyDrawer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;

  const MyDrawer({Key key, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = RootDrawer.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  "https://avatars3.githubusercontent.com/u/15701316?s=460&v=4"))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Ali Mohammadi",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('First page'),
            onTap: () {
              navigator.currentState.pushReplacementNamed("/");
              state.close();
            },
          ),
          ListTile(
            leading: Icon(Icons.send),
            title: Text('Second page'),
            onTap: () {
              navigator.currentState.pushNamed("/second");
              state.close();
            },
          ),
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First screen"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            RootScaffold.openDrawer(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          "First Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Text(
          "Second Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class RootDrawer {
  static DrawerControllerState of(BuildContext context) {
    final DrawerControllerState drawerControllerState =
        context.rootAncestorStateOfType(TypeMatcher<DrawerControllerState>());
    return drawerControllerState;
  }
}

class RootScaffold {
  static openDrawer(BuildContext context) {
    final ScaffoldState scaffoldState =
        context.rootAncestorStateOfType(TypeMatcher<ScaffoldState>());
    scaffoldState.openDrawer();
  }

  static ScaffoldState of(BuildContext context) {
    final ScaffoldState scaffoldState =
        context.rootAncestorStateOfType(TypeMatcher<ScaffoldState>());
    return scaffoldState;
  }
}
