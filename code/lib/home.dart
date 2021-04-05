import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myportfolio/app_icons.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// The artboard we'll use to play one of its animations
  Artboard _artboard;
  double _offset = 0;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  /// Loads dat afrom a Rive file and initializes playback
  _loadRiveFile() async {
    // Load your Rive data
    final data = await rootBundle.load('assets/animations/web.riv');
    // Create a RiveFile from the binary data
    final file = RiveFile();
    if (file.import(data)) {
      // Get the artboard containing the animation you want to play
      final artboard = file.mainArtboard;
      // Create a SimpleAnimation controller for the animation you want to play
      // and attach it to the artboard
      artboard.addController(SimpleAnimation('Animation 1'));
      // Wrapped in setState so the widget knows the animation is ready to play
      setState(() => _artboard = artboard);
    }
  }

  // @override
  // Widget build(BuildContext context) =>
  //     _artboard != null ? Rive(artboard: _artboard) : Container();

  // inportant for parallax scrolling - https://www.youtube.com/watch?v=IuPqIwY3bEo
  // to decrease size of images use -https://tinypng.com/
  // Question - https://discord.com/channels/420324994703163402/530797119389564939/825312651244339220
  // Answer - https://discord.com/channels/420324994703163402/530797119389564939/825318396806955019
  // anything under 500kb is ok and anything under 100 kb is perfect
  // np, don't use assets bigger than 1 mb and never that are bigger than 5 mb

  // great resources - Unsplash, Undraw
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
            child: NotificationListener<ScrollNotification>(
                onNotification: updateOffsetAccordingToScroll,
                child: RawScrollbar(
                  thumbColor:
                      Color.fromARGB(250, 1 * 16 + 6, 8 * 16 + 7, 10 * 16 + 7),
                  radius: Radius.circular(5),
                  thickness: 10,
                  child: Column(children: <Widget>[
                    Expanded(
                        child: Stack(
                      children: [
                        Positioned(
                          top: -0.25 * _offset,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: height, maxWidth: width),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [
                                    _artboard != null
                                        ? Rive(
                                            artboard: _artboard,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(),
                                  ],
                                )),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              // sized box
                              // to give space
                              // check this out- https://youtu.be/EHPu_DzRfqA
                              SizedBox(
                                height: height,
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.all(100.0),
                                  child: Container(
                                    width: 240.0,
                                    height: 42.0,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(
                                            'Hi! I am',
                                            //selectionControls: TextSelectionControls(),
                                            style: GoogleFonts.getFont(
                                              'Averia Serif Libre',
                                              textStyle: TextStyle(
                                                fontSize: width / 25,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 219, 216, 227),
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height / 30,
                                            width: width / 10,
                                          ),
                                          SelectableText(
                                            'Archit Sangal',
                                            style: GoogleFonts.getFont(
                                              'Dancing Script',
                                              textStyle: TextStyle(
                                                fontSize: width / 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height / 30,
                                            width: width / 10,
                                          ),
                                          SelectableText(
                                            'Mobile and Web Developer',
                                            style: GoogleFonts.getFont(
                                              'Pacifico',
                                              textStyle: TextStyle(
                                                fontSize: width / 50,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.pink,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 1.2 * height,
                                  width: width,
                                  color: Colors.black,
                                  child: Stack(children: [
                                    Center(
                                      child: FadeInImage.memoryNetwork(
                                          fit: BoxFit.cover,
                                          placeholder: kTransparentImage,
                                          image: 'assets/images/aboutme.jpg'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(100.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                'About Me',
                                                style: GoogleFonts.getFont(
                                                  'Pacifico',
                                                  textStyle: TextStyle(
                                                    fontSize: width / 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    height: 1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height / 10,
                                                width: width / 10,
                                              ),
                                              SizedBox(
                                                width: width / 3 - 105,
                                                child: SelectableText(
                                                  "I am a Bengaluru-based engineering " +
                                                      "student pursuing an Integrated M.Tech., " +
                                                      "i.e., B.Tech. + M.Tech. degree in Computer Science at" +
                                                      " International Institute of Information Technology, Bangalore (IIITB)." +
                                                      " I like graphic designing and fluttering. I have" +
                                                      " worked with FOSSEE, IIT BOMBAY in a " +
                                                      "summer fellowship. I am also a member of Zense" +
                                                      " Club, the official programming and development" +
                                                      " club of IIITB. I design and make" +
                                                      " mobile and web applications.",
                                                  style: GoogleFonts.getFont(
                                                    'Source Code Pro',
                                                    textStyle: TextStyle(
                                                      fontSize: width / 90,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 5,
                                                  ),
                                                ),
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: width / 5,
                                                      maxHeight: height / 2),
                                                  child: FadeInImage(
                                                    placeholder: MemoryImage(
                                                        kTransparentImage),
                                                    image: new NetworkImage(
                                                        "https://i.imgur.com/ihm74EX.jpg"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                              Container(
                                height: 1.1 * height,
                                width: width,
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Row(children: [
                                      Container(
                                        height: height * 1.2,
                                        width: width / 3,
                                        child: FadeInImage(
                                          placeholder:
                                              MemoryImage(kTransparentImage),
                                          image: new NetworkImage(
                                              "https://i.imgur.com/ef4CTzT.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        height: height * 1.2,
                                        width: 5 * width / 9,
                                        child: Padding(
                                          padding: const EdgeInsets.all(50.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SelectableText(
                                                'Skills',
                                                style: GoogleFonts.getFont(
                                                  'Pacifico',
                                                  textStyle: TextStyle(
                                                    fontSize: width / 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    height: 1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height / 10,
                                                width: width / 10,
                                              ),
                                              SelectableText(
                                                'I am a full Stack Developer and have experience of making great looking responsive mobile apps and websites.' +
                                                    ' The websites and apps made by me are easy to maintain. I have an affinity for graphic designing and front end development but' +
                                                    ' I can work equally efficiently on backend as well. I like making digital art. Following are the key highlights -',
                                                style: GoogleFonts.getFont(
                                                  'Source Code Pro',
                                                  textStyle: TextStyle(
                                                    fontSize: width / 90,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    height: 1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height / 20,
                                                width: width / 20,
                                              ),
                                              Container(
                                                child: Wrap(
                                                  children: [
                                                    skillbutton("Flutter"),
                                                    skillbutton("Dart"),
                                                    skillbutton("Rive"),
                                                    skillbutton("Firebase"),
                                                    skillbutton("Java"),
                                                    skillbutton("C++"),
                                                    skillbutton("Python"),
                                                    skillbutton("C"),
                                                    skillbutton("UI/UX"),
                                                    skillbutton(
                                                        "Android Developer"),
                                                    skillbutton(
                                                        "iOS Developer"),
                                                    skillbutton(
                                                        "Web Developer"),
                                                    skillbutton(
                                                        "Adobe Illustrator"),
                                                    skillbutton(
                                                        "Adobe InDesign"),
                                                    skillbutton(
                                                        "Adobe Photoshop"),
                                                    skillbutton("GitHub"),
                                                    skillbutton("Git"),
                                                    skillbutton("Assembly"),
                                                    skillbutton("Verilog"),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height / 15,
                                                width: width / 15,
                                              ),
                                              SelectableText(
                                                '"  I want to make things that inspire\n       and truly make a difference.     "',
                                                style: GoogleFonts.getFont(
                                                  'Nanum Gothic',
                                                  textStyle: TextStyle(
                                                    fontSize: width / 40,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.pink,
                                                    height: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                              // projects
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 15 * 16 + 6,
                                      15 * 16 + 5, 15 * 16 + 5),
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: width, minHeight: 1 * height),
                                  child: Padding(
                                    padding: const EdgeInsets.all(40),
                                    child: Wrap(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Text(
                                              "My Projects",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.getFont(
                                                'Pacifico',
                                                textStyle: TextStyle(
                                                  fontSize: width / 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255,
                                                      2 * 16 + 7,
                                                      6 * 16 + 6,
                                                      7 * 16 + 8),
                                                ),
                                              ),
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: projects(),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Contacts
                              Container(
                                width: width,
                                height: 1 * height,
                                child: Stack(children: [
                                  Container(
                                    height: height,
                                    width: width,
                                    child: FadeInImage(
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      image: new NetworkImage(
                                          "https://i.imgur.com/GBDiihc.jpg"),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(100.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width / 100),
                                        color:
                                            Color.fromARGB(130, 255, 255, 255),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SelectableText(
                                              'Contact Me',
                                              style: GoogleFonts.getFont(
                                                'Pacifico',
                                                textStyle: TextStyle(
                                                  fontSize: width / 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255,
                                                      3 * 1 + 4,
                                                      4 * 2 + 7,
                                                      6 * 4 + 14),
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 10,
                                              width: width / 10,
                                            ),
                                            SelectableText(
                                              'Email: architsangal2000@gmail.com',
                                              style: GoogleFonts.getFont(
                                                'Source Code Pro',
                                                textStyle: TextStyle(
                                                  fontSize: width / 40,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 20,
                                              width: width / 10,
                                            ),
                                            SelectableText(
                                              'GitHub: https://github.com/architsangal',
                                              style: GoogleFonts.getFont(
                                                'Source Code Pro',
                                                textStyle: TextStyle(
                                                  fontSize: width / 40,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 20,
                                              width: width / 10,
                                            ),
                                            SelectableText(
                                              'Phone No: (+91)9548697992',
                                              style: GoogleFonts.getFont(
                                                'Source Code Pro',
                                                textStyle: TextStyle(
                                                  fontSize: width / 40,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 20,
                                              width: width / 10,
                                            ),
                                            SelectableText(
                                              'LinkedIn: linkedin.com/in/archit-sangal-aa7185190',
                                              style: GoogleFonts.getFont(
                                                'Source Code Pro',
                                                textStyle: TextStyle(
                                                  fontSize: width / 40,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 20,
                                              width: width / 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),

                              // copyright
                              Container(
                                color: Colors.black,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: width, minHeight: height / 16),
                                  child: Center(
                                    child: Text(
                                      "CopyRight \u00a9 2021 onwards, Archit Sangal. All Rights Reserved.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height / 190 + width / 190),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  ]),
                ))));
  }

  // Notification Bubbling - https://api.flutter.dev/flutter/widgets/NotificationListener-class.html
  bool updateOffsetAccordingToScroll(ScrollNotification scrollNotification) {
    setState(() {
      _offset = scrollNotification.metrics.pixels;
    });
    return true;
  }

  Padding skillbutton(String text) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 60),
          border: Border.all(
            color: Colors.black,
            width: width / 350,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SelectableText(
            text,
            style: GoogleFonts.getFont(
              'Nanum Gothic',
              textStyle: TextStyle(
                fontSize: width / 80,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container projects() {
    return Container(
      child: Wrap(
        children: [
          card(
              'https://i.imgur.com/Vd4nc50.jpg',
              'Portfolio In Flutter',
              'Primary Developer',
              "This is a flutter project. This is the very project you are looking at right now. It is responsive(still not completely implemented). Animation used for moon and shooting star use rive. It use new scrolling techinques like 'Parallex Effect' and 'zoom out'(still not completely implemented).",
              "https://architsangal.github.io/Archit_Sangal_Portfolio/#/",
              [
                "https://github.com/architsangal/Flutter-Web-Code",
                "https://github.com/architsangal/Archit_Sangal_Portfolio",
                "https://github.com/architsangal/Archit_Sangal_Portfolio#hi-there-",
                //"https://editor.rive.app/file/web/53754",
                //"https://editor.rive.app/file/mobile/53855",
              ],
              [
                "Flutter Code",
                "Generated JavaScript Code",
                //"Rive Animation Web",
                //"Rive Animation Mobile",
                "README"
              ],
              [
                1,
                1,
                //2,
                //2,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              [
                'dart',
                'flutter',
                'rive',
              ],
              true),
          card(
              'https://i.imgur.com/xPAOSJD.jpg',
              'FoodFast',
              'Primary Developer',
              "This is a flutter project for IIITB canteen. Using this app we can order food. Pay it using upi. We can also pay at the time of recieving order. Much attention is paid to it's UI/UX aspect.But it is only made for the users of iiitb. So in order to use it, you must have a iiit outlook address.",
              "",
              [
                "https://github.com/architsangal/FoodFast",
                "https://github.com/architsangal/FoodFast/blob/master/README.md",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              [
                'Flutter',
                'Dart',
                'Rive',
                'Android',
                'iOS',
                'Web',
                'API',
                'Firebase',
                'Adobe Illustrator'
              ],
              true),
          card(
              'https://i.imgur.com/l7diYNb.jpg',
              'IIT Bombay FOSSEE fellowship',
              'Contributor',
              "Under FOSSEE, Indian Institute of Technology, Bombay followship we made Lecture notes on Linear Algebra. It was my first fellowship and was offered to me in my first year (in 2020), under Prof. Prabhu Ramachandran. We use manim for this project(Python -based animation tool). Feel free to check out the lecture notes. Links are given below -",
              "https://math.animations.fossee.in/contents/linear-algebra",
              [
                "https://github.com/architsangal/FSF-mathematics-python-code-archive/tree/master/FSF-2020/linear-algebra/linear-transformations",
                "https://math.animations.fossee.in/contents/linear-algebra/linear-transformations/linear-transformations-(linear-maps)",
                "https://math.animations.fossee.in/contents/linear-algebra/linear-transformations/the-four-fundamental-subspaces",
                "https://math.animations.fossee.in/contents/linear-algebra/linear-transformations/orthonormal-bases",
                "https://math.animations.fossee.in/contents/linear-algebra/linear-transformations/gram-schmidt-orthogonalization-process",
                "https://github.com/architsangal/FSF-mathematics-python-code-archive/tree/master/FSF-2020/linear-algebra/linear-transformations#contributer-archit-sangal",
                "https://drive.google.com/file/d/1mwfxXs8ktzMRagwzUrCR6PH_lInEryCi/view?usp=sharing",
              ],
              [
                "Source Code",
                "Lecture Notes: Linear Transformations (Linear Maps)",
                "Lecture Notes: The Four Fundamental Subspaces",
                "Lecture Notes: Orthonormal Bases",
                "Lecture Notes: Gram-Schmidt Orthogonalization Process",
                "README",
                "Certificate"
              ],
              [
                1,
                5,
                5,
                5,
                5,
                3,
                4,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              [
                'Manim',
                'Python3',
                'Python',
              ],
              false),
          card(
              'https://i.imgur.com/K0xKidW.jpg',
              'Android Flight Booking System',
              'Primary Developer',
              "Entry Project for the official programming and development club of International Institute of Information, Bangalore. It is an upgraded version of C project. This was a fully functional Flight Booking System. It is be used to book, cancel, edit or update imaginary flights booking. After booking or cancelling the tickets, we will recieve a email. This is a native java code.",
              "",
              [
                "https://github.com/architsangal/Android-App-Flight-Booking-System",
                "https://github.com/architsangal/Android-App-Flight-Booking-System/blob/master/Project%20Report.pdf",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              ['Android', 'Java', 'API', 'Firebase'],
              false),
          card(
              'https://i.imgur.com/lgecjGa.jpg',
              'Air Ticketing System',
              'Product Manager & Co Developer',
              "Project was a group project which needed to be implemented in C. It need to perform all the test of an Airline Ticketing System. For example- log-in, booking, searching, cancelling, printing the ticket. Also, from the airline's side, it should be able to add the ticket, etc.",
              "",
              [
                "https://github.com/architsangal/Air-Ticketing-System",
                "https://github.com/architsangal/Air-Ticketing-System/blob/master/README.pdf",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              ['C', 'makefile', 'Adobe Illustrator'],
              false),
          card(
              'https://i.imgur.com/O8DmreA.jpg',
              'Truck On Highway Finding Their Path',
              'Primary Developer',
              "There are a number of stations distributed all over the map. Packages can be shipped from any station to any other station. Stations are connected to Hubs, which are the nodes of a Highway network. Using graphs, shortest path is found.",
              "",
              [
                "https://github.com/architsangal/A-Game-Show------Simple-server-and-client-programs",
                "https://github.com/architsangal/A-Game-Show------Simple-server-and-client-programs/blob/main/Project%20Report.pdf",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              // 5 - YouTube
              ['Java', 'Server Client Interaction', "Applet Java"],
              false),
          card(
              'https://i.imgur.com/oTJQeAB.png',
              'COMMAND LINE PATTERN MATCHING PROGRAM',
              'Co Developer',
              'Project was a group project which needed to be implemented in Python. It is a Project which deals with making of a customised "UBUNTU TERMINAL COMMAND", changing the "PATH VARIABLE" by making changes to .bashrc, involves the use of ReGex (re module of Python) and os related modules of python',
              "",
              [
                "https://github.com/architsangal/COMMAND-LINE-PATTERN-MATCHING-PROGRAM#run-the-following-commands-and-you-are-ready-for-new-customized-command-on-ubuntu-",
                "https://github.com/architsangal/COMMAND-LINE-PATTERN-MATCHING-PROGRAM#run-the-following-commands-and-you-are-ready-for-new-customized-command-on-ubuntu-",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              ['Python', "ReGex"],
              false),
          card(
              'https://i.imgur.com/lOJjVka.png',
              'Carrom Cum Air Hockey',
              'Co Developer',
              "This was a project developed in a Hackathon, conducted by zense. It was built on Canvas Development. This Project deals with complex Physics Phenomenon of oblique collision. The code for Collision is a part of complex physics and a lot of projection calculation.",
              "https://architsangal.github.io/Canvas-Competition/",
              [
                "https://github.com/architsangal/Canvas-Competition#carrom-cum-air-hockey-new-version",
                "https://github.com/architsangal/Canvas-Competition#contributers",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              [
                'JavaScript',
                'HTML',
              ],
              false),
          card(
              'https://i.imgur.com/Jx3V96V.jpg',
              'Quiz Game Show',
              'Primary Developer',
              "This is a simple server and client program. There is a host who conducts the show and participants/players who provide answers.",
              "",
              [
                "https://github.com/architsangal/A-Game-Show------Simple-server-and-client-programs",
                "https://github.com/architsangal/A-Game-Show------Simple-server-and-client-programs/blob/main/Project%20Report.pdf",
                "https://youtu.be/pFS9HEVbAIU",
              ],
              ["Source Code", "README", "Youtube Video Explaination"],
              [
                1,
                3,
                6,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              // 5 - YouTube
              [
                'Java',
                'Server Client Interaction',
              ],
              false),
          card(
              'https://i.imgur.com/XpDeQpA.jpg',
              'Modifying PLY Files',
              'Primary Developer',
              "Used to edit ply files. It used meshlab to check it everything is working or not",
              "",
              [
                "https://github.com/architsangal/Modifying-.ply-files",
                "https://github.com/architsangal/Modifying-.ply-files/blob/main/README.md",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              // 5 - YouTube
              [
                'cpp',
                'c++',
                'ply files',
                'meshlab',
              ],
              false),
          card(
              'https://i.imgur.com/mV9lGKL.jpg',
              'Fun Portfolio',
              'Primary Developer',
              "It was a fun project. I start it to get an idea of how HTML,CSS and JAvaScript work. It was one of my initial projects so please don't jugde.",
              "https://architsangal.github.io/My-Portfolio/",
              [
                "https://github.com/architsangal/My-Portfolio#my-portfolio",
                "https://architsangal.github.io/My-Portfolio/",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              [
                'JavaScript',
                'HTML',
                'CSS',
              ],
              false),
          card(
              'https://i.imgur.com/Jo5UbOK.jpg',
              'Car Racing 90s',
              'Primary Developer',
              "Created this car racing game using Pygame. I enjoyed this game a lot so I recreated this game. This project was one of my early projects. It has one level. Though it can be extended to multi-levels quite easily using python.",
              "",
              [
                "https://github.com/architsangal/Flutter-Web-Code",
                "https://github.com/architsangal/CAR_RACE-Pygame#car_race-pygame",
              ],
              ["Source Code", "README"],
              [
                1,
                3,
              ],
              // 1 - github,
              // 2 - Rive Animation
              // 3 - README
              // 4 - Certification
              [
                'python',
                'python3',
                'pygame',
              ],
              false),
        ],
      ),
    );
  }

  ClipRRect card(
      String image,
      String projectName,
      String role,
      String text,
      String projectLink,
      List<String> link,
      List<String> message,
      List<int> type,
      List<String> skills,
      bool onGoing) {
    final height = MediaQuery.of(context).size.height > 980
        ? MediaQuery.of(context).size.height
        : 960;
    final width = MediaQuery.of(context).size.width > 1900
        ? MediaQuery.of(context).size.width
        : 1271;

    List<Widget> linksList = [];
    for (int i = 0; i < link.length; i++) {
      if (type[i] == 1) {
        linksList.add(Tooltip(
            message: message[i],
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.black,
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.blue)),
              child: Icon(
                AppIcons.github,
              ),
              onPressed: () {
                _launchURL(link[i]);
              },
            )));
      } else if (type[i] == 2) {
        linksList.add(Tooltip(
            message: message[i],
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.black,
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.blue)),
              child: Icon(
                Icons.animation,
              ),
              onPressed: () {
                _launchURL(link[i]);
              },
            )));
      } else if (type[i] == 3) {
        linksList.add(Tooltip(
            message: message[i],
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.black,
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.blue)),
              child: Icon(
                Icons.read_more_rounded,
              ),
              onPressed: () {
                _launchURL(link[i]);
              },
            )));
      } else if (type[i] == 4) {
        linksList.add(Tooltip(
            message: message[i],
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.black,
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.blue)),
              child: Icon(
                Icons.article_rounded,
              ),
              onPressed: () {
                _launchURL(link[i]);
              },
            )));
      } else if (type[i] == 5) {
        linksList.add(Tooltip(
            message: message[i],
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.black,
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.blue)),
              child: Icon(
                Icons.link_rounded,
              ),
              onPressed: () {
                _launchURL(link[i]);
              },
            )));
      } else if (type[i] == 6) {
        linksList.add(Tooltip(
            message: message[i],
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.black,
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.blue)),
              child: Icon(
                Icons.play_arrow_rounded,
              ),
              onPressed: () {
                _launchURL(link[i]);
              },
            )));
      }
    }
    List<Padding> skillslist = [];
    for (String skill_i in skills) {
      skillslist.add(skillused(skill_i));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height / 3 * 2),
        child: Container(
          height: height / 4 * 3,
          width: width / 4,
          margin: const EdgeInsets.all(60.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(
              color: Color.fromARGB(255, 1 * 16 + 6, 8 * 16 + 7, 10 * 16 + 7),
              width: width / 350,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 1 * 16 + 6, 8 * 16 + 7, 10 * 16 + 7),
                offset: Offset(1.0, 1.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FadeInImage(
                      height: 5 / 18 * height,
                      width: width / 3,
                      fit: BoxFit.cover,
                      placeholder: MemoryImage(kTransparentImage),
                      image: new NetworkImage(image),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 1 / 18 * height),
                    child: Center(
                      child: AutoSizeText(
                        projectName + ' | ' + role,
                        textAlign: TextAlign.center,
                        maxFontSize: 25,
                        style: GoogleFonts.getFont(
                          'Nanum Gothic',
                          textStyle: TextStyle(
                            fontSize: width / 80,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(
                                255, 2 * 16 + 7, 6 * 16 + 6, 7 * 16 + 8),
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 2 / 18 * height),
                    child: Center(
                      child: AutoSizeText(
                        text,
                        maxFontSize: 20,
                        style: GoogleFonts.getFont(
                          'Nanum Gothic',
                          textStyle: TextStyle(
                            fontSize: width / 80,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(
                                255, 1 * 16 + 6, 8 * 16 + 7, 10 * 16 + 7),
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 1 / 18 * height),
                      child: Wrap(
                        children: [
                          Center(
                              child: Wrap(
                            children: linksList,
                          )),
                        ],
                      )),
                  projectLink.isNotEmpty
                      ? ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: 1 / 18 * height),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              TextButton(
                                child: Text("View Project",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 2 * 16 + 7,
                                          6 * 16 + 6, 7 * 16 + 8),
                                    )),
                                onPressed: () {
                                  _launchURL(projectLink);
                                },
                              )
                            ],
                          ))
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: 1 / 18 * height, maxWidth: 0)),
                  ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 1 / 18 * height),
                      child: Wrap(
                        children: skillslist,
                      )),

                  // isssue https://github.com/flutter/flutter/issues/76093
                  // issue https://github.com/flutter/flutter/issues/79172
                  // Error Could not find a set of Noto fonts to display all missing characters. Please add a font asset for the missing characters. See: https://flutter.dev/docs/cookbook/design/fonts
                  // This is due to \u25ce
                  if (onGoing)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 0.5 / 18 * height),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: AutoSizeText(
                            "\u25ce In progress",
                            maxFontSize: 20,
                            style: GoogleFonts.getFont(
                              'Nanum Gothic',
                              textStyle: TextStyle(
                                fontSize: width / 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding skillused(String text) {
    // final height = MediaQuery.of(context).size.height > 939 &&
    //         MediaQuery.of(context).size.width > 1689
    //     ? MediaQuery.of(context).size.height
    //     : 939;
    final width = MediaQuery.of(context).size.height > 939 &&
            MediaQuery.of(context).size.width > 1689
        ? MediaQuery.of(context).size.width
        : 1639;

    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 60),
          border: Border.all(
            color: Colors.black,
            width: width / 700,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SelectableText(
            text,
            style: GoogleFonts.getFont(
              'Nanum Gothic',
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String link) async =>
      await canLaunch(link) ? await launch(link) : throw 'Could not launch ';
}
