//
//  ViewController.swift
//  renameForCode
//
//  Created by zyt on 2018/12/24.
//  Copyright © 2018 zsh. All rights reserved.
//

import Cocoa
import FileKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        projectPathField.stringValue = "/Users/apple/Desktop/anhao/anhao.xcodeproj"
        modifyPrefixField.stringValue = "AH_USER_BJ_"
        newPrefixField.stringValue = "LB_"
        extensionArrayField.stringValue = "h,m"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var startButton: NSButton!

    @IBOutlet weak var projectPathField: NSTextField!

    @IBOutlet weak var modifyPrefixField: NSTextField!

    @IBOutlet weak var extensionArrayField: NSTextField!

    @IBOutlet weak var newPrefixField: NSTextField!
    @IBOutlet weak var TimeLabel: NSTextField!
    
    
    var time: TimeInterval = 0

    @IBAction func startChange(_ sender: Any) {

        time = Date().timeIntervalSince1970
        let manager = FileController.shared
/*
        let desktop = "/Users/zyt/Desktop/"

        let dirPath = desktop+"123/412/test/"

        let fileName = "sample.txt"
        let fileName1 = "sample1.txt"

        let filePath = dirPath+"pp.txt"
        let filePath1 = dirPath+"sample.txt"

//        manager.createFile(path: filePath)
//        manager.deleFile(path: filePath)

//        manager.textFile(path: filePath1)
//        manager.changeFileName(dir: dirPath, fileName: fileName, newName: fileName1)
//        manager.replaceTextFile(dir: dirPath, file: fileName1, oldValue: "replace", newValue: "")
*/

        runOnUiThread {
            self.startButton.isEnabled = false
            self.showErrorStatus("正在进行中...")
            self.showTime("正在进行中...")
        }
        

        let projectPathStr = projectPathField.stringValue
        let prefixStr = modifyPrefixField.stringValue
        let pathExtensionsStr = extensionArrayField.stringValue
        let newPrefixStr = newPrefixField.stringValue

        guard !projectPathStr.isEmpty else {
            print("path is empty")
            return
        }
        guard !prefixStr.isEmpty else {
            print("prefix is empty")
            return
        }
        guard !pathExtensionsStr.isEmpty else {
            print("pathExtensin is empty")
            return
        }
        guard !newPrefixStr.isEmpty else {
            print("new prefix is empty")
            return
        }

        manager.resultNoti = {result in
            
            let endtime = Date().timeIntervalSince1970
            let costtime = endtime - self.time
            
            runOnUiThread {
                self.startButton.isEnabled = true
            
            
            
            if result {
                self.showSuccessStatus("更新完成")
            } else {
                self.showErrorStatus("更新失败")
            }
            self.showTime("总花费时间为 \(costtime) ")
            
        }
        }

        manager.start(projectPathStr: projectPathStr, prefixStr: prefixStr, newPrefixStr: newPrefixStr, pathExtensionsStr: pathExtensionsStr)




    }
    
}

extension ViewController {

    
    
}

extension ViewController {

    /**
     Shows the passed error status message
     */
    func showErrorStatus(_ errorMessage: String)
    {
        runOnUiThread {
            self.statusLabel.textColor = NSColor.red
            self.statusLabel.stringValue = errorMessage
        }
    }

    /**
     Shows the passed success status message
     */
    func showSuccessStatus(_ successMessage: String)
    {
        runOnUiThread {
        self.statusLabel.textColor = NSColor.green
        self.statusLabel.stringValue = successMessage
        }
    }
    
    func showTime(_ time: String) {
        
        runOnUiThread {
            self.TimeLabel.textColor = NSColor.black
            self.TimeLabel.stringValue = time
        }
    }
}





