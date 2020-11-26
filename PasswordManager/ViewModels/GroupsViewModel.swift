//
//  GroupsViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 13/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class GroupsViewModel {
    var groupsCollection = BehaviorRelay<[GroupDetails]>(value: [GroupDetails]())
    var groupRequests = BehaviorRelay<[GroupRequestDetails]>(value: [GroupRequestDetails]())
    
    
    func createGroup(group: Group) -> Void {
    }
    
    func fetchGroups() {
    }
    
}
