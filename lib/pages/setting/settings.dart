import 'package:flutter/material.dart';
import 'package:khata_connect/pages/backup/backup.dart';
import 'package:khata_connect/pages/setting/currency_selection.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../helpers/appLocalizations.dart';
import '../../helpers/constants.dart';
import '../../providers/my_theme_provider.dart';
import '../../providers/stateNotifier.dart';
import '../../models/business.dart';
import '../businesses/businessInformation.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String _currency = "Rs";
  Business? _businessInfo = Business();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeStatus = Provider.of<MyThemeProvider>(context);
    Color color = themeStatus.themeType ? Colors.black : Colors.white;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                //color: Theme.of(context).primaryColor,
                ),
            height: 150,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 100,
                    height: 60,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('appInfo'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 1.6,
                      //color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  //color: Theme.of(context).primaryColor,
                  ),
              child: Transform.translate(
                offset: const Offset(0.0, 10.0),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0)),
                      color: Colors.white,
                    ),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      shrinkWrap: true,
                      children: <Widget>[
                        SwitchListTile(
                            title: Text(
                              AppLocalizations.of(context)!.translate('theme'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                            subtitle: Text(AppLocalizations.of(context)!
                                .translate('themeSubtitle')),
                            secondary: Icon(
                              themeStatus.themeType
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              size: 30,
                            ),
                            value: themeStatus.themeType,
                            onChanged: (value) {
                              themeStatus.setTheme = value;
                            }),
                        InkWell(
                          onTap: () async {
                            final updatedBusinessInfo = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessInformation(),
                              ),
                            );
                            if (updatedBusinessInfo != null) {
                              setState(() {
                                _businessInfo =
                                    updatedBusinessInfo; // Update the state with the new business info
                              });
                            }
                          },
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage("assets/images/business.png"),
                              width: 30,
                              height: 30,
                            ),
                            title: Text(
                              AppLocalizations.of(context)!
                                  .translate('businessInfo'),
                            ),
                            subtitle: Text(
                              AppLocalizations.of(context)!
                                  .translate('businessInfoMeta'),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Backup(),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage("assets/images/backup.png"),
                              width: 30,
                              height: 30,
                            ),
                            title: Text(AppLocalizations.of(context)!
                                .translate('backupInfo')),
                            subtitle: Text(AppLocalizations.of(context)!
                                .translate('backupInfoMeta')),
                          ),
                        ),
                        ListTile(
                          leading: const Image(
                            image: AssetImage("assets/images/lang.png"),
                            width: 30,
                            height: 30,
                          ),
                          title: Text(AppLocalizations.of(context)!
                              .translate('languageInfo')),
                          subtitle: Text(AppLocalizations.of(context)!
                              .translate('languageInfoMeta')),
                          trailing: DropdownButton<String>(
                            iconEnabledColor: Colors.black,
                            value: Provider.of<AppStateNotifier>(context)
                                .appLocale,
                            onChanged: (String? newValue) async {
                              await changeLanguage(context, newValue!);
                            },
                            items: <String>["en", "ur"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            "assets/images/$value.png"),
                                        width: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(value == "en" ? "English" : "اردو"),
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                        // ListTile(
                        //   leading: const Image(
                        //     image: AssetImage("assets/images/calendar.png"),
                        //     width: 30,
                        //     height: 30,
                        //   ),
                        //   title: Text(AppLocalizations.of(context)!
                        //       .translate('changeCalendar')),
                        //   subtitle: Text(AppLocalizations.of(context)!
                        //       .translate('changeCalendarMeta')),
                        //   trailing: DropdownButton<String>(
                        //     iconEnabledColor: Colors.black,
                        //     value:
                        //         Provider.of<AppStateNotifier>(context).calendar,
                        //     onChanged: (String? newValue) async {
                        //       await changeCalendar(context, newValue!);
                        //     },
                        //     items: <String>["en", "ur"]
                        //         .map<DropdownMenuItem<String>>((String value) {
                        //       return DropdownMenuItem<String>(
                        //           value: value,
                        //           child: Row(
                        //             children: [
                        //               Text(value == "en" ? "English" : "Urdu"),
                        //             ],
                        //           ));
                        //     }).toList(),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     showBottomSheet(
                        //       context: context,
                        //       builder: (context) => StatefulBuilder(builder:
                        //           (BuildContext context, StateSetter setState) {
                        //         return Transform.translate(
                        //           offset: const Offset(0.0, 80.0),
                        //           child: contactForm(context),
                        //         );
                        //       }),
                        //     );
                        //   },
                        //   child: ListTile(
                        //     leading: const Image(
                        //       image: AssetImage("assets/images/currency.png"),
                        //       width: 30,
                        //       height: 30,
                        //     ),
                        //     title: Text(AppLocalizations.of(context)!
                        //         .translate('changeCurrency')),
                        //     subtitle: Text(AppLocalizations.of(context)!
                        //         .translate('changeCurrencyMeta')),
                        //     trailing: Text(
                        //         Provider.of<AppStateNotifier>(context)
                        //             .currency),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CurrencySelectionScreen(),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage("assets/images/currency.png"),
                              width: 30,
                              height: 30,
                            ),
                            title: Text(
                              AppLocalizations.of(context)!
                                  .translate('changeCurrency'),
                            ),
                            subtitle: Text(
                              AppLocalizations.of(context)!
                                  .translate('changeCurrencyMeta'),
                            ),
                            trailing: Text(Provider.of<AppStateNotifier>(context).currency, style: const TextStyle(fontSize: 16),),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Share.share(
                                'Check out my portfolio: https://offfahad.netlify.app');
                          },
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage("assets/images/share.png"),
                              width: 30,
                              height: 30,
                            ),
                            title: Text(AppLocalizations.of(context)!
                                .translate('shareInfo')),
                            subtitle: Text(AppLocalizations.of(context)!
                                .translate('shareInfoMeta')),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactForm(BuildContext context) {
    _currency = Provider.of<AppStateNotifier>(context).currency;
    return Container(
      height: 350,
      padding: const EdgeInsets.all(36),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        //color: Colors.blueGrey.shade100,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.translate('changeCurrency'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                initialValue: _currency,
                onSaved: (String? val) {
                  _currency = val!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!
                        .translate('currencyError');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //foregroundColor: Colors.white,
                  backgroundColor: xDarkBlue, // Text color
                ),
                child: Text(
                  AppLocalizations.of(context)!.translate('updateCurrency'),
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await changeCurrency(context, _currency);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
