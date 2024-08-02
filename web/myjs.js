var firebaseConfig = {
    apiKey: "AIzaSyDD4fyBjXnKohSDE2xDHLhePuelc6z_MX4",
    authDomain: "nathanfintech-c0270.firebaseapp.com",
    projectId: "nathanfintech-c0270",
    storageBucket: "nathanfintech-c0270.appspot.com",
    messagingSenderId: "314757345053",
    appId: "1:314757345053:web:2d8c07ac6df85572897bf4",
    measurementId: "G-K0W6XSDX8W"
  };
  
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();
  
  var messaging = firebase.messaging()
  
  messaging.usePublicVapidKey('Your Key');
  
  messaging.getToken().then((currentToken) => {
      console.log(currentToken)
  })