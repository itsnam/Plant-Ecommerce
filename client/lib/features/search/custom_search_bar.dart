import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/styles/styles.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onInput;

  const CustomSearchBar({
    Key? key,
    required this.onInput,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final myController = TextEditingController();
  Timer? _debounce;
  bool _visibility = false;

  @override
  void initState() {
    super.initState();
    myController.addListener(() {
      if (myController.text.isEmpty) {
        setState(() {
          _visibility = false;
        });
      } else {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          widget.onInput(myController.text);
        });
        setState(() {
          _visibility = true;
        });
      }
    });
  }

  @override
  void dispose() {
    myController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: TextField(
          controller: myController,
          cursorColor: Colors.black,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              isDense: true,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: _visibility,
                    child: IconButton(
                        onPressed: () {
                          myController.clear();
                        },
                        icon: const Icon(
                          Iconsax.close_circle5,
                          color: unselectedMenuItem,
                          size: 20,
                        )),
                  ),
                ],
              ),
              hintText: "Lan hồ điệp...",
              hintStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
