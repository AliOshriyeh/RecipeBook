import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:test/presentation/widgets/hamburger_menu.dart';
import 'package:test/logic/cubit/4OnlineShowcase/online_showcase_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.apptitle)), //const Text("The Recipe Bloc"),
        drawer: const HamburgerMenu(),
        body: Column(
          children: [
            Flexible(flex: 1, child: Container(color: Colors.deepOrange.shade300, height: MediaQuery.of(context).size.height * 0.05, child: const Center(child: Text("Enjoy A Delicious Trip", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))))),
            const SizedBox(height: 10),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.white,
                child: BlocBuilder<OnlineShowcaseCubit, OnlineShowcaseState>(builder: (context, state) {
                  OnlineShowcaseCubit categoryCubit = context.read<OnlineShowcaseCubit>(); //  BlocProvider.of<OnlineShowcaseCubit>(context);
                  categoryCubit.displayShowcases();
                  if (state is OnlineShowcaseInitial) {
                    return const Center(child: CircularProgressIndicator(color: Colors.red));
                  } else if (state is OnlineShowcaseLoaded) {
                    return state.randomList.isEmpty
                        ? const Center(child: Text("No Recipes Registered Yet!"))
                        : CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              height: MediaQuery.of(context).size.height * 0.35,
                            ),
                            items: state.randomList.map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    //Quick fix for when the error is build. it makes the error card more beatiful
                                    decoration: item.thumbnail == null ? BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.amber.shade200.withOpacity(0.5), width: 1)) : null,
                                    child: Stack(
                                      children: [
                                        FullScreenWidget(
                                          disposeLevel: DisposeLevel.Low,
                                          child: ClipRRect(
                                              borderRadius: BorderRadiusDirectional.circular(10),
                                              child: Image(
                                                //FIXME - Null Address producess error and the error builder doesn't catch it.
                                                // Fix it by putting a static image address
                                                image: CachedNetworkImageProvider(item.thumbnail ?? 'NULL'), // NetworkImage(item.thumbnail ?? 'NULL'),
                                                fit: BoxFit.fitWidth,
                                                width: MediaQuery.of(context).size.width,
                                                errorBuilder: (context, error, stackTrace) => Center(child: Container(color: Colors.amber[200], child: const Icon(Icons.dinner_dining_rounded, size: 100, color: Colors.grey))),
                                              )),
                                        ),
                                        //FIXME - Change the Slider's design - Make It Better
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(item.name,
                                              style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.deepOrangeAccent,
                                                fontWeight: FontWeight.bold,
                                                backgroundColor: Colors.white.withOpacity(0.8),
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          );
                  } else {
                    // In Case The App Reads from Outside of Standard States
                    return const Text("Something Went Wrong!");
                  }
                }),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(flex: 1, child: Container(color: Colors.deepOrange.shade300, height: MediaQuery.of(context).size.height * 0.05, child: const Center(child: Text("Choose Your Category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))))),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.white,
                child: BlocBuilder<OnlineShowcaseCubit, OnlineShowcaseState>(builder: (context, state) {
                  OnlineShowcaseCubit categoryCubit = context.read<OnlineShowcaseCubit>(); // BlocProvider.of<OnlineShowcaseCubit>(context);
                  categoryCubit.displayShowcases();
                  if (state is OnlineShowcaseInitial) {
                    return const Center(child: CircularProgressIndicator(color: Colors.red));
                  } else if (state is OnlineShowcaseLoaded) {
                    // debugPrint(state.categoryList);
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: state.categoryList.first.id == -1
                          ? const Center(child: Text("No Category has been Assigned!"))
                          : GridView.builder(
                              itemCount: state.categoryList.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Maybe in the NEXT Version'))),
                                  //FIXME - Change with Navigation in Category-based Search
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      // const SizedBox(height: 15),
                                      ClipRRect(
                                          borderRadius: BorderRadiusDirectional.circular(10),
                                          child: Image(
                                              image: CachedNetworkImageProvider(state.categoryList[index].thumbnail), //NetworkImage(state.categoryList[index].thumbnail),
                                              fit: BoxFit.fitWidth,
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              errorBuilder: (context, error, stackTrace) => CircleAvatar(
                                                    backgroundColor: Colors.amber[200],
                                                    child: const Icon(Icons.dinner_dining_rounded, size: 30, color: Colors.grey),
                                                  ))),
                                      Text(
                                        state.categoryList[index].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.black.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  } else {
                    // In Case The App Reads from Outside of Standard States
                    return const Text("Something Went Wrong!");
                  }
                }),
              ),
            ),
            // Flexible(flex: 1, child: Container(color: Colors.blue)),
          ],
        ));

    // const Center(child: Icon(Icons.book_rounded, color: Colors.grey, size: 250))
  }
}
