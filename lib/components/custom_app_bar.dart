import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final double? height;
  final Function()? save;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.height,
    this.save,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height ?? 75);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 70,
      title: Text(widget.title),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.indigo],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
      ),
      actions: [
        widget.save != null
            ? IconButton(onPressed: widget.save, icon: const Icon(Icons.save))
            : Container()
      ],
    );
  }
}
