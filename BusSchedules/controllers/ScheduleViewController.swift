//
//  ToMoscowViewController.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 30/07/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, PathViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nothingFoundLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var appState: AppState?
    
    var schedule: ScheduleBetweenStations?
    
    var serviceCalls = [ServiceCall]()
    
    var pathViewController: PathViewController?
    
    private enum State {
        case idle
        case nothingFound
        case loading
        case showingData
    }
    
    private var state: State = .idle {
        didSet {
            tableView.isHidden = state != .showingData
            activityIndicator.isHidden = state != .loading
            nothingFoundLabel.isHidden = state != .nothingFound
            if state == .loading {
                activityIndicator.startAnimating()
            } else if activityIndicator.isAnimating {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        
        pathViewController = storyboard?.instantiateViewController(withIdentifier: "pathViewController") as? PathViewController
        pathViewController?.appState = appState
        pathViewController?.delegate = self
        addChild(pathViewController!)
        
        view.addSubview(pathViewController!.view)
        
        state = .idle
    }
    
    override func viewWillLayoutSubviews() {
         pathViewController?.view?.translatesAutoresizingMaskIntoConstraints = false
        
        pathViewController?.view?.topAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        pathViewController?.view?.leftAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        pathViewController?.view?.rightAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        
        pathViewController?.view?.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
        
        super.viewWillLayoutSubviews()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        loadSchedule()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for serviceCall in serviceCalls {
            serviceCall.cancel()
        }
        super.viewWillDisappear(animated)
    }
    
    func inversed() {
        schedule = nil
        tableView.reloadData()
        loadSchedule()
    }
    
    func loadSchedule() {
        
        guard appState?.fromStation != nil && appState?.toStation != nil else {
            return
        }
       
        state = .loading
       
        let serviceCall = RaspService.shared.scheduleBetweenStations(appState!.fromStation!, appState!.toStation!) { result in
            
            guard result.isSuccess == true else { return }

            self.schedule = result.schedule
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if result.schedule?.pagination.total == 0 {
                    self.state = .nothingFound
                } else {
                    self.state = .showingData
                }
            }
        }
        
        serviceCalls.append(serviceCall)
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ScheduleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return schedule?.interval_segments.count ?? 0
        } else {
            return schedule?.segments.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "intervalSegmentCell", for: indexPath) as! IntervalSegmentTableViewCell
            if let segment = schedule?.interval_segments[indexPath.row] {
                let model = IntevalSegmentViewModel(segment: segment)
                cell.fill(model: model)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "segmentCell", for: indexPath) as! SegmentTableViewCell
            if let segment = schedule?.segments[indexPath.row] {
                let model = SegmentViewModel(segment: segment)
                cell.fill(model: model)
            }
            return cell
        }
    }
}
