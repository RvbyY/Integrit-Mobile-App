import 'package:auth_demo/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:auth_demo/web_helper_stub.dart'
    if (dart.library.html) 'web_helper_web.dart' as web_helper;

class Paths {
  static const String entreePath = 'https://forms.office.com/Pages/ResponsePage.aspx?id=RBmyLoXbRECIcbwHK8oD_wuwxaPYwv1MgdGsdsAr3W1UNURSOVRXQ1FXVzBWVDBZWFdRQzE2R1pYMS4u';
  static const String sortiePath = 'https://forms.office.com/Pages/ResponsePage.aspx?id=RBmyLoXbRECIcbwHK8oD_wuwxaPYwv1MgdGsdsAr3W1UMklFTUNIOFYzNEVLRzdDWFQ2SkhYMjVMSi4u';
  static const String interventionPath = 'https://forms.office.com/Pages/ResponsePage.aspx?id=RBmyLoXbRECIcbwHK8oD_wuwxaPYwv1MgdGsdsAr3W1URFRCQjJFN1pYQVJBQ0JKOU9TVEM2SEtGQi4u';
}

class IntegritApp extends StatelessWidget {
  const IntegritApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: const HeaderTitle(),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(color: Colors.blue.shade900),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: title),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withValues(alpha: .1)),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
                },
              icon:const Icon(
                Icons.brightness_5_outlined,
                size: 24,
                color: Colors.white,
              )
            ),
          ),
          const SizedBox(
              width: 4,
          ),
        ],
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyAppBar(
            title: Text(
              'Groupe Integr\'IT',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            )
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(25),
              children: const [
                Text(
                  "Formulaires Forms",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )
          ),
         ButtonForms(),
        ],
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  NavDrawer({super.key});

   @override
   Widget build(BuildContext context) {
     return Drawer(
       child: ListView(
         padding: EdgeInsets.zero,
         children: <Widget>[
           DrawerHeader(
             decoration: BoxDecoration(
                 color: Colors.white
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: Colors.white
                   ),
                   height: 60,
                   width: 60,
                   child: Image.asset('assets/images/ic_launcher-playstore.png'),
                 ),
                 Text(
                  '${auth.currentUser?.email}',
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 10,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 SizedBox(height: 8),
                 Text(
                   'Paramètres',
                   style: TextStyle(
                       color: Colors.blue.shade900,
                       fontSize: 35,
                       fontWeight: FontWeight.bold
                   ),
                 ),
               ],
             ),
           ),
           ListTile(
             tileColor: Colors.blue.shade900,
             leading: Icon(
                 Icons.exit_to_app,
                 color: Colors.white
             ),
             title: Text(
               'Log out',
               style: TextStyle(
                 color: Colors.white,
               ),
             ),
             onTap: () => {
               Navigator.of(context)
                   .pushAndRemoveUntil(
                 CupertinoPageRoute(
                     builder: (context) => LoginScreen()
                 ),
                     (_) => false,
               )
             },
           ),
           Container(
             height: 395,
             padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
             alignment: Alignment.bottomCenter,
             decoration: BoxDecoration(color: Colors.blue.shade900),
           ),
         ],
       ),
     );
   }
}

class ButtonForms extends StatelessWidget {
  const ButtonForms({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ButtonGroups(),
        ],
      ),
    );
  }
}

class ButtonGroups extends StatelessWidget {
  const ButtonGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildFileColumn('packages', 'Entrée Stock', '.forms', Paths.entreePath, context),
          const SizedBox(height: 20),
          buildFileColumn('inventory', 'Sortie Stock', '.forms', Paths.sortiePath, context),
          const SizedBox(height: 20),
          buildFileColumn('complaint', 'Fiche d\'intervention', '.forms', Paths.interventionPath, context),
        ],
      ),
    );
  }

  GestureDetector buildFileColumn(String image, String filename,
      String extension, String urlPaths, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kIsWeb) {
          web_helper.openUrl(urlPaths);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewApp(url: urlPaths, title: filename),
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(38),
            height: 110,
            child: Image.asset('assets/images/$image.png'),
          ),
          RichText(
            text: TextSpan(
              text: filename,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: extension,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(0, 100, 204, 59))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => debugPrint('Loading $url'),
          onPageFinished: (url) => debugPrint('Finished loading $url'),
          onWebResourceError: (error) => debugPrint('Error: $error'),
        ),
      )
      ..loadRequest(
        Uri.parse(
          widget.url,
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        controller: controller,
        ),
    );
  }
}