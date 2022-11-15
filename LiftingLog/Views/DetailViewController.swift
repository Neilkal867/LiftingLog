//
//  DetailViewController.swift
//  Project7
//
//  Created by Joseph Melito on 10/7/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var workoutItem: Workout?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let workoutItem = workoutItem else {return}
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <table>
          <tr>
            <th>Date</th>
            <th>Workout Type</th>
            <th>Weight</th>
            <th>Sets</th>
            <th>Reps</th>
            <th>Comments</th>
          </tr>
          <tr>
            <td> \(workoutItem.date)</td>
            <td>\(workoutItem.workoutType)</td>
            <td>\(workoutItem.weight)</td>
            <td> \(workoutItem.sets)</td>
            <td>\(workoutItem.reps)</td>
            <td> \(workoutItem.comments)</td>
          </tr>
        </table>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    

}
