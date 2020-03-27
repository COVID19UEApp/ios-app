//
//  TransfersViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 24.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit
import OverlayContainer

class TransfersViewController: UIViewController {
    
    @IBOutlet weak var overlayContainerView: UIView!
    let overlayController = OverlayContainerViewController(style: .flexibleHeight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let mapViewController = viewController(withID: "MapViewController", from: "Vendor") as? MapViewController,
            let menuVC = viewController(withID: "TransfersMenuViewController", from: "Vendor") as? TransfersMenuViewController else { return }
        overlayController.delegate = self
        overlayController.viewControllers = [menuVC]
        addChild(overlayController, in: view)
        addChild(mapViewController, in: overlayContainerView)
        
        menuVC.showOnMap = { transfers in
            mapViewController.showOnMap(transfers)
        }
//        menuVC.shouldSegueToJobSummary = { job in
//            self.performSegue(withIdentifier: "Main_to_JobSummary", sender: job)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
//        if
//            let nav = segue.destination as? UINavigationController,
//            let dest = nav.viewControllers.first as? JobSummaryViewController,
//            let job = sender as? Job {
//            dest.job = job
//        }
    }
}

extension TransfersViewController: OverlayContainerViewControllerDelegate {
    enum OverlayNotch: Int, CaseIterable {
        case minimum, maximum
    }
    
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        switch OverlayNotch.allCases[index] {
        case .maximum:
            return availableSpace * 0.75
        case .minimum:
            return availableSpace * 0.4
        }
    }
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        OverlayNotch.allCases.count
    }
}
