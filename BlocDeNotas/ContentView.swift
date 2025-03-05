import SwiftUI
import AppKit

struct ContentView: View {
    @State private var noteText: String = "" // Contenido de la nota
    
    var body: some View {
        VStack {
            // Área de texto donde se escribe la nota
            TextEditor(text: $noteText)
                .frame(minWidth: 400, minHeight: 300)
                .font(.body)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NuevoArchivo"))) { _ in
            noteText = ""
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GuardarArchivo"))) { _ in
            saveToFile(noteText)
        }
    }
    
    func saveToFile(_ text: String) {
        DispatchQueue.main.async {
            let panel = NSSavePanel()
            panel.allowedContentTypes = [.plainText]
            panel.nameFieldStringValue = "Nueva Nota.txt"

            if panel.runModal() == .OK, let url = panel.url {
                do {
                    try text.write(to: url, atomically: true, encoding: .utf8)
                } catch {
                    print("Error al guardar el archivo: \(error.localizedDescription)")
                }
            }
        }
    }
}
