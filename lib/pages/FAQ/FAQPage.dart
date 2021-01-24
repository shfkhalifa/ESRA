import 'package:esra/bloc/faqBloc/faq.dart';
import 'package:esra/components/loadingWidget/loadingWidget.dart';
import 'package:esra/models/faq.dart';
import 'package:esra/styles.dart';

///
/// By Younss Ait Mou
///

import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.darkBlue,
        title: Text(Strings.FAQ_TITLE),
      ),
      body: BlocBuilder<FaqBloc, FaqState>(
        builder: (context, state) {
          if (state.isLoading) {
            return LoadingWidget();
          } else if (state.loaded) {
            return ListView.separated(
              itemCount: state.faqList.length,
              itemBuilder: (context, index) {
                Faq faq = state.faqList[index];
                return ListTile(
                  onTap: () {
                    // Show the faq detail page
                    Navigator.of(context)
                        .pushNamed('/FAQDetails', arguments: faq);
                  },
                  title: Text(
                    faq.title,
                    style: TextStyle(
                        color: AppStyles.darkBlue, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: AppStyles.dimedBlue,
                );
              },
            );
          } else if (state.error) {}
          return Center(
            child: Text(Strings.FAQ_NONE),
          );
        },
      ),
    );
  }
}
