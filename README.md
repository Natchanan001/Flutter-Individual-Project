# X (Twitter) Responsive Design Demo
### Individual Project — 662115022
 
---
 
## 📌 Git Repository
> https://github.com/Natchanan001/Flutter-Individual-Project.git
 
---
 
## Project Description
 
This project simulates the **X (Twitter)** Home screen to demonstrate **Responsive** and **Adaptive UI** principles in Flutter. The app dynamically adjusts its layout and navigation components based on the available screen width, providing an optimal experience across **Mobile**, **Tablet**, and **Desktop/Web** platforms — all from a single codebase.
 
> **Course:** 953464 Mobile Application Development
 
---
 
## 📸 Screenshots
 
| Mobile | Tablet | Desktop/Web |
|--------|--------|-------------|
| <img width="250" alt="Mobile" src="https://github.com/user-attachments/assets/4c961b81-2d91-4941-b3af-39b508f86ed2" /> | <img width="400" alt="Tablet" src="https://github.com/user-attachments/assets/0c37f6f4-b1f0-4334-a209-93cefc770694" /> | <img width="600" alt="Desktop" src="https://github.com/user-attachments/assets/69a32cad-122a-4c08-94b4-702dfeacac10" /> |
 
---
 
## Component Explanation
 
### Layout decision — `LayoutBuilder`
 
The entire layout switching logic sits inside `LayoutBuilder`. I chose this over `MediaQuery` at the top level because `LayoutBuilder` works off the actual constraints given to the widget, not the screen size — which makes more sense when thinking about reusability.
 
```dart
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
```
 
Breakpoints used:
 
| Width | Layout |
|-------|--------|
| < 600px | Mobile — single column, bottom nav |
| 600–1000px | Tablet — NavigationRail on the side |
| > 1000px | Desktop — 3-column layout |
 
---
 
### Mobile layout
 
```dart
Widget _buildMobileLayout() {
  return Column(
    children: [
      AppBar(...),
      Expanded(child: XFeed()),
    ],
  );
}
```
 
The `BottomNavigationBar` and `FloatingActionButton` are shown only on mobile. I used a simple boolean from `MediaQuery` for this since it's a quick true/false check on window width, not a layout decision:
 
```dart
bool isMobile = MediaQuery.of(context).size.width <= 600;
 
bottomNavigationBar: isMobile ? BottomNavigationBar(...) : null,
floatingActionButton: isMobile ? FloatingActionButton(...) : null,
```
 
---
 
### Tablet layout
 
Swaps the bottom nav for a `NavigationRail`. This follows the Medium breakpoint pattern from class — when you have more horizontal space, move navigation to the side.
 
```dart
Widget _buildTabletLayout() {
  return Row(
    children: [
      NavigationRail(
        labelType: NavigationRailLabelType.none,
        ...
      ),
      VerticalDivider(color: Color(0xFF2F3336)),
      Expanded(child: XFeed()),
    ],
  );
}
```
 
---
 
### Desktop/Web layout
 
3-column layout using `Flexible` with flex ratios so columns scale proportionally when the window resizes.
 
```dart
Widget _buildWebLayout() {
  return Row(
    children: [
      Flexible(flex: 2, child: SidebarMenu()),
      VerticalDivider(...),
      Expanded(flex: 4, child: XFeed()),
      VerticalDivider(...),
      Flexible(flex: 3, child: TrendingPanel()),
    ],
  );
}
```
 
The Trending section on the right fills what would otherwise be empty space on wide screens — same pattern as the actual X web app.
 
---
 
### `Sidebar Menu`
 
Extracted as its own `StatelessWidget`. Contains the X logo, nav items as `ListTile`, a full-width Post button, and a user profile row pinned to the bottom with `Spacer()`.
 
Keeping it as a separate class makes the web layout builder cleaner and the sidebar easier to modify independently.
 
---
 
### `XFeed`
 
Uses `ListView.builder` so only visible items get built — better performance than building all posts at once with a `Column`.
 
```dart
return ListView.builder(
  itemCount: posts.length,
  itemBuilder: (context, index) {
    final post = posts[index];
    // builds tweet card
  },
);
```
 
Each tweet card handles optional images with a null check:
 
```dart
if (post.imageUrl != null) ...[
  ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Image.network(post.imageUrl!),
  ),
]
```
 
---
 
### `Post` model
 
```dart
class Post {
  final String user, handle, content, time;
  final String? imageUrl;
 
  Post({
    required this.user,
    required this.handle,
    required this.content,
    required this.time,
    this.imageUrl,
  });
}
```
 
Separating data from UI means if I ever swap mock data for real API data, only this part needs to change.
 
---
 
## Overall App Structure
 
```
XApp (MaterialApp)
└── XHomePage (StatefulWidget)
    │
    ├── [< 600px]      AppBar + XFeed + BottomNav + FAB
    ├── [600–1000px]   NavigationRail + XFeed  
    └── [> 1000px]     SidebarMenu + XFeed + TrendingPanel
                                  │
                               XFeed
                          └── ListView.builder
                               └── Post model (mock data)
```
 
### Theme
 
```dart
ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
)
```
 
Divider color `0xFF2F3336` was picked directly from inspecting X's actual web UI.
 
---
 
## Cleaned Code
 
A few things I cleaned up from the initial version:
 
**1. Extracted widgets into separate classes**  
`SidebarMenu`, `XFeed`, and `Post` are their own classes. Building everything inline inside one widget made the file hard to read.
 
**2. Consistent breakpoints**  
`600` and `1000` are used consistently throughout — in `LayoutBuilder`, in the `isMobile` check, and in comments. No magic numbers scattered around.
 
**3. Null safety on optional image**  
`imageUrl` is `String?` and checked before rendering. No force-unwrap without a guard.
 
**4. `const` where possible**  
```dart
const XFeed()
const SidebarMenu()
const CircleAvatar(...)
```
Flutter can cache `const` widget instances, so they don't rebuild unnecessarily.
 
**5. Mock data stays in `XFeed`**  
Data is defined close to where it's used, not passed down through multiple layers for no reason.
 
---
 
## 📚 P'tao Content Coverage (Slide 01 & 02)
 
### From Slide 01 — Adaptive & Responsive Design
 
| Concept | Implementation in this project |
|---------|-------------------------------|
| Responsive vs Adaptive | Layout changes both placement (responsive) and navigation component type (adaptive) |
| Step 1: Abstract | `Post` model abstracts shared data; `SidebarMenu`, `XFeed` are separate widgets |
| Step 2: Measure | `LayoutBuilder` (local) + `MediaQuery` (global) used appropriately |
| Step 3: Branch | 3 breakpoints: < 600, 600–1000, > 1000 |
| MediaQuery | Used for `isMobile` boolean flag |
| LayoutBuilder | Used in `body` to select layout builder method |
| SafeArea | Handled via Scaffold; concept covered in Workshop 4 |
| Adaptive Breakpoints | Compact / Medium / Expanded standard followed |
 
### From Slide 02 — Automatic Platform Adaptations
 
| Concept | Notes |
|---------|-------|
| Page navigation | Uses `MaterialPageRoute` — auto-adapts transition (slide on iOS, fade on Android) |
| Typography | Material package auto-selects Roboto (Android) / San Francisco (iOS) |
| Iconography | `Icons.*` auto-adapts icon style per platform |
| Scrolling physics | `ListView` auto-applies platform-appropriate scroll physics |
| `.adaptive()` constructors | Available for `Switch`, `Slider`, `Checkbox`, `CircularProgressIndicator` |
| Design to form factor strengths | Mobile: touch-first, one task per screen; Web: more columns, more info density |

 ### From Slide 03 — Large Screen Devices & Adaptations
 
| Concept | Implementation in this project |
|---------|-------------------------------|
| **Significance of Large Screens** | Designed a 3-column layout for Desktop to improve user engagement metrics, following the "Growing demand across tablets & desktops" principle. |
| **Information Density** | Utilized extra horizontal space by adding a `TrendingPanel`. This avoids empty space and follows the "More details and more tasks" guideline for web/desktop. |
| **Visual Density** | Layout elements scale proportionally using `Flexible` and `Expanded` to maintain appropriate density for mouse users on larger displays. |
| **Navigation Adaptation** | Successfully transitioned from a Bottom Bar (Compact) to a `NavigationRail` (Medium) and finally a full `SidebarMenu` (Expanded) to suit different form factors. |
| **Design to Form Factor** | Optimized the UI for "Touch-first" on mobile and "Information-rich" on desktop, ensuring the app feels native to each device type. |
---
 
## 🚀 How to Run
 
```bash
# 1. Clone the repository
git clone https://github.com/Natchanan001/Flutter-Individual-Project.git
 
# 2. Install dependencies
flutter pub get
 
# 3. Run the app
flutter run
 
# To run on Chrome (Web)
flutter run -d chrome
```
 
**Requirements:**
- Flutter SDK ≥ 3.0
- Dart ≥ 3.0
 
---
 
**Developed by:** 662115022 Thanatchanan Kanjina  
**Course:** 953464 Mobile Application Development
