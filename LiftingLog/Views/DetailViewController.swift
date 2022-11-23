//
//  DetailViewController.swift
//  Project7
//
//  Created by Joseph Melito on 10/7/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var webView: WKWebView!
    var workoutItem: Workout?
    @IBOutlet var tableView: UITableView!
    
    
    
    
//    override func loadView() {
//        webView = WKWebView()
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
//        guard let workoutItem = workoutItem else {return}
//
//        let html = """
//        <html>
//        <head>
//        <meta name="viewport" content="width=device-width, initial-scale=1">
//        <style> body { font-size: 150%; } </style>
//        </head>
//        <body>
//        <table>
//          <tr>
//            <th>Date</th>
//            <th>Workout Type</th>
//            <th>Weight</th>
//            <th>Sets</th>
//            <th>Reps</th>
//            <th>Comments</th>
//          </tr>
//          <tr>
//            <td> \(workoutItem.date)</td>
//            <td>\(workoutItem.workoutType)</td>
//            <td>\(workoutItem.weight)</td>
//            <td> \(workoutItem.sets)</td>
//            <td>\(workoutItem.reps)</td>
//            <td> \(workoutItem.comments)</td>
//          </tr>
//        </table>
//        </body>
//        </html>
//        """
//        webView.loadHTMLString(html, baseURL: nil)
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.workoutTypeTF.text = workoutItem?.workoutType
            cell.weightTF.text = "\(workoutItem?.weight ?? 00)"
            cell.repsTF.text = "\(workoutItem?.reps ?? 00)"
            cell.setsTF.text = "\(workoutItem?.sets ?? 00)"
            cell.commentsTF.text = workoutItem?.comments
        return cell
    }
}
