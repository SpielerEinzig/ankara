import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

void adReward() {
  print('Reward');
}

class AdmobService {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  static String get interstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/1033173712';

  static String get secondBannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  static String get thirdBannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  static String get rewardedAdId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/5224354917';

  static InterstitialAd? _interstitialAd;
  static RewardedAd? _rewardedAd;

  static initialize() {
    MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
      size: AdSize.largeBanner,
      adUnitId: bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened'),
        onAdClosed: (Ad ad) => print('On Ad Closed'),
      ),
    );
    return ad;
  }

  static BannerAd createSecondBannerAd() {
    BannerAd ad = new BannerAd(
      size: AdSize.largeBanner,
      adUnitId: secondBannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened'),
        onAdClosed: (Ad ad) => print('On Ad Closed'),
      ),
    );
    return ad;
  }

  static BannerAd createThirdBannerAd() {
    BannerAd ad = new BannerAd(
      size: AdSize.largeBanner,
      adUnitId: thirdBannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened'),
        onAdClosed: (Ad ad) => print('On Ad Closed'),
      ),
    );
    return ad;
  }

  static _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdFailedToLoad: (LoadAdError error) =>
                print('Interstitial Ad failed to load: $error'),
            onAdLoaded: (InterstitialAd ad) {
              _interstitialAd = ad;
              _interstitialAd!.show();
              print('Interstitial Ad loaded');
            }));
  }

  static void showInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;

    if (_interstitialAd == null) _interstitialAd = _createInterstitialAd();
  }

  static _createRewardedAd() {
    RewardedAd.load(
        adUnitId: rewardedAdId,
        request: AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          print('Rewarded ad loaded');
          _rewardedAd = ad;
          _rewardedAd!.show(
              onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
            print(
                '$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
          });
        }, onAdFailedToLoad: (LoadAdError error) {
          print('RewardAd failed to load: $error');
        }));
  }

  static void showRewardedAd() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    if (_rewardedAd == null) _rewardedAd = _createRewardedAd();
  }
}
