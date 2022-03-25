//
//  satudentMarks.swift
//
//  Created by Liam Csiffary
//  Created on 2022-03-24
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
// The student marks program Generates 2D 
// arrays populates with student names and 
// their corresponding
// marks (50-100% range)

import Foundation

// populates the array of arrays with the names
// and marks of the students
func StudentMarks(
      arrayStudents: [String], arrayAssign: [String]) -> [[String]] {

  // create return array
  var finalArr: [[String]] = [[]]

  // for each student
  for (student) in arrayStudents {
    var tempArray: [String] = []
    
    // put their name at the front of the inner array
    tempArray.append(student)

    // _ because the var was never used
    for (_) in arrayAssign {
      // adds the mark to the array
      tempArray.append(String(Int.random(in: 50..<100)))
    }

    // adds the created temp array to the final array
    finalArr.append(tempArray)
  }

  // returns the completed array
  return finalArr
}


// reads the txt file
// code from
// https://forums.swift.org/t/read-text-file-line-by-line/28852/4
func readFile(_ path: String) -> [String] {
  var arrayOfStrings: [String] = []
  errno = 0
  if freopen(path, "r", stdin) == nil {
    perror(path)
    return []
  }
  while let line = readLine() {
    arrayOfStrings.append(String(line))
    //do something with lines..
  }
  return arrayOfStrings
}

func writeTxt(from recArray:[[String]]) {

  // turns the contents of the array into a string
  var str = ""
  for student in recArray {
    for mark in student {
      str += mark + ", "
    }
    str += "\n"
  }

  // https://stackoverflow.com/questions/55870174/how-to-create-a-csv-file-using-swift
  let filePath = NSHomeDirectory() + "/Unit1-07-Swift/studentMarks.txt"
  if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)) {
    print("File created successfully.")
  } else {
    print("File not created.")
  }

  // https://stackoverflow.com/questions/24410473/how-to-convert-this-var-string-to-url-in-swift
  let filename = URL(fileURLWithPath: filePath)
  print(filename)

  // https://www.hackingwithswift.com/example-code/strings/how-to-save-a-string-to-a-file-on-disk-with-writeto
  do {
    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
  } catch {
    // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    print("failed")
  }
  
}


func main() {
  // gets the arrays from the txt files
  var file = "students.txt"
  let arrayOfStudents: [String] = readFile(file)
  file = "assignments.txt"
  let arrayOfAssigns: [String] = readFile(file)

  // passes the arrays and gets the final completed array back
  let finalArray = StudentMarks(arrayStudents: arrayOfStudents, arrayAssign: arrayOfAssigns)

  // writes it all to a txt file
  writeTxt(from: finalArray)
}

// starts the program
main()
