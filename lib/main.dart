import 'package:flutter/material.dart';

void main() => runApp(MultipageDrawerApp());

class MultipageDrawerApp extends StatelessWidget {
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
        return Scaffold(
          drawer: MyDrawer(key:Key("main_drawer"),navigator: (child.key as GlobalKey<NavigatorState>)),
          body: child,
        );
      },
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
             //RootScaffold.openDrawer(context);
              //RootScaffold.of(context)
              //navigator.currentState.pop();
            },
          ),
        ],
      ),
    );
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
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
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
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped!
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}


class RootDrawer
{
  static DrawerControllerState of(BuildContext context){
    final DrawerControllerState drawerControllerState =
    context.rootAncestorStateOfType(TypeMatcher<DrawerControllerState>());
    return drawerControllerState;
  }
}