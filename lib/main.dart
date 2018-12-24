import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => FirstScreen(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/second': (context) => SecondScreen(),
      },
      builder: (context, child) {
        return Scaffold(
          drawer: MyDrawer(),
          body: child,
        );
      },
    );
  }
}


class MultipageDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => FirstScreen(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/second': (context) => SecondScreen(),
      },
      builder: (context, child) {
        return Scaffold(
          drawer: MyDrawer(),
          body: child,
        );
      },
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Text("this is drawer"),
    );
  }
}


class RootScaffold {
  static openDrawer(BuildContext context) {
    final ScaffoldState scaffoldState =
    context.rootAncestorStateOfType(TypeMatcher<ScaffoldState>());
    scaffoldState.openDrawer();
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
          onPressed: (){
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