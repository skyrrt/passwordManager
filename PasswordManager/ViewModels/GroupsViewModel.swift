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
    let groupRequestsApi = GroupRequestsApiService()
    
    
    func createGroup(group: Group, completion: @escaping () -> Void) -> Void {
        groupsApi.createGroup(groupDto: group) {
            completion()
        }
    }
    
    func fetchGroups() {
        groupsApi.fetchMyGroups(completion: {
            groups in self.groupsCollection.accept(groups)
        })
    }
    
    func leaveGroup(groupId: String, completion: @escaping () -> Void) {
        groupsApi.leaveGroup(groupId: groupId) {
            completion()
        }
    }
    
    func answerRequest(requestId: String, accepted: Bool, completion: @escaping () -> Void) {
        groupRequestsApi.answerRequest(requestId: requestId, answer: accepted, completion: completion)
    }
    
    func fetchGroupRequests() {
        groupRequestsApi.fetchRequests(completion: {
            groupRequests in self.groupRequests.accept(groupRequests)
        })
    }
    
    func sendRequest(request: GroupRequestDto) {
        groupRequestsApi.sendRequest(requestDto: request)
    }
    
}
