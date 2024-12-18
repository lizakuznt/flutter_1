import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Главный виджет приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi-Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}

// 1. Первый экран: Авторизация
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB5B4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/medinow.png', // Путь к картинке на экране авторизации
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'medinow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Meditate With Us!',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 30),
            _buildButton(
              text: 'Sign in with Apple',
              color: Colors.white,
              textColor: Colors.black,
              onTap: () => _navigateTo(context, CourseScreen()),
            ),
            const SizedBox(height: 10),
            _buildButton(
              text: 'Continue with Email or Phone',
              color: Colors.blue,
              textColor: Colors.white,
              onTap: () => _navigateTo(context, CourseScreen()),
            ),
            TextButton(
              onPressed: () => _navigateTo(context, CourseScreen()),
              child: const Text(
                'Continue With Google',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: const Size(300, 50),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

// 2. Второй экран: Курс 3D Design
class CourseScreen extends StatelessWidget {
  final List<LessonItem> lessons = [
    LessonItem(
        'Introduction to 3D', '20 mins', 'assets/images/image1.png', true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Design Basic'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок и изображение
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/3d.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 140,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    color: Colors.blueAccent,
                    child: const Text(
                      'Best Seller',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '3D Design Basic',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'In this course you will learn how to build a space to a 3-dimensional product. There are 24 premium learning videos for you.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '24 Lessons (20 hours)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),

            // Список уроков
            ...lessons.map((lesson) => LessonCard(lesson)).toList(),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => _navigateTo(context, PopularMenuScreen()),
                child: const Text(
                  'Enroll - \$24.99',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

class LessonItem {
  final String title;
  final String duration;
  final String imagePath;
  final bool isCompleted;

  LessonItem(this.title, this.duration, this.imagePath, this.isCompleted);
}

class LessonCard extends StatelessWidget {
  final LessonItem lesson;

  const LessonCard(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            lesson.imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          lesson.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(lesson.duration),
        trailing: lesson.isCompleted
            ? const Icon(Icons.check_circle, color: Colors.blue)
            : const Icon(Icons.circle_outlined, color: Colors.grey),
      ),
    );
  }
}

// 3. Третий экран: Популярное меню с картинками
class PopularMenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem('Original Salad', 'Lovy Food', '\$8', 'assets/images/recmenu.png'),
    MenuItem(
        'Fresh Salad', 'Cloudy Resto', '\$10', 'assets/images/recmenu1.png'),
    MenuItem('Yummie Ice Cream', 'Circlo Resto', '\$6',
        'assets/images/recmenu2.png'),
    MenuItem(
        'Vegan Special', 'Haty Food', '\$11', 'assets/images/recmenu3.png'),
    MenuItem('Mixed Pasta', 'Recto Food', '\$13', 'assets/images/recmenu4.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Menu'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Поиск
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.filter_list, color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return MenuCard(menuItems[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.pinkAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String description;
  final String price;
  final String imagePath;

  MenuItem(this.name, this.description, this.price, this.imagePath);
}

class MenuCard extends StatelessWidget {
  final MenuItem menuItem;

  const MenuCard(this.menuItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(menuItem.imagePath, width: 50, height: 50),
        title: Text(menuItem.name, style: const TextStyle(fontSize: 18)),
        subtitle: Text(menuItem.description),
        trailing: Text(
          menuItem.price,
          style: const TextStyle(
              color: Colors.pinkAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
