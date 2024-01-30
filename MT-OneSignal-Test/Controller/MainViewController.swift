//
//  MainViewController.swift
//  MT-OneSignal-Test
//
//  Created by Matthew Tripodi on 1/27/24.
//

import UIKit
import OneSignalFramework
import ActivityKit

class MainViewController: UIViewController {
    
    @IBOutlet var featuresTableView: UITableView!
    var featureList: [String] = [String]()
    
    // Get the User's push subscription status
    var optedInPush: Bool = OneSignal.User.pushSubscription.optedIn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the tableView with the avaliable features
        featuresTableView.delegate = self
        featuresTableView.dataSource = self
        loadFeatures()
        
        // Do any additional setup after loading the view.
    }
    
    func loadFeatures() {
        featureList.append("Logout")
        featureList.append("Get Push Subscription Status")
        featureList.append("Enable Push Notifications")
        featureList.append("Disable Push Notifications")
        featureList.append("Prompt Push Permission")
        featureList.append("Present In-App Message")
        featureList.append("Start Live Activity")
        featureList.append("End Live Activity")
        self.featuresTableView.reloadData()
    }
    
}

// MARK: - TableView Extension
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.featureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath) as! FeatureTableViewCell
        cell.featureLabel?.text = self.featureList[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)")
        
        switch(indexPath.row) {
        case 0:
            logout()
            break;
        case 1:
            getPushSubscriptionStatus()
            break;
        case 2:
            enablePushNotifications()
            break;
        case 3:
            disablePushNotifications()
            break;
        case 4:
            promptPushPermission()
            break;
        case 5:
            presentInAppMessage()
            break;
        case 6:
            startLiveActivity()
            break;
        case 7:
            endLiveActivity()
        default:
            break;
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - OneSignal Features
    func logout() {
        print("Logged Out")
        /*
         Log out the user previously logged in via the login method. This disassociates all user properties like the external_id, other custom aliases, and properties like tags. A new onesignal_id is associate with the device which now references a new anonymous user. An anonymous user has no user identity that can later be retrieved, except through this device, as long as the app remains installed and the app data is not cleared.
         
         The OneSignal.logout method will remove the External ID and set a new OneSignal ID on the current Push Subscription ID. This disassociates all aliases, tags, and all other data from the Push Subscription, effectively making it belong to a new anonymous user.
         
         It is only recommended to call this method if you do not want to send transactional push notifications to this device upon logout. For example, if your app sends targeted or personalized messages to users based on their aliases and its expected that upon logout, that device should not get those types of messages anymore, then it is a good idea to call OneSignal.logout.
         
         This does not stop the subscription from receiving all push notifications, only targeted transactional messages based on the alias. You can disable push notifications to the subscription using the optOut() SDK methods:
         */
        OneSignal.logout()
        let alert = UIAlertController(title: "You have successfully logged out", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    func getPushSubscriptionStatus() {
        let alert = UIAlertController(title: "Push Subscription Status", message: "Opted in = \(optedInPush)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func enablePushNotifications() {
        print("Enabled Push Notification")
        /*
         optIn() will display the native push notification permission prompt if the push subscription has never been asked for permission before. If the push subscription has already been prompted and the app’s settings has notification permission disabled, a native prompt will appear directing the user to the settings app to change the notification permission
         */
        OneSignal.User.pushSubscription.optIn()
        optedInPush.toggle() // Update the users push status
        let alert = UIAlertController(title: "Push Subscription has been enabled", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func disablePushNotifications() {
        print("Disabled Push Notifications")
        /*
         Changes the subscription status of an opted-in push subscription to opted-out. The push subscription cannot get push notifications anymore until optIn() is called or use Update subscription API with enabled: true.
         
         This method does not remove or invalidate push tokens. It is designed for sites that wish to have more granular control of which users receive notifications, such as when implementing notification preference pages.
         
         The user's push subscription can only be opted-out if OneSignal.Notifications.permission is true.
         */
        OneSignal.User.pushSubscription.optOut()
        optedInPush.toggle() // Update the users push status
        let alert = UIAlertController(title: "Push Subscription has been disabled", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func promptPushPermission() {
        print("Prompt Push Permission")
        
        // Present an In-App message push permission prompt encouraging to allow push notifications
        // This will be shown before the Native iOS push prompt
        // With the free OneSignal Account, you can only have 1 active In-app message, leaving the native iOS push prompt to display here rather than the In-App push prompt
        // This way the presentInAppMessage function can display an in-app message
        OneSignal.InAppMessages.addTrigger("show_push_permission_prompt", withValue: "1")
        
        // *Don't need the code below if the In-App message push permission prompt is being used
        // requestPermission will the native iOS notification permission prompt
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: true)
        optedInPush.toggle() // Update the users push status
    }
    
    func presentInAppMessage() {
        print("Present In App Message")
        // Trigger an In-App message when this tableView cell is tapped
        OneSignal.InAppMessages.addTrigger("presentInApp", withValue: "true")
    }
    
    func startLiveActivity() {
        print("Started Live Activity")
        
        let attributes = OneSignalWidgetAttributes(name: "Italy vs. Germany", homeTeam: "Italy", awayTeam: "Germany", fifaLogo: "fifa_logo", sponsorLogo: "cocacola_logo")
        let contentState = OneSignalWidgetAttributes.ContentState(homeScore: 7, awayScore: 1)
        let activityContent = ActivityContent(state: contentState, staleDate: Calendar.current.date(byAdding: .minute, value: 30, to: Date())!)
        do {
            let activity = try Activity<OneSignalWidgetAttributes>.request(
                attributes: attributes,
                content: activityContent,
                pushType: .token)
            
            Task {
                for await data in activity.pushTokenUpdates {
                    let token = data.map {String(format: "%02x", $0)}.joined()
                    print("Live Activity Push Token: ", token)
                    // ... required code for entering a live activity
                    OneSignal.LiveActivities.enter(Keys.activityId, withToken: token)
                }
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func endLiveActivity() {
        print("Ended Live Activity")
        OneSignal.LiveActivities.exit(Keys.activityId)
        let alert = UIAlertController(title: "The Live Activity has been ended", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
