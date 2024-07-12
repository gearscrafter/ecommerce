import 'package:flutter/material.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return const SupportTemplate();
  }
}
