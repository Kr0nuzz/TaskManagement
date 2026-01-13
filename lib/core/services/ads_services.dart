
import 'package:google_mobile_ads/google_mobile_ads.dart';

void loadBanner(InterstitialAd? interstitialAd) {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-9906776231425552/1522526383', // Ganti dengan ID iklan interstitial yang valid
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
        },
      ),
    );
  }