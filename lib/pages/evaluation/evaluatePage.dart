import 'dart:io';

import 'package:division/division.dart';
import 'package:esra/models/assessment.dart';

///
/// By Younss Ait Mou
///
///
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/manageChildrenBloc/mangeChildren.dart';
import '../../bloc/predictionBloc/prediction.dart';
import '../../components/dialogs/infoDialog.dart';
import '../../components/errorWidget/errorWidget.dart';
import '../../components/feedbackWidget/feedBackWidget.dart';
import '../../components/AssessmentWidget/AssessmentWidget.dart';
import '../../components/loadingWidget/loadingWidget.dart';
import '../../components/predictionResultsWidget/predictionResultsWidget.dart';
import '../../models/child.dart';
import '../../repositories/predictionRepository.dart';
import '../../repositories/userRepository.dart';
import '../../styles.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:esra/localization/language_constants.dart';

enum PredictionImageSource { camera, gallery }

class EvaluatePage extends StatefulWidget {
  const EvaluatePage({Key key}) : super(key: key);

  @override
  _EvaluatePageState createState() => _EvaluatePageState();
}

class _EvaluatePageState extends State<EvaluatePage> {
  String _selectedChild;
  File _selectedImage;
  //File _croppedImage;
  PredictionBloc _predictionBloc;
  http.Client httpClient;
  bool _showFloatingButton = true;

  @override
  void initState() {
    super.initState();
    _predictionBloc =
        PredictionBloc(context.repository<PredictionRepository>());
    httpClient = http.Client();
  }

  @override
  void dispose() {
    super.dispose();
    _predictionBloc.close();
  }

  void _makePrediction(PredictionImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    ImageSource imageSource;

    switch (source) {
      case PredictionImageSource.gallery:
        imageSource = ImageSource.gallery;
        break;
      case PredictionImageSource.camera:
        imageSource = ImageSource.camera;
        break;
    }
    final PickedFile pickedImage = await _picker.getImage(
        source: imageSource, maxHeight: 300, maxWidth: 400);
    if (pickedImage != null) {
      File tmpFile = File(pickedImage.path);

      // Get the path to the apps directory so we can save the file to it.
      final Directory dir = await getApplicationDocumentsDirectory();
      final String myPath = dir.path;
      final String fileName =
          path.basename(pickedImage.path); // Filename without extension
      final String fileExtension =
          path.extension(pickedImage.path); // e.g. '.jpg'
      // print(
      //     "will copy the new image to the following path: $myPath/$fileName$fileExtension");
      //_selectedImage = await tmpFile.copy('$myPath/$fileName');
      final File newImage = await tmpFile.copy('$myPath/$fileName');
      setState(() {
        _selectedImage = newImage;
      });

      if (_selectedImage != null)
        _predictionBloc.add(GetPrediction(imagePath: _selectedImage.path));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PredictionBloc, PredictionState>(
          bloc: _predictionBloc,
          listener: (context, state) async {
            if (state.isFeedbackSent != null && state.isFeedbackSent) {
              // Acknowledge feedback sent dialog
              await infoDialog(
                context,
                Strings.FEEDBACK_CONFIRMATION_DIALOG_TITLE,
                Strings.FEEDBACK_CONFIRMATION_DIALOG_BODY,
              );
            } else if (state.isPredictionSavedSuccess) {
              // Acknowledge prediction saved successfully dialog
              BlocProvider.of<ManagechildrenBloc>(context).add(GetChildren());
              await infoDialog(
                context,
                getTranslated(
                    context, "PREDICTION_SAVED_CONFIRMATION_DIALOG_TITLE"),
                getTranslated(
                    context, "PREDICTION_SAVED_CONFIRMATION_DIALOG_SUBTITLE"),
              );
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.darkBlue,
          title: Text(getTranslated(context, 'EVALUATE_TITLE')),
        ),
        floatingActionButton: (_selectedChild != null && _showFloatingButton)
            ? SpeedDial(
                // child: Image(
                //   image: AssetImage(AppIcons.analyze),
                //   color: Colors.white,
                // ),
                animatedIcon: AnimatedIcons.add_event,
                children: [
                  SpeedDialChild(
                    child: Icon(Icons.collections),
                    label: getTranslated(context, "UPLOAD_BTN_LABEL"),
                    onTap: () {
                      setState(() {
                        _showFloatingButton = false;
                      });
                      _makePrediction(PredictionImageSource.gallery);
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.camera_alt),
                    label: getTranslated(context, "CAPTURE_BTN_LABEL"),
                    onTap: () {
                      setState(() {
                        _showFloatingButton = false;
                      });
                      _makePrediction(PredictionImageSource.camera);
                    },
                  ),
                ],
              )
            : null,
        body: BlocBuilder<ManagechildrenBloc, ManagechildrenState>(
          builder: (context, state) {
            if (state.childrenList.isEmpty) {
              return Center(
                  child: Text(getTranslated(context, "NO_CHILD_MESSAGE")));
            }
            List<DropdownMenuItem<String>> childrenMenuItems = [];
            List<Child> children = state.childrenList;
            children.forEach((child) {
              childrenMenuItems.add(DropdownMenuItem(
                value: child.name,
                child: Text(child.name),
              ));
            });
            return BlocBuilder<PredictionBloc, PredictionState>(
              bloc: _predictionBloc,
              builder: (context, state) {
                if (state.isPredicting) {
                  return LoadingWidget();
                } else if (state.isSuccess) {
                  if (_selectedImage == null) {
                    print("_selectedImage is null");
                  }
                  return PredictionResultWidget(
                    label: state.prediction.label,
                    score: state.prediction.score,
                    image: _selectedImage,
                    onDismiss: (bool shouldSave) {
                      if (shouldSave) {
                        // Save prediction result
                        _predictionBloc.add(
                          SavePrediction(),
                        );
                      } else {
                        _predictionBloc.add(DismissPrediction());
                      }
                    },
                  );
                } else if (state.isPredictionDismissed) {
                  ;
                  return FeedbackWidget(
                    onSubmit: (String feedback) async {
                      String token = await context
                          .repository<UserRepository>()
                          .readToken();
                      _predictionBloc.add(SendFeedback(
                        feedbackMsg: feedback,
                        childId: children
                            .firstWhere((child) => child.name == _selectedChild)
                            .id,
                        imagePath: _selectedImage.path,
                        prediction: state.prediction,
                        token: token,
                      ));
                    },
                  );
                } else if (state.isPredictionSaved) {
                  //TODO: here we implement the survery and find a way to keep the prediction
                  return AssessmentWidget(
                    onSubmitted: ([AssessmentRecord record]) async {
                      _predictionBloc.add(
                        SavePredictionSuccess(
                          //imagePath: _croppedImage.path,
                          imagePath: _selectedImage.path,
                          prediction: state.prediction,
                          childId: children
                              .firstWhere(
                                  (child) => child.name == _selectedChild)
                              .id,
                          assessment: record,
                          assessAvailable: (record != null) ? 'true' : 'false',
                        ),
                      );
                    },
                  );
                } else if (state.isFailure) {
                  return EsraErrorWidget(
                    errorMsg: state.errorMsg,
                  );
                }
                return Parent(
                  style: ParentStyle()..alignment.center(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage(AppIllustrations.addDrawing),
                        width: 300,
                      ),
                      SizedBox(height: 24),
                      Parent(
                        style: AppStyles.dropDownStyle,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(border: InputBorder.none),
                          value: _selectedChild,
                          hint: Text(getTranslated(
                              context, "EVALUATE_SELECT_CHILD_HINT")),
                          items: childrenMenuItems,
                          onChanged: (String child) {
                            setState(() {
                              _selectedChild = child;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
