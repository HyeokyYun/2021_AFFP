const firebase = require("firebase-admin");
const serviceAccount = require('./privateKey.json');

const firebaseToken = 'cq9A3_TKTh6wmnRmnqH2OT:APA91bHKEhnqzhUmGtq-kxy_1DG6zDD8bWH7b87gY-jhws1w8P8zu-bHhLeuFBeroIEkeAsHVfT2ioPN-esgwxMm_5Pp37cJ1lT05Cw68zIxRGZG4Q-XmLq3Zr7-6KjbeAQsdkRUBvEU';

firebase.initializeApp({
	credential: firebase.credential.cert(serviceAccount),
});

const payload = {
	notification: {
		title: 'Notification Title',
		body: 'This is an example notification',
		click_action: 'FLUTTER_NOTIFICATION_CLICK'
	},
	data: {
		data1: 'data1 value',
		data2: 'data2 value',
		screen: 'screen2'
	},
};

const options = { prioirty: 'high', timeToLive: 60 * 60 * 24 };
firebase.messaging().sendToDevice(firebaseToken, payload, options);

