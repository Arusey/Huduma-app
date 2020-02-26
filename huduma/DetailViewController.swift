//
//  DetailViewController.swift
//  huduma
//
//  Created by macbook on 20/03/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblDeptEmail: UILabel!
    @IBOutlet weak var lblDeptPhone: UILabel!
    @IBOutlet weak var lblDeptService: UILabel!
    @IBOutlet weak var lblDeptName: UILabel!
    @IBOutlet weak var lblDeptImage: UIImageView!
    
    
    var department: Department?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDeptName.text = "\((department?.name)!)"
        lblDeptEmail.text = "\((department?.email)!)"
        lblDeptService.text = "\((department?.service)!)"
        lblDeptPhone.text = "\((department?.phoneNumber)!)"
//        lblDeptImage.image = "\((department?.image))"
        
        
    
    }


}
