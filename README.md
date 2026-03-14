# X (Twitter) Responsive Design Demo (Individual Project 662115022)

### 📝 Project Description
This project is a high-fidelity simulation of the **X (Twitter)** Home screen, developed to demonstrate **Responsive Design** and **Adaptive UI** principles in Flutter. The goal is to ensure a seamless and visually balanced user experience across multiple screen sizes, including Mobile, Tablet, and Desktop/Web platforms.

> **Note:** This project is developed and submitted exclusively for the **953464 Mobile Application Development** course.

---

## 📸 Project Screenshots
- **Mobile View:** `<img width="500" height="716" alt="Image" src="https://github.com/user-attachments/assets/1c6b8e23-40b7-4125-9e58-dd91adbaa110" />`
- **Tablet View:** `<img width="786" height="716" alt="Image" src="https://github.com/user-attachments/assets/8f78394e-8248-401a-864a-5ecca93717e9" />`
- **Desktop/Web View:** `<img width="1446" height="715" alt="Image" src="https://github.com/user-attachments/assets/69a32cad-122a-4c08-94b4-702dfeacac10" />`

---

## 🛠️ Components & Implementation
To create a realistic UI while maintaining code quality, the following Flutter widgets were implemented:
* **LayoutBuilder:** The core "Gatekeeper" used to monitor screen constraints and dynamically switch between layouts.
* **NavigationRail:** Used in Tablet mode to optimize vertical space according to Large Screen design standards.
* **Custom SidebarMenu:** A sophisticated sidebar for the Web version, featuring navigation items and a "Post" button.
* **ListView.builder:** Efficiently manages the tweet feed (Mock Data) to ensure smooth scrolling.
* **CircleAvatar & ClipRRect:** Handles profile images and post media with rounded corners (15px radius) as seen in the actual X app.

---

## 💡 Key Learnings from P'tao's Class

#### 1. Adaptive Layout (Slide 01)
The application implements the **Adaptive** approach by using `LayoutBuilder` to check `maxWidth` and define specific breakpoints:
* **Mobile (< 600px):** Single column layout focused on core content and Bottom Navigation.
* **Tablet (600px - 1000px):** Transitions to a `NavigationRail` to maximize usable screen area.
* **Desktop (> 1000px):** A full 3-column layout (Sidebar + Feed + Trending) to handle high information density.

#### 2. Automatic Layout (Slide 02)
Following **Flexible** layout principles, I utilized `Expanded` and `Flexible` widgets within the `XFeed`. This allows the content (Text & Media) to automatically calculate and fill the available space without causing layout overflows, regardless of the browser's width.

#### 3. Large Screen Optimization (Slide 03)
Focusing on **Visual Balance**, the Web version utilizes a multi-column structure. By integrating the "What's happening" (Trending) section, the design minimizes "dead space" and creates an informative, desktop-class experience.

---

## 🚀 How to Run
1. Clone this repository.
2. Ensure the profile image exists at `assets/HDWi3XSa4AACQQm.jpeg`.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to launch the application.

---
**Developed by:** 662115922 Thanatchanan Kanjina
**Course:** 953464 Mobile Application Development  
