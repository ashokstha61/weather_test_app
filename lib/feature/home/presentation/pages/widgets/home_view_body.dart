import 'package:flutter/material.dart';
import 'package:weather/core/utils/constants.dart';
import 'package:weather/feature/home/presentation/pages/widgets/search_text_field.dart';


class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constants.defaultPadding),
      child: Column(
        children: const [
          SearchTextField(),
          
        ],
      ),
    );
  }
}
