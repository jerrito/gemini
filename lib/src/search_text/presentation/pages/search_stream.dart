import 'package:flutter/material.dart';
import 'package:gemini/core/api/api_key.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/widgets/bottom_sheet.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/search_text/data/datasource/remote_ds.dart';
import 'package:gemini/src/search_text/presentation/bloc/search_bloc.dart';
import "package:google_generative_ai/google_generative_ai.dart" as ai;


class SearchStreamPage extends StatefulWidget {
  const SearchStreamPage({super.key});

  @override
  State<SearchStreamPage> createState() => _SearchStreamPageState();
}

class _SearchStreamPageState extends State<SearchStreamPage> {
  final searchBloc = sl<SearchBloc>();
  final searchBloc2 = sl<SearchBloc>();
  final form = GlobalKey<FormState>();
  final controller = TextEditingController();
    final model = ai.GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);

  final content = [ai.Content.text("what is Magnetism")];
  final searchRemoteDatasource = SearchRemoteDatasourceImpl(networkInfo: sl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jerrito Gemini AI"),
        centerTitle: true,
      ),
      bottomSheet: Form(
        key: form,
        child: bottomSheetTextfield(
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Field is required";
            }

            return null;
          },
          onChanged: (value) {
            //  field.didChange(value);
          },
          controller: controller,
          context: context,
          onPressed: () {
            if (form.currentState?.validate() == true &&
                controller.text.isNotEmpty) {
              Map<String, dynamic> paramsWithImage = {
                "text": controller.text,
              };
              searchBloc.add(
                GenerateContentEvent(params: paramsWithImage),
              );
            }
          },
          onTap: () {},
          isTextAndImage: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().width(
            context,
            0.04,
          ),
          vertical: Sizes().height(
            context,
            0.02,
          ),
        ),
        child: FutureBuilder(
            future: model.generateContent(content),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                final data = snapshot.error;
                print(data.toString());
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(question ?? ""),
                      Space().height(context, 0.02),
                      Text(data.toString()),
                    ],
                  ),
                );
              }
              if (snapshot.connectionState==ConnectionState.done) {
                final data = snapshot.data?.text;
                print(data.toString());
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const Text(""),
                      Space().height(context, 0.02),
                      Text(data.toString()),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
