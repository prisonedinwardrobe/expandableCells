//
//  ViewController.swift
//  ExpandableSections
//
//  Created by leonid on 21/03/2019.
//  Copyright © 2019 LLU. All rights reserved.
//

import UIKit

//Класс хранящий секции
class Section {
    var isExpanded: Bool = true //раскрыта секция или нет
    var name: String
    var array: [String]         //модели, которые в ячейки передаются
    
    init(name: String, array: [String]) {
        self.name = name
        self.array = array
    }
}

class ViewController: UIViewController {
    
    private static let cellId = "zhopa"

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: SectionHeader.reuseIdentifier)
        }
    }
    
    private lazy var sections: [Section] = {
        let array = ["one", "two", "three"]
        return [
            Section(name: "ONE", array: array),
            Section(name: "TWO", array: array),
            Section(name: "THREE", array: array),
            Section(name: "FOUR", array: array)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //если секция раскрыта - возвращаем количество моделей секции, если не раскрыта, то 0
        return sections[section].isExpanded ? sections[section].array.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //тут забей ниче нет
        let cell = UITableViewCell(style: .default, reuseIdentifier: ViewController.cellId)
        cell.textLabel?.text = sections[indexPath.section].array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.reuseIdentifier) as! SectionHeader
        header.textLabel?.text = sections[section].name
        //передаю в хедер блок, который будет выполняться по нажатию (смотри класс хедера дальше)
        header.onTap = { [weak self] in
            guard let self = self else { return }
            self.sections[section].isExpanded.toggle()
            self.tableView.reloadSections(IndexSet(arrayLiteral: section), with: .fade)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

