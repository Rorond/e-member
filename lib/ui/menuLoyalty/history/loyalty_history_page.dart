import 'package:emembers/core.dart';
import 'package:emembers/ui/menuLoyalty/history/history_controller.dart';

class LoyaltyHistoryPage extends StatefulWidget {
  final User? user;
  final ProjectList? project;

  const LoyaltyHistoryPage({
    Key? key,
    this.user,
    this.project,
  }) : super(key: key);

  @override
  State<LoyaltyHistoryPage> createState() => HistoryController();

  Widget build(context, HistoryController controller) {
    controller.view = this;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie_animations/animation.json',
                width: 300, height: 300, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
