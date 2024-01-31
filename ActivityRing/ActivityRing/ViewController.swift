//
//  ViewController.swift
//  ActivityRing
//
//  Created by Sagar Sahu on 1/31/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ringView: UIView!
    var ringsView: MultipleActivityRingsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRingsView()
    }
    
    func setupRingsView() {
        // Check if ringsView already exists and remove it to avoid duplicate views
        ringsView?.removeFromSuperview()
        
        // Define the data for the rings
        let ringData = [
            ActivityRing(color: UIColor.red.withAlphaComponent(0.3), gradientColor: UIColor.red, progress: 0.6),
            ActivityRing(color: UIColor.blue.withAlphaComponent(0.3), gradientColor: UIColor.blue, progress: 0.75),
            ActivityRing(color: UIColor.magenta.withAlphaComponent(0.3), gradientColor: UIColor.magenta, progress: 0.9)
        ]
        
        // Initialize the rings view with the frame of the progressView
        let frame = ringView.bounds
        ringsView = MultipleActivityRingsView(frame: frame, rings: ringData, ringWidth: 16)
        
        if let ringsView = ringsView {
            ringsView.translatesAutoresizingMaskIntoConstraints = false
            ringView.addSubview(ringsView)
            
            // Add constraints to make the ringsView fill the progressView
            NSLayoutConstraint.activate([
                ringsView.topAnchor.constraint(equalTo: ringView.topAnchor),
                ringsView.bottomAnchor.constraint(equalTo: ringView.bottomAnchor),
                ringsView.leadingAnchor.constraint(equalTo: ringView.leadingAnchor),
                ringsView.trailingAnchor.constraint(equalTo: ringView.trailingAnchor)
            ])
        }
        
    }
    
}
