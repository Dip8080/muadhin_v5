import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:muaddin/core/utility/app_colors.dart';

class custom_textfield extends StatelessWidget {
  const custom_textfield({
    super.key,
    required this.textEditingController,
    required this.title
  });
final TextEditingController textEditingController;
final String title;
// final String hintText;
// hello darkness my old friend
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 1.w),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            '${title}',
          ),
          SizedBox(height: .5.w),
          Container(
            // margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              // controller: emailController,
              keyboardType: TextInputType.datetime,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 2.w),
              decoration:
                  InputDecoration(
                fillColor:
                    Colors.transparent,
                labelText:
                    '',
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily:
                        'Pacifico',
                    fontWeight:
                        FontWeight
                            .normal,
                    fontSize: 1.w),
                contentPadding:
                    EdgeInsets
                        .symmetric(
                            vertical: 5,
                            horizontal:
                                5),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                              6.0),
                ),
                focusedBorder:
                    OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors
                          .white,
                      width: 1.0),
                  borderRadius:
                      BorderRadius
                          .circular(6),
                ),
                enabledBorder:
                    OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors
                          .white,
                      width: 1.0),
                  borderRadius:
                      BorderRadius
                          .circular(
                              6.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// udpdpated