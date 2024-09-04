import '../../const/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateScreen();
  }

  _navigateScreen() async {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.offAll(() => const GridScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: Get.width * 0.8,
            ),
            15.heightBox,
            const Text("Mobigic Technologies",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
