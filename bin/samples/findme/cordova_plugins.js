cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/org.apache.cordova.dialogs/www/notification.js",
        "id": "org.apache.cordova.dialogs.notification",
        "merges": [
            "navigator.notification"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.dialogs/www/android/notification.js",
        "id": "org.apache.cordova.dialogs.notification_android",
        "merges": [
            "navigator.notification"
        ]
    },
    {
        "file": "plugins/org.bcsphere.bleprofiles/www/findme.js",
        "id": "org.bcsphere.bleprofiles.findme",
        "merges": [
            "BC.Findme"
        ]
    },
    {
        "file": "plugins/org.bcsphere.bleprofiles/www/proximity.js",
        "id": "org.bcsphere.bleprofiles.proximity",
        "merges": [
            "BC.Proximity"
        ]
    },
    {
        "file": "plugins/org.bcsphere.bleprofiles/www/serialport.js",
        "id": "org.bcsphere.bleprofiles.serialport",
        "merges": [
            "BC.SerialPort"
        ]
    },
    {
        "file": "plugins/org.bcsphere.bluetooth/www/bluetooth.js",
        "id": "org.bcsphere.bluetooth.bluetooth",
        "merges": [
            "navigator.bluetooth"
        ]
    }
];
module.exports.metadata = 
{
    "org.apache.cordova.dialogs": "0.2.6",
    "org.bcsphere.bleprofiles": "0.1.0",
    "org.bcsphere.bluetooth": "0.4.0"
}
});