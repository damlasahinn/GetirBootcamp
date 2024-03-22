#!/usr/bin/env swift
import Foundation
var users = ["Damla","Ecem","Sinem","Zehra", "Kaan", "Ayşe"]

for i in 0..<users.count {
  users[i] = users[i].uppercased()
}

let sortedUsers = users.sorted(by: >)

print(sortedUsers)

