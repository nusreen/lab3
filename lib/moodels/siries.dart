class Siries {
  String? name;
  String? band;
  bool? checked;

  Siries(this.name, this.band, this.checked);

  static List<Siries> getSiries() {
    return [
      Siries('ปรมาจารย์ลัทธิมาร', 'นักแสดง: หวังอี้ป๋อ,เซียวจ้าน', false),
      Siries('แค่เพื่อนครับเพื่อน', 'นักแสดง: โอม ภวัต,นนน กรภัทร์', false),
      Siries('F4 Thailand:หัวใจรักสี่ดวง ', 'นักแสดง: ไบร์ท วชิรวิชญ์,ตู ต้นตะวัน', false),
      Siries('คุณคือคำปฏิญาณแห่งรัก ', 'นักแสดง: เซียวจ้าน,หยางจื่อ', false),
    ];
  }
}