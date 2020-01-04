//
//  FindWorker.swift
//  MainTask
//
//  Created by кирилл корнющенков on 04.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit

class FindWorker: UIViewController {

    var countPeople:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: добавление нового сотрудника
    private func alertAddPeople(){
        let alert = UIAlertController(title: "Введите email/login польователя", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        //добавить проверку на наличие такого пользователя и добавить на сервер и везде крч
        let actionAdd = UIAlertAction(title: "+", style: .default) { [weak alert] (addAlert) in
            print(alert?.textFields?.first?.text!)
        }
        let actionCancel = UIAlertAction(title: "-", style: .default, handler: nil)
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        self.present(alert,animated: true,completion: nil)
    }
    
    @IBAction func addPeopleButton(_ sender: Any) {
        alertAddPeople()
    }
    
}

extension FindWorker: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        //return countPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FindWorkerCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = (collectionView.frame.width - 42) / 3
        return CGSize(width: size, height: size)
    }
}

