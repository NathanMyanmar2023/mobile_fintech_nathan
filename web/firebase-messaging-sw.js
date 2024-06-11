importScripts("https://www.gstatic.com/firebasejs/7.23.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.23.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyDD4fyBjXnKohSDE2xDHLhePuelc6z_MX4",
    authDomain: "nathanfintech-c0270.firebaseapp.com",
    projectId: "nathanfintech-c0270",
    storageBucket: "nathanfintech-c0270.appspot.com",
    messagingSenderId: "314757345053",
    appId: "1:314757345053:web:2d8c07ac6df85572897bf4",
    measurementId: "G-K0W6XSDX8W"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});