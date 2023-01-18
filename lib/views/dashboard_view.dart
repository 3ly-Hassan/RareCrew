import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_crew/view_models/dashboard_view_model.dart';
import 'package:rare_crew/views/profile_view.dart';

import 'home_view.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [
          Home(),
          Profile(),
        ],
      ),
      bottomNavigationBar:
          Consumer<DashBoardViewModel>(builder: (context, viewModel, _) {
        return BottomNavigationBar(
            onTap: (index) {
              viewModel.changeCurrentIndex(index);
              _controller.animateToPage(index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInCubic);
            },
            currentIndex: viewModel.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Profile'),
            ]);
      }),
    );
  }
}
