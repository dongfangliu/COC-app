part of 'char_sheet_pages.dart';

class CharSheetPageInvt extends CharSheetPage {
  @override
  String pageTag = "invt";
  CharSheetBloc bloc;
  CharSheetPageInvt(this.bloc);

  @override
  _CharSheetPageInvtState createState() {
    return _CharSheetPageInvtState(bloc, pageTag);
  }
}

class _CharSheetPageInvtState extends State<CharSheetPageInvt> {
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageInvtState(this.bloc, this.pageTag);

  TextStyle _getTextStyle(double size) {
    return TextStyle(
        fontFamily: 'papyrus',
        fontSize: size,
        color: AppTheme.textColor,
        decoration: TextDecoration.none
    );
  }

  InvtData invtData;

  @override
  void initState() {
    super.initState();
    invtData = bloc.state.charData["invt"];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column (
        children: <Widget>[
          SizedBox(height: 20,),
          _buildTitle(),
          _buildInfoPage()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Inventory", style: _getTextStyle(40)),
    );
  }

  Widget _buildInfoPage() {
    return SingleChildScrollView(
      child: Text("Inventory Page"),
    );
  }

}