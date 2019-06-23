using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class QRCodeViewerDelegate extends Ui.BehaviorDelegate {

	function initialize() {
		BehaviorDelegate.initialize();
	}

	function onSelect() {
		var app = App.getApp();
		
		if(app.enabledCodeIds.size() > 0) {
			var qrCodesMenu = [];
			var currentId = app.getProperty("currentId");
			var menuIndex = 0;
			for(var i=0; i<app.enabledCodeIds.size(); i++) {
				var id = app.enabledCodeIds[i];
				if(id == currentId) {
					menuIndex = i;
				}
				qrCodesMenu.add(new DMenuItem(i, app.getProperty("codeLabel" + id), app.getProperty("codeValue" + id), id));
			}
			var view = new DMenu(qrCodesMenu, Ui.loadResource(Rez.Strings.mainMenuTitle));
			if(app.getProperty("retainMenuIndex")) {
				view.updateIndex(menuIndex);
			}

			Ui.pushView(view, new DMenuDelegate(view, new QrCodeViewerMenuDelegate()), Ui.SLIDE_IMMEDIATE);
		} else {
			QRCodeViewerView.message = Ui.loadResource(Rez.Strings.errorNoQRCode);
			Ui.requestUpdate();
		}

		return true;
	}
	function onMenu() {	return onSelect(); }
}
