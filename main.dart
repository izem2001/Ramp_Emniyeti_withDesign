import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(FormApp());
}

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
        color: Colors.white,
         ),
        ),
      ),
      title: 'Ramp Emniyeti Denetim Raporu',
      debugShowCheckedModeBanner: false,
      home: HeaderFormPage(),
    );
  }
}

class HeaderFormPage extends StatefulWidget {
  @override
  _HeaderFormPageState createState() => _HeaderFormPageState();
}

class _HeaderFormPageState extends State<HeaderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _driverController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _aracNoController = TextEditingController();
  final TextEditingController _personelController = TextEditingController();
  final TextEditingController _ucusNoController = TextEditingController();
  final TextEditingController _parkPozController = TextEditingController();
  final TextEditingController _kuyrukNoController = TextEditingController();
  final TextEditingController _kontrolEdenController = TextEditingController();
  final TextEditingController _gozlemciYorumuController = TextEditingController();
  final TextEditingController _kontrolYapanController = TextEditingController();
  final TextEditingController _tarihController = TextEditingController();


  bool _galleyBC = false;
  bool _orta = false;
  bool _kapi1 = false;
  bool _kapi2 = false;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _timeController.text = DateFormat('HH:mm').format(DateTime.now());
    _tarihController.text = DateFormat('dd.MM.yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'image/logo_doco.png',
              height: 32,
            ),
            SizedBox(width: 10),
            Text('Ramp Emniyeti Denetim Raporu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
            ),
          ],
        ),
         backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Expanded(child: _buildDateField('Tarih', _dateController)),
                  SizedBox(width: 16),
                  Expanded(child: _buildTextField('Yardımcı Personel', _driverController)),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTimeField('Saat', _timeController)),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField('Araç No', _aracNoController, isNumber: true),
                  ),
                ],
              ),
              SizedBox(height: 0),

              Text('', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
              SizedBox(height: 0),
              _buildTextField('Sürücü Adı ve Soyadı', _personelController),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(child: _buildTextField('Uçuş No', _ucusNoController, isNumber: true)),
                  SizedBox(width: 16),
                  Expanded(child: _buildTextField('Park Pozisyonu', _parkPozController)),
                ],
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(child: _buildTextField('Kuyruk No', _kuyrukNoController, isNumber: true)),
                  SizedBox(width: 16),
                  Expanded(child: _buildTextField('Kontrol Eden', _kontrolEdenController)),
                ],
              ),

              Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 0),

              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildCheckboxOption('Galley B/C', _galleyBC, (value){
                          setState(() => _galleyBC = value!);
                        }),
                        _buildCheckboxOption('ORTA', _orta, (value) {
                          setState(() => _orta = value!);
                        }),
                        SizedBox(height: 8),
                        _buildCheckboxOption('Y/C Kapı 1', _kapi1, (value) {
                          setState(() => _kapi1 = value!);
                        }),
                        SizedBox(height: 8),
                        _buildCheckboxOption('Y/C Kapı 2', _kapi2, (value) {
                          setState(() => _kapi2 = value!);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Devam Et',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QuestionPage(
            headerData: {
              'Tarih': _dateController.text,
              'Sürücü': _driverController.text,
              'Saat': _timeController.text,
              'Araç No': _aracNoController.text,
              'Yardımcı Personel': _personelController.text,
              'Uçuş No': _ucusNoController.text,
              'Park Pozisyonu': _parkPozController.text,
              'Kuyruk No': _kuyrukNoController.text,
              'Kontrol Eden': _kontrolEdenController.text,
              'Galley B/C': _galleyBC,
              'ORTA': _orta,
              'Y/C Kapı 1': _kapi1,
              'Y/C Kapı 2': _kapi2,
            },
          ),
        ),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label boş olamaz';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label boş olamaz';
        }
        return null;
      },
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          controller.text = pickedTime.format(context);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label boş olamaz';
        }
        return null;
      },
    );
  }

  Widget _buildCheckboxOption(String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.teal,
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class Question {
  final String questionText;
  final int point;
  String? answer;
  String? explanation;

  Question({required this.questionText, this.point = 1});
}


class QuestionGroup {
  final String title;
  final List<Question> questions;

  QuestionGroup({required this.title, required this.questions,});

}

class QuestionPage extends StatefulWidget {
  final Map<String, dynamic> headerData;

  QuestionPage({required this.headerData});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  TextEditingController _gozlemciYorumuController = TextEditingController();
  TextEditingController _kontrolYapanController = TextEditingController();
  TextEditingController _tarihController = TextEditingController();

  final List<QuestionGroup> allGroups = [
    QuestionGroup(
      title: 'ARAÇ KONTROLÜ',
      questions: [
        Question(
            questionText: '1. Personel görev formundaki sefer numarası ile araç içerisindeki ikramların sefer numarası kontrolünü yaptı mı?', point: 3),
        Question(
            questionText: '2. Yüklemeye çıkacak kamyonda yan ve arka kapı sealları takılı mı? Araç içindeki troley ve ekipmanlar sabitlenmiş mi? İp ile bağlanmış mı?', point: 3),
        Question(
            questionText: '3. Personel ikram kamyonu harekete başlamadan önce gerekli fiziki kontrolleri yapıyor mu?', point: 3),
      ],
    ),
    QuestionGroup(
      title: 'SÜRÜŞ KURALLARI',
      questions: [
        Question(
            questionText: '4. Yüklemeye çıkacak kamyonda lastikler, yağ kaçağı, fren kontrolü, göstergeler, apron plakası, araç tanıtım, akaryakıt kontrolü, araç temizliği, yangın tüpü, tepe lambası vs. gibi fiziki kontroller yapılmış mı?', point: 2),
        Question(
            questionText: '5. Personel koruyucu ekipmanlarını kullanıyor mu? (yelek, kulaklık, koruyucu ayakkabı)', point: 2),
        Question(questionText: '6. Sürüş esnasında telefon kullanıldı mı?', point: 4),
        Question(
            questionText: '7. Apronda hız limitine uygun araç kullanıyor mu? (Araç servis yolu 30km/h, Çevre Yolu 50km/h, Düşük Görüş Operasyonu 50km/h)', point: 3),
        Question(
            questionText: '8. Personel alçak tavan yükseklik (3.10mt) levhası bulunan yerlerden geçti mi?', point: 3),
        Question(
            questionText: '9. Apronda beyaz çizgilerle belirlenen "araç servis yolu"na uygun araç kullandı mı?', point: 3),
        Question(
            questionText: '10. Personel, Taxi yolundan kurallara uygun olarak geçiş yaptı mı?', point: 4),
        Question(
            questionText: '11. Aprondaki DUR yazan levha ve işaretlerin bulunduğu alanda durdu mu?', point: 3),
        Question(
            questionText: '12. İki uçak arası geçişlerde uçak kanat kontrolü yaptı mı?', point: 3),
        Question(
            questionText: '13. Personel kırmızı taralı alanlarda park etme veya geçiş yaptı mı?', point: 3),
        Question(
            questionText: '14. Mars pozisyonunda bekleme ya da parklama yapıldı mı?', point: 4),
      ],
    ),
    QuestionGroup(
      title: 'UÇAK YANAŞMA',
      questions: [
        Question(
            questionText: '15. Personel uçak beklerken park yeri kurallarına uygun hareket ediyor mu?', point: 3),
        Question(
            questionText: '16. Personel, araç ile uçak altına girmeden önce motorları durmuş, motor ikaz lambaları sönmüş ve tüm takozlar konulmuş muydu?', point: 4),
        Question(
            questionText: '17. Uçak altı manevralarda uçağın solunda kalması, aracın yürüyüş hızında kullanılması ve fren kontrolü yapma kuralına uygun davranıyor mu?', point: 4),
        Question(
            questionText: '18. Uçağa yanaşma ya da ayrılma esnasında kanal altından geçti mi?', point: 3),
        Question(
            questionText: '19. Uçağa yanaşma esnasında kapının kavisi hesaplanarak uçak kapısına uygun şekilde yanaşıldı mı?', point: 3),
        Question(
            questionText: '20. Ön platform ile uçağın kapısı arasında güvenli mesafe bıraktı mı?', point: 3),
        Question(
            questionText: '21. Personel aracın ayaklarını basıp, araç ve FOD kontrollerini yaptı mı?', point: 3),
        Question(
            questionText: '22. Kamyonun ön sahanlığının uçak kapısının altına gelmeyecek şekilde yanaştı mı?', point: 3),
        Question(
            questionText: '23. Uçak kapısı çalınıp, kapının açılması için uygunluk işareti verildi mi?', point: 2),
      ],
    ),
    QuestionGroup(
      title: 'İKRAM YÜKLEME',
      questions: [
        Question(
            questionText: '24. Platform yüksekliği uçak kapısına uygun ayarlandı mı?', point: 2),
        Question(
            questionText: '25. H/L köprüsünü kapı eşiğindeki metal kısım ve aparatlara değmeyecek şekilde uçak içi zemine yavaşça bırakıp ve köprü bariyerlerini açtı mı?', point: 25),
        Question(
            questionText: '26. H/L köprüsü uçağa konulduktan sonra H/L platformu aşağı-yukarı ya da sağa-sola hareket ettirildi mi?', point: 2),
        Question(
            questionText: '27. Yükleme ya da boşaltma esnasında trolley üzerinde ünit taşındı mı?', point: 2),
        Question(
            questionText: '28. İkram yüklemesi yükleme planlarına ve pozisyon numaralarına uygun olarak yapıldı mı?', point: 2),
        Question(
            questionText: '29. Yükleme tamamlandıktan sonra boşaltılan ikramların kontrolü ve sabitlemesi (bağlanması ve trolley sıkıştırma mekanizması kapatılması) yapıldı mı?', point: 2),
      ],
    ),
    QuestionGroup(
      title: 'UÇAKTAN AYRILMA',
      questions: [
        Question(
            questionText: '30. Uçak kapısının kapatılması için kabin ekibi ya da yetkisi olan personel ile iletişim kuruldu mu?', point: 2),
        Question(
            questionText: '31. H/L köprüsü uçaktan alınmadan önce emniyet bandı takıldı mı?', point: 3),
        Question(
            questionText: '32. Köprü korkulukları kapatılıp, köprü yerine sabitlendi mi?', point: 3),
        Question(
            questionText: '33. H/L kasası indirilmeden önce aracın etrafı kontrol edildi mi? Kasa indirmeye engel araç ya da malzeme var ise çekilmesi için uyarı yapıldı mı?', point: 3),
        Question(
            questionText: '34. H/L ayakları toplanıp, araç ve FOD kontrolü yapıldı mı?', point: 3),
        Question(
            questionText: '35. Geri manevra yaparken marshalling yapıldı mı? Marshaller komutlarını doğru verdi mi?', point: 4),
      ],
    ),
    QuestionGroup(
      title: 'GÖZLEM RAPOR SONUCU',
      questions: [
        Question(questionText: 'Gözlem raporu sonuca uygun mu?'),

      ],
    ),
  ];

  Color _getGroupColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue.shade800;
      case 1:
        return Colors.orange.shade700;
      case 2:
        return Colors.teal.shade700;
      case 3:
        return Colors.deepPurple.shade600;
      case 4:
        return Colors.red.shade700;
      case 5:
        return Colors.grey.shade800;
      default:
        return Colors.black;
    }
  }
  bool validateAllAnswers(List<QuestionGroup> groups) {
    for (var group in groups) {
      for (var question in group.questions) {
        if (question.answer == null || question.answer!.isEmpty) {
          return false;
        }
        if (question.answer == 'Hayır' && (question.explanation == null || question.explanation!.trim().isEmpty)) {
          return false;
        }
      }
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ramp Emniyeti Denetim Raporu',
          style: TextStyle(color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ...allGroups.asMap().entries.map((entry) {
            int groupIndex = entry.key;
            final group = entry.value;
            final color = _getGroupColor(groupIndex);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  color: color,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    group.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                ...group.questions.map((q) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q.questionText,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      q.answer = 'Evet';
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: q.answer == 'Evet' ? Colors.green : Colors.grey,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: Text('Evet', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(width: 2),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      q.answer = 'Hayır';
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: q.answer == 'Hayır' ? Colors.red : Colors.grey,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: Text('Hayır', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Açıklama',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) => q.explanation = value,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            );
          }).toList(),

          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    'Ramp emniyeti gözlem raporunda başarısız olan personele Ramp Emniyeti ve Apron Kuralları Tazeleme Eğitimi verilir.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.black,),
                  ),
                ),

                SizedBox(height: 24),

                Text('Gözlemci Yorumu:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 8),
                TextField(
                  controller: _gozlemciYorumuController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Yorumunuzu yazın...',
                  ),
                ),

                SizedBox(height: 24),

                TextFormField(
                  controller: _kontrolYapanController,
                  decoration: InputDecoration(
                    labelText: 'Kontrol Yapan',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 24),

                TextFormField(
                  controller: _tarihController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Tarih',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _tarihController.text = DateFormat('dd.MM.yyyy').format(pickedDate);
                      });
                    }
                  },
                ),

                SizedBox(height: 80),
              ],
            ),
          ),

          SizedBox(height: 80),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(!validateAllAnswers(allGroups)){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Lütfen tüm soruları yanıtlayın ve Hayır yanıtları için açıklama girin.'),
                  backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }
          List<Question> allQuestions = allGroups.expand((group) => group.questions).toList();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResultPage(questions: allQuestions),
            ),
          );
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.check,color: Colors.white,),
        tooltip: 'Formu Bitir',
      ),
    );
  }
}
class ResultPage extends StatelessWidget {
  final List<Question> questions;

  ResultPage({required this.questions});

  /// Maksimum puanı hesaplar (tüm soru puanlarının toplamı)
  int maxScore() {
    return questions.fold(0, (sum, q) => sum + q.point);
  }

  /// Kullanıcının doğru cevapladığı puanları hesaplar
  int calculateScore() {
    int score = 0;
    for (var q in questions) {
      if (q.answer == 'Evet') {
        score += q.point;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    int totalScore = calculateScore();
    int fullScore = maxScore();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sonuç", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'animation/check.gif',
                width: 150,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.check_circle,
                      color: Colors.green,
                      size: 150);
                },
              ),
              SizedBox(height: 30),
              Text(
                'Yanıtınız Başarıyla Kaydedildi!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Teşekkürler!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey[700],
                ),
              ),
              SizedBox(height: 30),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    children: [
                      Text(
                        'Toplam Puan',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$totalScore / $fullScore',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Ana Sayfaya Dön",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
