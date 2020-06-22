class AppUpdateEntity {
	String androidUrl;
	String needForcedUpdating;
	String describe;
	String iosUrl;
	String version;

	AppUpdateEntity({this.androidUrl, this.needForcedUpdating, this.describe, this.iosUrl, this.version});

	AppUpdateEntity.fromJson(Map<String, dynamic> json) {
		androidUrl = json['androidUrl'];
		needForcedUpdating = json['needForcedUpdating'];
		describe = json['describe'];
		iosUrl = json['iosUrl'];
		version = json['version'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['androidUrl'] = this.androidUrl;
		data['needForcedUpdating'] = this.needForcedUpdating;
		data['describe'] = this.describe;
		data['iosUrl'] = this.iosUrl;
		data['version'] = this.version;
		return data;
	}
}
