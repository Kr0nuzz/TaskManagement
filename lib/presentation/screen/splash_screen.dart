import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _loadBanner();
    Future.delayed(const Duration(seconds: 2), () {
      if (_interstitialAd != null) {
        _interstitialAd!.show();
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  void _loadBanner() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-9906776231425552/5691139599', // Ganti dengan ID iklan interstitial yang valid
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
        },
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffBCDBDF),
      child: Stack(
        children: [
          SizedBox(
            // fungsi untuk menyesuaikan tampilang sesuai lebar layar hp
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset("assets/planner.png",scale: 2,
                      fit: BoxFit.fill, color: const Color(0xff235784),alignment: Alignment.center,),
                   Text(
                    "Task Management",style: GoogleFonts.alatsi(fontSize: 20),
                  )
                ]),
                const Align(alignment: Alignment.bottomCenter),
                const Spacer(
                  flex: 1,
                ),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
