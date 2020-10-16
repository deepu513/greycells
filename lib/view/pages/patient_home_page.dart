import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Hi Deepak',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
                      radius: 16.0,
                    ),
                  ),
                ),
              ],
              // Allows the user to reveal the app bar if they begin scrolling back
              // up the list of items.
              floating: true,
            ),
            // Create a SliverList.
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeaderCard(),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

// * For horizonatally scrollable sliver list
// SliverToBoxAdapter(
//   child: ListView(
//     scrollDirection: Axis.horizontal,
//   )
// ),

// TODO: Accept image, text and ontap parameters here
class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [Color(0xFFC984A1), Color(0xFF4D2294)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "images/self_care_illustration.svg",
                height: 80.0,
                width: 80.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  "Checkout your assessment score",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
