class ClinicCardInfo{
  String name;
  String services;
  String alamat;
  double distance;
  double rating;

  ClinicCardInfo({
    required this.name,
    required this.services,
    required this.alamat,
    required this.distance,
    required this.rating
  });

  static List<ClinicCardInfo> getClinic(){
    List<ClinicCardInfo> clinic = [];

    clinic.add(
      ClinicCardInfo(
        name: "Klinik Hewan Awal Care (Rawamangun, Jakarta)",
        services: "Dokter Hewan, Petshop, Grooming",
        alamat: "Jl. Waru No.20 AB, RT.6/RW.7, Rawamangun, Kec. Pulo Gadung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13220",
        distance: 0.5,
        rating: 2.8
      )
    );

    clinic.add(
      ClinicCardInfo(
        name: "Drh. Bambang Ariadji, Drh. Endang Setyowati",
        services: "Dokter Hewan",
        alamat: "Jl. Kayu Jati I Gg. 1 No.14, RT.7/RW.4, Rawamangun, Kec. Pulo Gadung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13220",
        distance: 0.5,
        rating: 3.1
      )
    );

    clinic.add(
      ClinicCardInfo(
        name: "Drh. Irene Damar W",
        services: "Dokter Hewan",
        alamat: "Jl. Pondasi No. 73 Kampung Ambon Kayu Putih Pulo Gadung Jakarta Timur DKI Jakarta, RT.1/RW.2, Kayu Putih, Kec. Pulo Gadung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13210",
        distance: 3.4,
        rating: 4.6
      )
    );


    clinic.add(
      ClinicCardInfo(
        name: "PRAKTEK DOKTER HEWAN PIARA PULOMAS",
        services: "Dokter Hewan",
        alamat: "Jl. Pulomas I No.46, RT.8/RW.12, Kayu Putih, Kec. Pulo Gadung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13210",
        distance: 4.3,
        rating: 4.5
      )
    );

    clinic.add(
      ClinicCardInfo(
        name: "Dokter Hewan Praktek Drh. Elpita",
        services: "Dokter Hewan, Grooming",
        alamat: "Jl. Balai Pustaka Baru No.4, RT.4/RW.15, Rawamangun, Kec. Pulo Gadung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13220",
        distance: 2.9,
        rating: 3.7
      )
    );

    return clinic;
  }

}
