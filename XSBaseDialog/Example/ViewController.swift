//
//  ViewController.swift
//  ProjectKit
//
//  Created by ZB-YF-HXS on 2021/3/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbMain: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tbMain.dataSource = self
        tbMain.delegate = self
        tbMain.tableFooterView = UIView.init()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell.init()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Toast弹窗"
            break
        case 1:
            cell.textLabel?.text = "Loadding"
            break
        default:
            cell.textLabel?.text = ""
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            gotoToast()
            break
        case 1:
            gotoLoadding()
            break
        default:
            break
        }
    }
}

extension ViewController {
    
    func gotoToast() {
        let vc:ToastExampleViewController = ToastExampleViewController.init()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoLoadding() {
        let vc:LoaddingExampleViewController = LoaddingExampleViewController.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}
