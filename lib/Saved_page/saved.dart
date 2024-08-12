import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_exit/non_web_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/Home_pages/shoping_cart.dart';
import 'package:learning/Home_pages/video.dart';

class Save extends StatefulWidget {
  const Save({super.key});

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final firestoreSave = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid.toString())
        .collection('saves')
        .snapshots();
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid.toString())
        .collection("saves");
    return DoubleBackToExitWidget(
      snackBarMessage: 'Press back again to exit',
      child:  Scaffold(
        appBar: AppBar( backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding:  EdgeInsets.only(left: 50.w),
            child: Center(
              child: Text(
                " Saved Courses",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.24.w,
                    )),
              ),
            ),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: 5.w),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ShopingCart()));
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 29.sp,
                ),
              ),
            )
          ],
        ), backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream: firestoreSave,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("error"),
                );
              }
              if (snapshot.hasData) {
                return SizedBox(
                  width: 500.w,
                  height: 700.h,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 300 / 390,
                    shrinkWrap: true,
                    children: List.generate(
                      snapshot.data!.docs.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Video(
                                    video: snapshot.data!.docs[index]["video"],
                                    coursename: snapshot
                                        .data!.docs[index]["coursename"]
                                        .toString(),
                                    about: snapshot.data!.docs[index]["about"]
                                        .toString(),
                                    image: snapshot.data!.docs[index]["img"]
                                        .toString(),
                                    rating: snapshot.data!.docs[index]["rating"]
                                        .toString(),
                                    id: snapshot.data!.docs[index]["id"]
                                        .toString(),
                                    tutter: snapshot.data!.docs[index]["tutter"]
                                        .toString(),
                                    fee: snapshot.data!.docs[index]["fee"]
                                        .toString())));
                          },
                          child: Container(
                            width: 200.w,
                            height: 500.h,
                            decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r))),
                            child: Padding(
                              padding:  EdgeInsets.all(5.0.sp),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 100.h,
                                    width: 200.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.r),
                                          topLeft: Radius.circular(10.r)),
                                      child: Image.network(
                                        snapshot.data!.docs[index]["img"]
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(
                                        left: 10.w, top: 10.h),
                                    child: Row(
                                      children: [
                                        Opacity(   opacity: 0.50,
                                          child: Text(
                                            snapshot.data!.docs[index]["rating"]
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xFF060302),
                                              fontSize: 20.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0.10.h,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        RatingBar.builder(
                                          itemSize: 17.sp,
                                          initialRating: double.parse(snapshot
                                              .data!.docs[index]["rating"]
                                              .toString()),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                     EdgeInsets.only(right: 10.w, top: 5.h),
                                    child: SizedBox(
                                      width: 151.70.w,
                                      child: Text(
                                          snapshot.data!.docs[index]["coursename"]
                                              .toString(),
                                          style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                              color: Color(0xFF060302),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                     EdgeInsets.only(left: 8.w, top: 6.h),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person,),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]["tutter"]
                                              .toString(),
                                          style: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.14.w,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                     EdgeInsets.only(left: 8.w,),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          " \$ ${snapshot.data!.docs[index]["fee"].toString()}",
                                          style: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFF477B72),
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: -0.18.w,
                                              )),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            ref.doc(snapshot.data!.docs[index]["id"]).delete();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
