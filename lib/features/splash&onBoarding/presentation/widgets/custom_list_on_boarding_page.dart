import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/features/splash&onBoarding/data/model/on_boarding_model.dart';

final List<OnBoardingDataModel> onBoardingPages = [
  OnBoardingDataModel(
    image: AppImages.onBoardingImage1,
    title: 'كل اللي يخص موبايلك في مكان واحد',
    description:
        'من الموبايلات للإكسسوارات، كل المنتجات اللي محتاجاها متوفرة بسهولة وبأفضل جودة.',
  ),
  OnBoardingDataModel(
    image: AppImages.onBoardingImage2,
    title: 'اختيارات كتير من كل الماركات المفضّلة ليك',
    description:
        'اكتشف أحدث الموديلات والعروض من أشهر الماركات العالمية والمحلية',
  ),
];
