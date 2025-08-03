import 'dart:math';

String getRandomAvatar(String gender) {
  final random = Random();
  if (gender.toLowerCase() == 'male') {
    final maleImages = ['assets/male/m1.png', 'assets/male/m2.png', 'assets/male/m3.png'];
    return maleImages[random.nextInt(maleImages.length)];
  } else {
    final femaleImages = ['assets/female/f1.png', 'assets/female/f2.png', 'assets/female/f3.png'];
    return femaleImages[random.nextInt(femaleImages.length)];
  }
}