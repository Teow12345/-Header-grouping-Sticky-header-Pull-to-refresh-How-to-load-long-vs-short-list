import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 18, 32, 47)),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListExample(),
    );
  }
}

class ListExample extends StatelessWidget {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() async {
    // Implement your refresh logic here, e.g., fetch new data.
    await Future.delayed(Duration(seconds: 1));

    // After fetching new data, you can update the UI as needed.
    // Example: update your list of items.
    // setState(() {
    //   items = updatedItems;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      child: CustomScrollView(
        slivers: [
          _StickyHeaderList(index: 0),
          _StickyHeaderList(index: 1),
          _StickyHeaderList(index: 2),
          _StickyHeaderList(index: 3),
          _StickyHeaderList(index: 4),
          _StickyHeaderList(index: 5),
        ],
      ),
    );
  }
}
class _StickyHeaderList extends StatelessWidget {
  final int index;

  const _StickyHeaderList({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Header(index: index),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(
            leading: CircleAvatar(
              child: Text('$index'),
            ),
            title: Text('List tile #$i'),
          ),
          childCount: 6,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final int index;

  const Header({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        'Header #$index',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}