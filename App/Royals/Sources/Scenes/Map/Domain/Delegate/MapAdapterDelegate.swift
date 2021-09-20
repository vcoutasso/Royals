//
//  MapAdapterDelegate.swift
//  Royals
//
//  Created by Vinícius Couto on 01/09/21.
//

protocol MapAdapterDelegate: AnyObject {
    func willLocateUser()

    func locationTapped(uid: String)
}
