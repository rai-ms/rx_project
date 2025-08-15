// Updated firebase-messaging-sw.js
importScripts("https://www.gstatic.com/firebasejs/10.14.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.14.1/firebase-messaging-compat.js");

const firebaseConfig = {
  apiKey: "AIzaSyAGuMr9N5x3z2E51ksqQdaS9iRG_EBLoUk",
  authDomain: "groupchat-e7063.firebaseapp.com",
  projectId: "groupchat-e7063",
  storageBucket: "groupchat-e7063.appspot.com",
  messagingSenderId: "572035052129",
  appId: "1:572035052129:web:297bc6072067b6da67f020"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// Handle background messages
messaging.onBackgroundMessage((payload) => {
  console.log('Received background message', payload);
  const notificationTitle = payload.notification?.title || 'New Message';
  const notificationOptions = {
    body: payload.notification?.body,
    icon: payload.notification?.icon || '/icons/icon-192x192.png'
  };
  return self.registration.showNotification(notificationTitle, notificationOptions);
});