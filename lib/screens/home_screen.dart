import 'package:auth_demo/screens/delete_screen.dart';
import 'package:auth_demo/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
           ListTile(
            tileColor: Colors.blue.shade900,
            leading: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            title: Text(
              'Supprimer le compte',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => {
              Navigator.of(context)
                .push(
                  CupertinoPageRoute(
                    builder: (context) => DeleteScreen()
                  ),
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _initializeWebView();
  }

  Future<void> _requestPermissions() async {
    if (!kIsWeb) {
      await Permission.camera.request();
      await Permission.photos.request();
      if (Platform.isAndroid) {
        await Permission.storage.request();
      }
    }
  }

  void _initializeWebView() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    controller = WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(0, 100, 204, 59))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
            debugPrint('Loading $url');
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
            debugPrint('Finished loading $url');
          },
          onWebResourceError: (error) {
            debugPrint('Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
      (controller.platform as AndroidWebViewController)
          .setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    final ImagePicker picker = ImagePicker();

    try {
      final bool allowMultiple = params.mode == FileSelectorMode.openMultiple;
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sélectionner la source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Prendre une photo'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Choisir depuis la galerie'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
          ],
        ),
      );
      if (source == null) return [];

      if (allowMultiple && source == ImageSource.gallery) {
        final List<XFile> photos = await picker.pickMultiImage(
          imageQuality: 85,
        );
        return photos.map((photo) => photo.path).toList();
      } else {
        final XFile? photo = await picker.pickImage(
          source: source,
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
        if (photo == null) return [];
        return [photo.path];
      }
    } catch (e) {
      debugPrint('Erreur lors de la sélection d\'image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la sélection: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.reload(),
            tooltip: 'Actualiser',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.blue.shade900,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Chargement du formulaire...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
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
