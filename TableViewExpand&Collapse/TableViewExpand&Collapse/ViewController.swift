//
//  ViewController.swift
//  TableViewExpand&Collapse
//
//  Created by Srans022019 on 25/04/20.
//  Copyright © 2020 vikas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
   
    let tableViewData = [["Mom", "Dad", "Younger", "elder", "aged", "middle"],
                         ["Mom", "Dad", "Younger", "elder", "aged", "middle"],
                         ["Mom", "Dad", "Younger", "elder", "aged", "middle"],
                         ["Mom", "Dad", "Younger", "elder", "aged", "middle"],
                         ["Mom", "Dad", "Younger", "elder", "aged", "middle"]
    ]
    
    var hiddenSection = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if hiddenSection.contains(section) {
            return 0
        }
        return tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableViewData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionButton = UIButton()
        sectionButton.setTitle(String(section), for: .normal)
        sectionButton.backgroundColor = .blue
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(hideSection(sender:)), for: .touchUpInside)
        return sectionButton
        
    }
    
    
    @objc private func hideSection(sender: UIButton) {
        
        //create section
        let section = sender.tag
        
        //Adding indexpath for sections
        func indexPathForSection() -> [IndexPath] {
            
            var indexPaths = [IndexPath]()
            
            for row in 0..<tableViewData[section].count {
                
                indexPaths.append(IndexPath(row: row, section: section))
            }
            
            return indexPaths
        }
        
        //Logic for hiding and unhiding section elements
        
        if hiddenSection.contains(section) {
        //Takes the hidden count and expands the cell.
            hiddenSection.remove(section)
            table.insertRows(at: indexPathForSection(), with: .fade)
           
        }else{
        
        //This wil hide the cell from section.
            hiddenSection.insert(section)
            table.deleteRows(at: indexPathForSection(), with: .fade)
            
        }
        
        
        
    }
    
    
}
