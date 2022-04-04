import 'package:flutter/material.dart';
import 'package:lab3/moodels/grade.dart';
import 'package:lab3/moodels/major.dart';
import 'package:lab3/moodels/siries.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _studentidcontroller = TextEditingController();

  String? gradeValue;
  String? majorValue;

  late List<Grade> grades;
  late List<Major> majors;
  late List<Faculty> dropdownItems = Faculty.getfaculty();
  late List<DropdownMenuItem<Faculty>> dropdownMenuItems;
  late Faculty _selectedFaculty;
  late List<Siries> siriess;
  List selectSong = [];

  get selectSiries => null;

  @override
  void initState() {
    grades = Grade.getgrade();
    majors = Major.getmajor();
    dropdownMenuItems = createDropdownMenu(dropdownItems);
    _selectedFaculty = dropdownMenuItems[0].value!;
    siriess = Siries.getSiries();
  }

  List<DropdownMenuItem<Faculty>> createDropdownMenu(
      List<Faculty> dropdownItems) {
    List<DropdownMenuItem<Faculty>> facultys = [];

    for (var faculty in dropdownItems) {
      facultys.add(
        DropdownMenuItem(
          child: Text(faculty.name!),
          value: faculty,
        ),
      );
    }
    return facultys;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  info(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  name(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  studentid(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  grade(),
                  radio(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  major1(),
                  major(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  faculty(),
                  dropdown(),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25)),
                  like(),
                  siries(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  submit(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget submit() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('ยืนยันการบันทึกข้อมูล'),
              content: const Text('ตรวจสอบข้อมูลให้ถูกต้องก่อนกดยืนยัน'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('ยกเลิก'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('ตกลง'),
                ),
              ],
            ),
          );
          if (_formKey.currentState!.validate()) {
            print(_namecontroller.text);
            print(_studentidcontroller.text);
          }
          return;
        },
        child: const Text(
          'บันทึก',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Column siries() {
    return Column(children: createSiriesCheckbox());
  }

  DropdownButton<Faculty> dropdown() {
    return DropdownButton(
      value: _selectedFaculty,
      items: dropdownMenuItems,
      onChanged: (Faculty? value) {
        setState(() {
          _selectedFaculty = value as Faculty;
        });
      },
    );
  }

  Column major() {
    return Column(children: createMajorradio());
  }

  Column radio() {
    return Column(
      children: createGraderadio(),
    );
  }

  TextFormField studentid() {
    return TextFormField(
      controller: _studentidcontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'กรุณากรอก รหัสนิสิต';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      maxLength: 9,
      decoration: const InputDecoration(
          labelText: 'รหัสนิสิต',
          prefixIcon: Icon(Icons.article),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.grey,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ))),
    );
  }

  TextFormField name() {
    return TextFormField(
      controller: _namecontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'กรุณากรอก ชื่อ-นามสกุล';
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'ชื่อ - นามสกุล',
          prefixIcon: Icon(Icons.person),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.grey,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ))),
    );
  }

  Text like() {
    return const Text(
      'ซี่รีส์ที่ชอบ',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Text faculty() {
    return const Text(
      'คณะที่กำลังศึกษา',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Text major1() {
    return const Text(
      'หลักสูตรที่กำลังศึกษา',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Text grade() {
    return const Text(
      'ชั้นปีที่กำลังศึกษา',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Text info() {
    return const Text(
      'ข้อมูลส่วนตัว',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  List<Widget> createGraderadio() {
    List<Widget> listradiograde = [];

    for (var grade in grades) {
      listradiograde.add(
        RadioListTile<dynamic>(
          title: Text('ชั้นปีที่ ' + grade.number!),
          value: grade.gradevalue,
          groupValue: gradeValue,
          onChanged: (value) {
            setState(() {
              gradeValue = value;
              print(value);
            });
          },
        ),
      );
    }
    return listradiograde;
  }

  List<Widget> createMajorradio() {
    List<Widget> listradiomajor = [];

    for (var major in majors) {
      listradiomajor.add(
        RadioListTile<dynamic>(
          title: Text(major.thName!),
          subtitle: Text(major.enName!),
          value: major.majorvalue,
          groupValue: majorValue,
          onChanged: (value) {
            setState(() {
              majorValue = value;
              print(value);
            });
          },
        ),
      );
    }
    return listradiomajor;
  }

  List<Widget> createSiriesCheckbox() {
    List<Widget> listCheckboxSiries = [];
    for (var siries in siriess) {
      listCheckboxSiries.add(
        CheckboxListTile(
          title: Text(siries.name!),
          subtitle: Text(siries.band!),
          value: siries.checked,
          onChanged: (value) {
            setState(() {
              siries.checked = value!;
            });
            if (value!) {
              selectSiries.add(siries.name!);
            } else {
              selectSiries.remove(siries.name!);
            }
            print(selectSiries);
          },
        ),
      );
    }
    return listCheckboxSiries;
  }
}

class Faculty {
  int? value;
  String? name;
  Faculty(this.value, this.name);

  static List<Faculty> getfaculty() {
    return [
      Faculty(0, '---- กรุณาระบุข้อมูล ----'),
      Faculty(1, 'คณะวิทยาศาสตร์'),
      Faculty(2, 'คณะวิทยาการสุขภาพและการกีฬา'),
      Faculty(3, 'คณะวิศวกรรมศาสตร์'),
      Faculty(4, 'คณะเทคโนโลยีและการพัฒนาชุมชน'),
      Faculty(5, 'คณะนิติศาสตร์'),
      Faculty(6, 'คณะศึกษาศาสตร์'),
      Faculty(7, 'คณะอุตสาหกรรมเกษตรและชีวภาพ'),
      Faculty(8, 'คณะพยาบาลศาสตร์'),
    ];
  }
}

