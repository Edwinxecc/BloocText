import SwiftUI

@main
struct BlocDeNotasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandMenu("Archivo") {
                Button("Nuevo") {
                    NotificationCenter.default.post(name: NSNotification.Name("NuevoArchivo"), object: nil)
                }
                .keyboardShortcut("n", modifiers: .command)
                
                Button("Guardar") {
                    NotificationCenter.default.post(name: NSNotification.Name("GuardarArchivo"), object: nil)
                }
                .keyboardShortcut("s", modifiers: .command)
            }
        }
    }
}
