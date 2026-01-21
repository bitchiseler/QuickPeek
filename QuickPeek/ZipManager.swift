//
//  ZipManager.swift
//  QuickPeek
//
//  Created by 경민기 on 12/12/25.
//

import Foundation
import Combine
import ZIPFoundation

class ZipManager: ObservableObject {
    @Published var imagesInZip: [String] = []
    @Published var currentZipPath: String?
    
    private let supportedImageExtensions = ["jpg", "jpeg", "png", "gif", "bmp", "webp"]
    
    func loadZipFile(at path: String) -> [String] {
        currentZipPath = path
        imagesInZip = []
        
        // 이전 임시 파일 정리
        cleanupTempFiles()
        
        // 임시 디렉토리 생성
        let tempDir = NSTemporaryDirectory()
        let uniqueId = UUID().uuidString
        let extractPath = "\(tempDir)/QuickPeek_\(uniqueId)"
        
        do {
            try FileManager.default.createDirectory(atPath: extractPath, withIntermediateDirectories: true, attributes: nil)
            
            // ZIPFoundation을 사용하여 압축 해제
            let zipURL = URL(fileURLWithPath: path)
            let extractURL = URL(fileURLWithPath: extractPath, isDirectory: true)
            
            if let archive = Archive(url: zipURL, accessMode: .read) {
                for entry in archive {
                    // 디렉토리는 건너뛰고 파일만 처리
                    if entry.type == .directory { continue }
                    let destinationURL = extractURL.appendingPathComponent(entry.path)
                    // 상위 디렉토리 생성
                    try FileManager.default.createDirectory(at: destinationURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
                    do {
                        try archive.extract(entry, to: destinationURL)
                    } catch {
                        // 개별 파일 추출 실패는 무시하고 다음으로 진행
                        print("⚠️ 항목 추출 실패: \(entry.path) - \(error.localizedDescription)")
                    }
                }
                
                // 추출된 파일 중 이미지 파일들 찾기
                if let enumerator = FileManager.default.enumerator(atPath: extractPath) {
                    for case let file as String in enumerator {
                        let fileExtension = (file as NSString).pathExtension.lowercased()
                        if supportedImageExtensions.contains(fileExtension) && fileExtension != "pdf" {
                            imagesInZip.append("\(extractPath)/\(file)")
                        }
                    }
                }
            } else {
                print("⚠️ ZIP 파일 열기 실패: \(path)")
            }
            
            // 이미지 파일들 정렬
            imagesInZip.sort()
            
        } catch {
            print("⚠️ ZIP 파일 처리 오류: \(error.localizedDescription)")
        }
        
        return imagesInZip
    }
    
    func cleanupTempFiles() {
        guard currentZipPath != nil else { return }
        
        let tempDir = NSTemporaryDirectory()
        if let enumerator = FileManager.default.enumerator(atPath: tempDir) {
            for case let directory as String in enumerator {
                if directory.hasPrefix("QuickPeek_") {
                    let fullPath = "\(tempDir)/\(directory)"
                    do {
                        try FileManager.default.removeItem(atPath: fullPath)
                    } catch {
                        print("⚠️ 임시 파일 삭제 오류: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    deinit {
        cleanupTempFiles()
    }
}
