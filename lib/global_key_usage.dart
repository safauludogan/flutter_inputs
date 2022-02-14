import 'package:flutter/material.dart';

void main() => runApp(GlobalKeyUsage());

class GlobalKeyUsage extends StatelessWidget {
  GlobalKeyUsage({Key? key}) : super(key: key);

  //Global keyleri, widgetlerimiza erişmek için kullanıyoruz
  //Onlara birer label atıyoruz ve referanslarına erişiyoruz.
  //Buradaki global key'in kullanım amacı: Bir form'da değişiklik yaptığımızda bütün sayfa tekrar renderlanır. Eğer biz,
  //Widgetlerimızı bölersek bunun önüne geçeriz ve performans artışı gözlemlenir.
  //Sadece renderlanması gereken widget'ı başka bir statefull yapı içerisinde tanımlarız ve sadece o widget rendarlanır.
  //Başka bir yere aldığımı bu widget'ın fonksiyonlarına erişmek için ise global key yapısını kullanıyoruz.
  final counterWidgetKey = GlobalKey<_CounterWidgetState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Global Key Kullanımı'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Butona tıklanma miktarı'),
              CounterWidget(key: counterWidgetKey,),//Burada global key'i atama işlemi yapıyoruz.
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            counterWidgetKey.currentState!.increase();//Global key ile CounterWidget içerisindeki değişken ve fonksiyonlara erişiyoruz.
          },
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  void increase() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _counter.toString(),
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
