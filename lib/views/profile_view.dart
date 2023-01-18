import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_crew/core/cache_helper.dart';
import 'package:rare_crew/core/helper_functions.dart';
import 'package:rare_crew/view_models/auth_view_model.dart';
import 'package:rare_crew/view_models/dashboard_view_model.dart';
import 'package:rare_crew/views/auth_view.dart';
import 'package:rare_crew/views/dashboard_view.dart';
import 'package:rare_crew/views/widgets/item_card.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<AuthViewModel>(builder: (context, viewModel, _) {
            return ItemCard(
              title: 'Email',
              subTitle: viewModel.email ?? 'loading',
              icon: Icons.email,
            );
          }),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    HelperFuctions.showLoadingIndicator(context);
                    context.read<AuthViewModel>().logout(() {
                      CacheHelper.clearAll();
                      context.read<DashBoardViewModel>().changeCurrentIndex(0);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthScreen(),
                          ),
                          (route) => false);
                    }, () {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 60)),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
