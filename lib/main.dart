import 'package:flutter/material.dart';

void main() {
  runApp(const XApp());
}

class XApp extends StatelessWidget {
  const XApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X Responsive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const XHomePage(),
    );
  }
}

class XHomePage extends StatefulWidget {
  const XHomePage({super.key});

  @override
  State<XHomePage> createState() => _XHomePageState();
}

class _XHomePageState extends State<XHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width <= 600
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: "Notifications"),
                BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: "Messages"),
              ],
            )
          : null,
      floatingActionButton: MediaQuery.of(context).size.width <= 600
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return _buildWebLayout();
          } else if (constraints.maxWidth > 600) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(backgroundColor: Colors.grey),
          ),
          title: const Text("X", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
          centerTitle: true,
          actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
        ),
        const Expanded(child: XFeed()),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        NavigationRail(
          backgroundColor: Colors.black,
          labelType: NavigationRailLabelType.none,
          destinations: const [
            NavigationRailDestination(icon: Icon(Icons.home_filled), label: Text("Home")),
            NavigationRailDestination(icon: Icon(Icons.search), label: Text("Search")),
            NavigationRailDestination(icon: Icon(Icons.notifications_none), label: Text("Noti")),
            NavigationRailDestination(icon: Icon(Icons.mail_outline), label: Text("Mail")),
          ],
          selectedIndex: 0,
        ),
        const VerticalDivider(width: 1, color: Color(0xFF2F3336)),
        const Expanded(child: XFeed()),
      ],
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        const Flexible(
          flex: 2,
          child: SidebarMenu(),
        ),
        const VerticalDivider(width: 1, color: Color(0xFF2F3336)),
        const Expanded(
          flex: 4,
          child: XFeed(),
        ),
        const VerticalDivider(width: 1, color: Color(0xFF2F3336)),
        Flexible(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Text("What's happening",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

//Model Mock
class Post {
  final String user;
  final String handle;
  final String content;
  final String? imageUrl;
  final String time;

  Post({required this.user, required this.handle, required this.content, this.imageUrl, required this.time});
}

class XFeed extends StatelessWidget {
  const XFeed({super.key});

  @override
  Widget build(BuildContext context) {
    //Mock Data
    final List<Post> posts = [
      Post(
        user: "Natchanan",
        handle: "@dnatchanan_",
        content: "Flutter responsive DEMO✨ #Flutter #AdaptiveUI",
        time: "1h",
      ),
      Post(
        user: "Elon Musk (Mock)",
        handle: "@elonmusk",
        content: "Starship landing was amazing today! Check out this view.",
        imageUrl: "https://picsum.photos/id/237/600/400",
        time: "2h",
      ),
      Post(
        user: "ปลาแซลม่อน",
        handle: "@salmon_fish",
        content: "Salmon sushi for lunch! 🥢🍣 #Foodie",
        imageUrl: "https://picsum.photos/id/1/600/300",
        time: "4h",
      ),
      Post(
        user: "CAMT CMU",
        handle: "@camt_cmu",
        content: "บรรยากาศที่ CAMT วันนี้แดดฉ่ำมากค่ะน้าาาา",
        imageUrl: "https://picsum.photos/id/10/600/400",
        time: "5h",
      ),
    ];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFF2F3336), width: 0.5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(radius: 20, backgroundColor: Colors.blueGrey),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(post.user, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        Text("${post.handle} · ${post.time}", style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(post.content, style: const TextStyle(fontSize: 15)),
                    
                    //images
                    if (post.imageUrl != null) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          post.imageUrl!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 200,
                              color: Colors.grey[900],
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),
                    // ปุ่ม Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey),
                        Icon(Icons.repeat, size: 18, color: Colors.grey),
                        Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                        Icon(Icons.bar_chart, size: 18, color: Colors.grey),
                        Icon(Icons.share_outlined, size: 18, color: Colors.grey),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: const [
        SizedBox(height: 20),
        Icon(Icons.flutter_dash, size: 40, color: Colors.white),
        SizedBox(height: 30),
        ListTile(leading: Icon(Icons.home_filled), title: Text("Home", style: TextStyle(fontSize: 18))),
        ListTile(leading: Icon(Icons.search), title: Text("Explore", style: TextStyle(fontSize: 18))),
        ListTile(leading: Icon(Icons.notifications_none), title: Text("Notifications", style: TextStyle(fontSize: 18))),
        ListTile(leading: Icon(Icons.mail_outline), title: Text("Messages", style: TextStyle(fontSize: 18))),
      ],
    );
  }
}