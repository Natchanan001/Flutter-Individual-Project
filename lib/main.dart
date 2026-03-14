import 'package:flutter/material.dart';
      //This is for individual mobile project by using X(Twitter) as a reference for responsive design and UI elements.

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
    bool isMobile = MediaQuery.of(context).size.width <= 600;

    return Scaffold(
      //Bottom Nav only for Mobile
      bottomNavigationBar: isMobile
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
      floatingActionButton: isMobile
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

  // 1. Mobile Layout
  Widget _buildMobileLayout() {
    return Column(
      children: [
        AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
            backgroundImage: AssetImage('assets/HDWi3XSa4AACQQm.jpeg'),
            ),
          ),
          title: const Text("X", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
          centerTitle: true,
          actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
        ),
        const Expanded(child: XFeed()),
      ],
    );
  }

  // 2. Tablet Layout 
  Widget _buildTabletLayout() {
    return Row(
      children: [
        NavigationRail(
          backgroundColor: Colors.black,
          labelType: NavigationRailLabelType.none,
          indicatorColor: Colors.transparent,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          leading: Column(
            children: [
              const SizedBox(height: 10),
              const Text("X", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              FloatingActionButton(
                mini: true,
                onPressed: () {},
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
          destinations: const [
            NavigationRailDestination(icon: Icon(Icons.home_filled), label: Text("Home")),
            NavigationRailDestination(icon: Icon(Icons.search), label: Text("Search")),
            NavigationRailDestination(icon: Icon(Icons.notifications_none), label: Text("Noti")),
            NavigationRailDestination(icon: Icon(Icons.mail_outline), label: Text("Mail")),
            NavigationRailDestination(icon: Icon(Icons.person_outline), label: Text("Profile")),
          ],
          selectedIndex: 0,
          trailing: const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child:CircleAvatar(
            backgroundImage: AssetImage('assets/HDWi3XSa4AACQQm.jpeg'),
            ),
              ),
            ),
          ),
        ),
        const VerticalDivider(width: 1, color: Color(0xFF2F3336)),
        const Expanded(child: XFeed()),
      ],
    );
  }

  // 3. Web Layout (3 Columns with Sidebar)
  Widget _buildWebLayout() {
    return Row(
      children: [
        const Flexible(flex: 2, child: SidebarMenu()),
        const VerticalDivider(width: 1, color: Color(0xFF2F3336)),
        const Expanded(flex: 4, child: XFeed()),
        const VerticalDivider(width: 1, color: Color(0xFF2F3336)),
        Flexible(
          flex: 3,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text("What's happening", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildTrendingItem("Politics · Trending", "#WW3", "1.2M Posts"),
              _buildTrendingItem("Entertainment · Trending", "#GenshinImpact", "500K Posts"),
              _buildTrendingItem("Technology", "ลูกช้างมช.", "190K Posts"),
              _buildTrendingItem("Politics · Trending", "#DonaldTrump", "1.5M Posts"),
              _buildTrendingItem("Entertainment · Trending", "#ตลาดนัดลาบูบู้", "500K Posts"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingItem(String category, String title, String posts) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(posts, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}

// Sidebar for Web
class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("X", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 20),
          const ListTile(leading: Icon(Icons.home_filled), title: Text("Home", style: TextStyle(fontSize: 18))),
          const ListTile(leading: Icon(Icons.search), title: Text("Explore", style: TextStyle(fontSize: 18))),
          const ListTile(leading: Icon(Icons.notifications_none), title: Text("Notifications", style: TextStyle(fontSize: 18))),
          const ListTile(leading: Icon(Icons.mail_outline), title: Text("Messages", style: TextStyle(fontSize: 18))),
          const ListTile(leading: Icon(Icons.person_outline), title: Text("Profile", style: TextStyle(fontSize: 18))),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              child: const Text("Post", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const Spacer(),
          const ListTile(
            leading: CircleAvatar(
            backgroundImage: AssetImage('assets/HDWi3XSa4AACQQm.jpeg'),
            ),
            title: Text("Natchanan", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("@natchanan_"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Feed Mock Data
class XFeed extends StatelessWidget {
  const XFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(user: "Natchanan", handle: "@natchanan_", content: "Flutter responsive DEMO ✨ #Flutter #AdaptiveUI", time: "1h"),
      Post(user: "Elon Musk (Mock)", handle: "@elonmusk", content: "Starship landing was amazing today!", imageUrl: "https://picsum.photos/id/237/600/400", time: "2h"),
      Post(user: "ปลาแซลม่อน", handle: "@salmon_fish", content: "Salmon sushi for lunch! 🥢🍣", imageUrl: "https://picsum.photos/id/1/600/300", time: "4h"),
      Post(user: "CAMT CMU", handle: "@camt_cmu", content: "บรรยากาศที่ CAMT วันนี้แดดฉ่ำมากค่ะน้าาาา", imageUrl: "https://picsum.photos/id/10/600/400", time: "5h"),
      Post(user: "Cafe Hopper",handle: "@cafe_cnx", content: "คาเฟ่เปิดใหม่แถวหลังมอ ถ่ายรูปสวยมาก แสงดีสุดๆ ใครสายคอนเทนต์ห้ามพลาด!", imageUrl: "https://picsum.photos/id/42/600/400", time: "8h"),
      Post(user: "Nature Lover", handle: "@mountain_hike", content: "Morning mist at Doi Inthanon today. 🏔️☁️ #ChiangMai #Thailand", imageUrl: "https://picsum.photos/id/15/600/400", time: "1d"),
    ];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF2F3336), width: 0.5))),
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
                    Text(post.content),
                    if (post.imageUrl != null) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(post.imageUrl!, fit: BoxFit.cover),
                      ),
                    ],
                    const SizedBox(height: 12),
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

class Post {
  final String user, handle, content, time;
  final String? imageUrl;
  Post({required this.user, required this.handle, required this.content, this.imageUrl, required this.time});
}




