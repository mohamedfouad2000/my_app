// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdsScreen extends StatefulWidget {
//   const AdsScreen({super.key});

//   @override
//   State<AdsScreen> createState() => _AdsScreenState();
// }

// class _AdsScreenState extends State<AdsScreen> {
//   BannerAd? bannerAd;
//   InterstitialAd? interstitialAd;
//   RewardedAd? rewardedAd;

//   @override
//   void initState() {
//     super.initState();
//     loadBanner();
//     loadInterstitial();
//     loadRewarded();
//   }

//   // -------------------------
//   // Banner
//   // -------------------------
//   void loadBanner() {
//     bannerAd = BannerAd(
//       adUnitId: "ca-app-pub-3940256099942544/6300978111", // Test ID
//       size: AdSize.banner,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (_) {
//           setState(() {});
//         },
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }

//   // -------------------------
//   // Interstitial
//   // -------------------------
//   void loadInterstitial() {
//     InterstitialAd.load(
//       adUnitId: "ca-app-pub-3940256099942544/1033173712",
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) => interstitialAd = ad,
//         onAdFailedToLoad: (_) => interstitialAd = null,
//       ),
//     );
//   }

//   void showInterstitial() {
//     if (interstitialAd != null) {
//       interstitialAd!.show();
//       loadInterstitial(); // إعادة تحميل إعلان جديد
//     }
//   }

//   // -------------------------
//   // Rewarded
//   // -------------------------
//   void loadRewarded() {
//     RewardedAd.load(
//       adUnitId: "ca-app-pub-3940256099942544/5224354917",
//       request: const AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (ad) => rewardedAd = ad,
//         onAdFailedToLoad: (_) => rewardedAd = null,
//       ),
//     );
//   }

//   void showRewarded() {
//     if (rewardedAd != null) {
//       rewardedAd!.show(
//         onUserEarnedReward: (ad, reward) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("كسبت ${reward.amount} نقطة!")),
//           );
//         },
//       );
//       loadRewarded(); // إعادة التحميل
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Ads Example")),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: showInterstitial,
//               child: const Text("عرض إعلان interstitial"),
//             ),
//             ElevatedButton(
//               onPressed: showRewarded,
//               child: const Text("عرض إعلان rewarded"),
//             ),
//           ],
//         ),
//       ),

//       // Banner Ad في أسفل الشاشة
//       bottomNavigationBar: bannerAd == null
//           ? const SizedBox()
//           : SizedBox(
//               height: bannerAd!.size.height.toDouble(),
//               child: AdWidget(ad: bannerAd!),
//             ),
//     );
//   }
// // }
