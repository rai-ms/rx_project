// Updated firebase-messaging-sw.js
importScripts("https://www.gstatic.com/firebasejs/10.14.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.14.1/firebase-messaging-compat.js");

const firebaseConfig = {
  apiKey: "AIzaSyDNnvog2bRuG8uoQh6YzJlTmQ4AOS5MFC8",
  authDomain: "rx-project-75f17.firebaseapp.com",
  projectId: "rx-project-75f17",
  storageBucket: "rx-project-75f17.firebasestorage.app",
  messagingSenderId: "774746305982",
  appId: "1:774746305982:web:a6cf87b41431215fa4b5ef",
  measurementId: "G-89CY3XF7HT"
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