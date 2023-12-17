//import 'package:flutter/material.dart';
class DiscussionForum {
  String pic;
  String name;
  String title;
  String content;
  String time;
  List tags;
  int likes;

  DiscussionForum({
    required this.pic,
    required this.name,
    required this.title,
    required this.content,
    required this.time,
    required this.tags,
    required this.likes,
  });

  static List<DiscussionForum> getcontent() {
    List<DiscussionForum> content = [];

    content.add(
      DiscussionForum(
      pic: "assets/female.svg",
      name: "Shannaz",
      title: "Nggak sengaja makan makanan kucing!",
      content: "Aduh... gimana ya tadi tuh aku lagi makan chitato, tapi majikan minta dikasih makan, alhasil ketuker deh. bahaya nggak sih?",
      time: "20-02-12",
      tags: ["kucing", "makanan"],
      likes: 127
      )
    );

    content.add(
      DiscussionForum(
        pic: "assets/male.svg",
        name: "Budi",
        title: "Perawatan Anjing yang Sedang Sakit: Apa yang Perlu Dilakukan?",
        content: "Anjingku menunjukkan tanda-tanda sakit belakangan ini. Bagaimana cara memberikan perawatan pertama untuk anjing yang sedang sakit? Mohon saran dari pengalaman kalian.",
        time: "20-03-20",
        tags: ["kesehatan anjing", "sakit anjing"],
        likes: 55,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/female.svg",
        name: "Lily",
        title: "Memahami Bahasa Tubuh Burung Peliharaan: Tips Komunikasi",
        content: "Saya baru saja memelihara burung, dan saya ingin memahami apa yang dia coba sampaikan melalui bahasa tubuhnya. Ada tips atau referensi yang bisa membantu?",
        time: "20-03-18",
        tags: ["komunikasi burung", "perilaku burung"],
        likes: 70,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/male.svg",
        name: "Agus",
        title: "Mengatasi Penyakit Umum pada Ikan Hias",
        content: "Ikan hias aku kelihatan tidak sehat belakangan ini. Apa yang bisa dilakukan untuk mengatasi penyakit umum pada ikan hias? Mohon sharing informasinya.",
        time: "20-03-16",
        tags: ["penyakit ikan", "perawatan ikan"],
        likes: 65,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/female.svg",
        name: "Ratna",
        title: "Pentingnya Pemberian Makan yang Sehat untuk Kura-kura",
        content: "Saya baru memelihara kura-kura, dan saya ingin tahu bagaimana memberikan makanan yang sehat untuknya. Ada saran atau rekomendasi merek pakan yang bagus?",
        time: "20-03-14",
        tags: ["perawatan kura-kura", "makanan kura-kura"],
        likes: 80,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/male.svg",
        name: "Eko",
        title: "Apa yang Harus Dilakukan Ketika Anjing Tidak Mau Makan?",
        content: "Anjingku tiba-tiba enggak mau makan. Ada yang punya tips atau trik untuk mengatasi anjing yang enggak mau makan? Mohon bantuannya.",
        time: "20-03-12",
        tags: ["makanan anjing", "gangguan makanan"],
        likes: 75,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/female.svg",
        name: "Susi",
        title: "Tips Merawat Bulu dan Kuku Burung Lovebird",
        content: "Saya ingin memberikan perawatan terbaik untuk burung lovebird, terutama bulunya. Ada tips merawat bulu dan kuku burung lovebird yang bisa dibagikan?",
        time: "20-03-10",
        tags: ["perawatan burung lovebird", "kecantikan bulu"],
        likes: 60,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/male.svg",
        name: "Hendra",
        title: "Mengatasi Parasit pada Ikan Koi",
        content: "Ikan koi saya terkena parasit, dan saya ingin tahu cara mengatasi masalah ini. Ada obat atau metode alami yang efektif untuk membersihkan parasit pada ikan koi?",
        time: "20-03-08",
        tags: ["parasit ikan koi", "perawatan ikan koi"],
        likes: 90,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/female.svg",
        name: "Ratih",
        title: "Cara Mengetahui Kucing Sedang Bahagia atau Stres",
        content: "Saya ingin tahu cara mengetahui apakah kucing saya sedang bahagia atau stres. Apa tanda-tanda yang perlu diperhatikan? Mohon sharing pengalaman kalian.",
        time: "20-03-06",
        tags: ["kucing"],
        likes: 85,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/male.svg",
        name: "Dedi",
        title: "Merawat Kura-kura Agar Tidak Cepat Tertular Penyakit",
        content: "Kura-kura saya baru sembuh dari penyakit, dan saya ingin tahu cara merawatnya agar tidak cepat tertular penyakit lagi. Ada tips atau tindakan pencegahan yang bisa diambil?",
        time: "20-03-04",
        tags: ["perawatan kura-kura", "pencegahan penyakit","hahahahahahahhahahahahaahhaahahahah"],
        likes: 96,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/female.svg",
        name: "Eva",
        title: "Menyikapi Anjing yang Suka Menggonggong Terus-Menerus",
        content: "Anjingku suka menggonggong terus-menerus, terutama saat malam. Bagaimana cara menyikapi dan mengatasi kebiasaan menggonggong berlebihan pada anjing?",
        time: "20-03-02",
        tags: ["anjing", "latihan anjing"],
        likes: 100,
      ),
    );

    content.add(
      DiscussionForum(
        pic: "assets/male.svg",
        name: "Abi",
        title: "Armadillo saya tersedak, harus apa?",
        content: "Awalnya saya cuma coba-coba kasih makan ikan bakar ke armadillo saya yang namanya Handi. 30 menit kemudian, saya baru sadar bahwa armadillo saya masih kecil.",
        time: "20-03-20",
        tags: ["armadillo", "sakit armadillo", "tersedak"],
        likes: 65,
      ),
    );


    return content;
  }
}
