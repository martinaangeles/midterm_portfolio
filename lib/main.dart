import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        fontFamily: 'Garamond',
      ),
      debugShowCheckedModeBanner: false,
      home: MyPortfolioPage(),
    );
  }
}

class MyPortfolioPage extends StatefulWidget {
  const MyPortfolioPage({
    super.key,
  });

  @override
  _MyPortfolioPageState createState() => _MyPortfolioPageState();
}

class _MyPortfolioPageState extends State<MyPortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth >= 1065;

    return Scaffold(
      body: isWeb
          ? WebLayout(
              scrollController: _scrollController,
              homeKey: _homeKey,
              aboutKey: _aboutKey,
              projectsKey: _projectsKey,
              contactKey: _contactKey,
            )
          : MobileLayout(),
    );
  }
}

class WebLayout extends StatelessWidget {
  final ScrollController scrollController;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  const WebLayout({
    required this.scrollController,
    required this.homeKey,
    required this.aboutKey,
    required this.projectsKey,
    required this.contactKey,
    super.key,
  });

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'MA',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  _buildNavButton("HOME", () => _scrollToSection(homeKey)),
                  _buildNavButton("ABOUT", () => _scrollToSection(aboutKey)),
                  _buildNavButton(
                      "PROJECTS", () => _scrollToSection(projectsKey)),
                  _buildNavButton(
                      "CONTACT", () => _scrollToSection(contactKey)),
                ],
              ),
              Row(
                children: [
                  _buildIconButton(
                    FontAwesomeIcons.linkedin,
                    'https://www.linkedin.com/in/martina-aaron-angeles/',
                  ),
                  _buildIconButton(
                    FontAwesomeIcons.facebook,
                    'https://www.facebook.com/martinaangeless',
                  ),
                  _buildIconButton(
                    FontAwesomeIcons.github,
                    'https://github.com/martinaangeles',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(key: homeKey, child: _buildHeroSection()),
            Container(key: aboutKey, child: _buildAboutSection()),
            Container(key: projectsKey, child: _buildProjectsSection()),
            Container(key: contactKey, child: _buildContactMeSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Widget _buildIconButton(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon),
      color: Colors.black,
      onPressed: () => _launchURL(url),
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://i.ibb.co/M969JZ0/9b4a249a-c7e7-47e7-8e7c-89e898f33a62.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Martina Angeles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Web Developer & Designer',
                style: TextStyle(color: Colors.white, fontSize: 29),
              ),
              const SizedBox(height: 50),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('CONTACT ME'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 100.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'About me',
                  style: TextStyle(
                    fontSize: 40,
                    shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.grey,
                        offset: Offset(3, 5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'She/Her. I am Mina from Davao City, Philippines. I am a creative and an aspiring web developer that specializes in Front-End development. I am currently a student in the Ateneo de Davao University majoring in Computer Science. I love coding as well as doing multimedia arts! Enjoy Browsing :D',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C2C2C),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  child: const Text(
                    'Download Resume',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 60, 100, 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'My Projects',
            style: TextStyle(
              fontSize: 40,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.grey,
                  offset: Offset(3, 5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              ProjectBox(
                'Guardian Disaster App',
                'assets/1.png',
                'https://www.behance.net/gallery/197708221/Guardian-Disaster-Emergency-App',
              ),
              ProjectBox(
                'Never for Ever! E-commerce',
                'assets/2.png',
                'https://github.com/kristine-ag/sad2-ecommerce/tree/ecommerce',
              ),
              ProjectBox(
                'Never for Ever! Admin',
                'assets/3.png',
                'https://github.com/kristine-ag/sad2-ecommerce/tree/admin',
              ),
              ProjectBox(
                'ALL Bookstore Website',
                'assets/4.png',
                'https://github.com/yvannnZL/all-bookstore',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ProjectBox(String title, String assetPath, String link) {
    return Container(
      width: 300,
      height: 450,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.brown.withOpacity(0.6),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 250),
            child: OutlinedButton(
              onPressed: () => _launchURL(link),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                side: const BorderSide(color: Colors.white),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactMeSection() {
    final _formKey = GlobalKey<FormState>();

    return Container(
      color: const Color(0xFF2C2C2C),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Feel free to reach out for collaborations or just a friendly chat!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField('Name'),
                const SizedBox(height: 10),
                _buildTextField('Email'),
                const SizedBox(height: 10),
                _buildTextField('Message', maxLines: 4),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Form submitted!');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                color: Colors.white,
                onPressed: () => _launchURL(
                    'https://www.linkedin.com/in/martina-aaron-angeles/'),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                color: Colors.white,
                onPressed: () =>
                    _launchURL('https://github.com/martinaangeles'),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook),
                color: Colors.white,
                onPressed: () =>
                    _launchURL('https://www.facebook.com/martinaangeless'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            '© 2024 Martina Angeles. All Rights Reserved.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}

class MobileLayout extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildAboutSection(),
            _buildProjectsSection(),
            _buildContactFormSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'MA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            _buildSocialIcons(),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              'MA',
              style: TextStyle(fontSize: 30, height: 5),
            ),
          ),
          _buildDrawerItem(">HOME"),
          _buildDrawerItem(">ABOUT"),
          _buildDrawerItem(">PROJECTS"),
          _buildDrawerItem(">CONTACT"),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      onTap: () {},
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          height: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://i.ibb.co/M969JZ0/9b4a249a-c7e7-47e7-8e7c-89e898f33a62.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Martina Angeles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Web Developer & Designer',
                style: TextStyle(color: Colors.white, fontSize: 29),
              ),
              const SizedBox(height: 250),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('CONTACT ME'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'About me',
            style: TextStyle(
              fontSize: 40,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.grey,
                  offset: Offset(3, 5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'She/ Her. I am a skilled and motivated 4th-year Bachelor of Computer Science '
            'student at Ateneo de Davao University. I specialize in front-end design and '
            'am passionate about web development.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF232222),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            child: const Text(
              'Download Resume',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 60, 40, 200),
      child: Column(
        children: [
          const Text(
            'My Projects',
            style: TextStyle(
              fontSize: 40,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.grey,
                  offset: Offset(3, 5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProjectBox(
                'Guardian Disaster App',
                'assets/1.png',
                'https://www.behance.net/gallery/197708221/Guardian-Disaster-Emergency-App',
              ),
              const SizedBox(height: 20),
              _buildProjectBox(
                'Never for Ever! E-commerce',
                'assets/2.png',
                'https://github.com/kristine-ag/sad2-ecommerce/tree/ecommerce',
              ),
              const SizedBox(height: 20),
              _buildProjectBox(
                'Never for Ever! Admin',
                'assets/3.png',
                'https://github.com/kristine-ag/sad2-ecommerce/tree/admin',
              ),
              const SizedBox(height: 20),
              _buildProjectBox(
                'ALL Bookstore Website',
                'assets/4.png',
                'https://github.com/yvannnZL/all-bookstore',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectBox(String title, String assetPath, String link) {
    return Container(
      width: 300,
      height: 450,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(assetPath, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.brown.withOpacity(0.6)),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 250),
            child: OutlinedButton(
              onPressed: () => _launchURL(link),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                side: const BorderSide(color: Colors.white),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactFormSection() {
    return Container(
      color: const Color(0xFF2C2C2C),
      padding: const EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Name'),
            const SizedBox(height: 10),
            _buildTextField('Email'),
            const SizedBox(height: 10),
            _buildTextField('Message', maxLines: 4),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Form submitted!');
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text('Submit', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      children: [
        IconButton(
          onPressed: () => _launchURL('https://github.com'),
          icon: const FaIcon(FontAwesomeIcons.github),
        ),
        IconButton(
          onPressed: () => _launchURL('https://linkedin.com'),
          icon: const FaIcon(FontAwesomeIcons.linkedin),
        ),
        IconButton(
          onPressed: () => _launchURL('https://twitter.com'),
          icon: const FaIcon(FontAwesomeIcons.twitter),
        ),
      ],
    );
  }
}
