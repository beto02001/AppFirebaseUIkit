//
//  LinkModel.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 27/02/24.
//

import Foundation
import FirebaseFirestore


struct LinkModel: Decodable, Identifiable, Encodable {
    @DocumentID var id: String?
    let url: String
    let title: String
    let isFavorited: Bool
    let isCompleted: Bool
}
