import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_crew/view_models/auth_view_model.dart';
import 'package:rare_crew/view_models/dashboard_view_model.dart';
import 'package:rare_crew/views/add_update_view.dart';
import 'package:rare_crew/views/widgets/item_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<DashBoardViewModel>().getItems();
    context.read<AuthViewModel>().getEmailFromCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUpdateView(),
              )),
          child: const Icon(Icons.add_task_rounded)),
      body: Consumer<DashBoardViewModel>(builder: (context, viewModel, _) {
        return SafeArea(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = context.read<DashBoardViewModel>().items[index];
                  return ItemCard(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddUpdateView(item: item),
                            ));
                      },
                      trailing: IconButton(
                          onPressed: () {
                            viewModel.deleteItem(item.id!);
                          },
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Colors.red,
                          )),
                      title: item.title!,
                      subTitle: item.body!,
                      icon: Icons.task_alt_rounded);
                },
                itemCount: viewModel.items.length));
      }),
    );
  }
}
