import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_crew/core/constants.dart';
import 'package:rare_crew/core/helper_functions.dart';
import 'package:rare_crew/models/item_model.dart';
import 'package:rare_crew/view_models/dashboard_view_model.dart';

class AddUpdateView extends StatefulWidget {
  final Item? item;
  const AddUpdateView({super.key, this.item});

  @override
  State<AddUpdateView> createState() => _AddUpdateViewState();
}

class _AddUpdateViewState extends State<AddUpdateView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.item != null) {
      _titleController.text = widget.item!.title!;
      _bodyController.text = widget.item!.body!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.item != null ? 'Update Item' : 'Add Item',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.lightGreen),
                ),
                const SizedBox(height: 100.0),
                TextFormField(
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return Constants.kTitleRequired;
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: _bodyController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return Constants.kBodyRequired;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Body',
                    hintText: 'Body',
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      fixedSize: const Size(double.maxFinite, 60)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.item == null) {
                        HelperFuctions.showLoadingIndicator(context);
                        context.read<DashBoardViewModel>().addItem(
                            Item(
                                title: _titleController.text.trim(),
                                body: _bodyController.text.trim()), () {
                          showCentralToast(
                              text: 'Item Added Successfully',
                              state: ToastStates.success);

                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, () {
                          Navigator.pop(context);
                        });
                      } else {
                        HelperFuctions.showLoadingIndicator(context);
                        context.read<DashBoardViewModel>().updateItem(
                            Item(
                                id: widget.item!.id,
                                title: _titleController.text.trim(),
                                body: _bodyController.text.trim()), () {
                          showCentralToast(
                              text: 'Item Updated Successfully',
                              state: ToastStates.success);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, () {
                          Navigator.pop(context);
                        });
                      }
                    }
                  },
                  child: Text(
                    widget.item == null ? 'Add' : 'Update',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
