import 'package:flutter/material.dart';

class SongNguSrceen extends StatefulWidget {
  const SongNguSrceen({super.key});

  @override
  State<SongNguSrceen> createState() => _SongNguSrceenState();
}

class _SongNguSrceenState extends State<SongNguSrceen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}