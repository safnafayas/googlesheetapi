import 'package:googlesheetcrud/model/usermodel.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _spreadsheetid = '1ynpf13sXl0TCUFh71VcOHSUKzxyIT7gxHfb7Q7_YWsU';

  static final _credentials = r'''{
  "type": "service_account",
  "project_id": "superherogsheet",
  "private_key_id": "df865037108bdf93a783ea793c2c974dca6cb905",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDpk8d81bPfiEWB\nT8sCVjMa1+2PLAMbkg91DgXq8l2xNxbUkxDZkeGFB1ORuKXvNL6AUAEmg5HtD/Tw\nP/aed4wmbzEekEcKhDxwR45Bq7KQoytPdafWW//qB2B7b5xHT1LvlRq/9qarjZYR\nEu/2JUsortBpWysYf02Ju0pjTktRbKE6FPxQPSs2THJhmTuuGIeog6/AzKd+NFEZ\nYu1FNxwJV7FMK1QzCtG/xZHmnTjU0GNs5TUOApAx3OEZXOlKkE+y5/TKtUgdVk+4\naFIt+li23dQLZ0/3k1rXcg2k033d0aJXuF6x6hjZgw59rSZQei8z5aU0Ov8L0QmZ\nmMP0P8TXAgMBAAECggEAY3tJ3PzFseA/vh4GeDXPaVDrAG392tnAFJpG4fSc+/Pb\nGOmUJR4xP2/J44gRwEomEs9AVi92UNHZgBO2DXMcMWhtMre/UhbVCPso9wZSNLES\nKrMRK0aevgWrTZdRJ7v8tka6kGTUQr+4WQhIRH1IwAiIgj7OoY3ir9Uhjx8TDBeY\nTAtbPR72v9SBC2HsSuSMnugLm1u5+GgBuPResM8L95uzTNvnbYVev1em7f044Q42\nBMooxoHKkZEF4259gYBCYRzi5IXNkdzZI+ZjO9UU7QZR0yjOVylhl4p6iLLTDpNE\n90cmruOekl5ZKRIIRl77dBKX+GqrpokX3xtcwFC5iQKBgQD61l5mA8f9pbz+/gn+\nV8jL2OdKaf4mcxNHjCy0H5hrgjRK7wBO64qejQxodI7r45/vIha9Vd3u8nESMzeN\n5M+mCi9ELcFjGbMERkb28y3lUuB2XGEknh3rLQITwJbpJium+hy5iqgaimEp+lYw\nVPpNqYPS3Kj2ZdU9b/M/i9Z+DwKBgQDuYngVz3wZXcZ8Tyq9t5hfNzqtg+ZjZmBv\nKvTcb12qYaz5NWTV0mxyWL/TvISdRd57rzggpeHJgxLw8bB8JPsb/OB50+8lwSLN\nPSaYvuEdy+HmDPP37M+XAyX060EQPrD/G3GOsSKRSr6bKPUK5iHS+cY8UaFuoRHr\niV9DwsKUuQKBgQCqVN1/Wrv4ow5G/Y0duNCylBTjdDxQMb56zFYi7n2bK6yE4e0M\nqmfUKKWvXM8codKeGUDlyyRMuTdNC5iC80iKUMot+wAiYnYsxeg0k4er/O5NkYep\nzPE2HLcXYKVZp0DnP1o4KE7kzukSD1ttsJbUG/NXQd4+i4IVGStOEJBTwwKBgCJi\nZ6nVtLO/9/pEPQkCa2MIh1kx1lBuGujODGWjVqJV1mpXzkSdRnEz5e93mLVKt62l\nd3YWFzxGwLuqUOeHOgUuc35/GFacxhVOhbuwhK4Uk2/oXGRdbw/8L0Rljov2Tvdt\nEPMhD7hfTKD6xmWdDjHtPy/CIoPfjcMonGoctI5ZAoGAYpTq2nnh9/ONOJJGx5Qx\nASPYfUJ98LeRkKaJtZPGa+0M9+aXTGWxDKqDAb+X0jWHrYJL1O3eZqHtpjfPfaFg\nq3+c/rilye7JB0+xxuWJIirYcU9hci/VBEMQmn0kBK94vgKwuGOenmL+CeSqitDY\nAx2s4J0q2DjVYfn//yxLwOI=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@superherogsheet.iam.gserviceaccount.com",
  "client_id": "113019968322979848737",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40superherogsheet.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static final _gsheets = GSheets(_credentials);
  static Worksheet? _usersheet;

  static Future init() async {

    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetid);
      _usersheet = await _getWorkSheet(spreadsheet, title: 'Sheet1');
      final firstrow = UserFields.getFields();
      _usersheet!.values.insertRow(1, firstrow);
    }catch(e){
      print('init error $e');
    }


  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    }
    catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  // static Future getRowCount()async{
  //   if(_usersheet == null) return 0;
  //   final lastRow=await _usersheet!.values.lastRow();
  //   return lastRow?.first;
  // }
  static Future<void> insert(Map<String, dynamic> data) async {
    if (_usersheet == null) return;

    // Insert data into the next available row
    await _usersheet!.values.map.appendRow(data);
  }

}
