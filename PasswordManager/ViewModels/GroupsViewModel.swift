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
    let groupsApi = GroupsApiService()
    
    
    func createGroup(group: Group) -> Void {
        groupsApi.createGroup(groupDto: group)
    }
    
    func fetchGroups() {
        groupsApi.fetchMyGroups(completion: {
            groups in self.groupsCollection.accept(groups)
        })
    }
    
}
