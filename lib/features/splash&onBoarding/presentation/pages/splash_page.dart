import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/core.dart';
import 'package:Bynona/core/router/routes_name.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPages();
  }

  void _navigateToNextPages() {
    Future.delayed(const Duration(seconds: 1), () {
      AppRouter.replace(context, RoutesName.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAssetsImage(
        assetPath: AppImages.splashImage,
        width: double.infinity,
        height: double.infinity,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      ),
    );
  }
}
