import 'package:dashboard_front_end/pages/home/components/logout_button.dart';
import 'package:dashboard_front_end/pages/home/components/widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MyWidget> _widgets = [const MyWidget(), const MyWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F4FA),
        body: Row(
          children: [
            AspectRatio(
              aspectRatio: 0.25,
              child: ColoredBox(
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Image(
                        width: 60,
                        image: AssetImage("EpiBoard-Logo.png"),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: const BorderSide(
                                width: 1.5, color: Colors.white),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            _widgets.add(const MyWidget());
                            setState(() {});
                            print(_widgets.length);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("New Widget"),
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Logout()],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ColoredBox(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "6 widgets are running",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _widgets.length,
                    itemBuilder: (context, index) {
                      return new MyWidget();
                    },
                  )
                  // ListView(
                  //   scrollDirection: Axis.vertical,
                  //   shrinkWrap: true,
                  //   children: _widgets,
                  // ),
                ],
              ),
            )
          ],
        ));
  }
}
