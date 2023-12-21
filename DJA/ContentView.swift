//
//  ContentView.swift
//  DJA
//
//  Created by gio khukhia on 12/21/23.
//
import SwiftUI

struct ContentView: View {
    @State private var newsEntries: [NewsEntry] = []
    @State private var title = ""
    @State private var description = ""
    @State private var selectedDate = Date()
    @State private var isShowingEmptyState = false
    @State private var selectedNewsEntry: NewsEntry?

    var body: some View {
        NavigationView {
            VStack {
                
                        Form {
                            TextField("Title", text: $title)
                            TextEditor(text: $description)
                            DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            
                                .padding()
                            
                            Button("Save News") {
                                saveNews()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                        }
                    
                
                List {
                    ForEach(newsEntries) { entry in
                        NavigationLink(destination: NewsEntryDetailView(newsEntry: entry, onEdit: { editedNews in
                            editNews(editedNews: editedNews, index: newsEntries.firstIndex(of: entry)!)
                        })) {
                            NewsEntryView(entry: entry)
                        }
                    }
                    .onDelete(perform: deleteNews)
                    .onMove(perform: moveNews)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarItems(trailing: EditButton())

                if isShowingEmptyState {
                    Text("No news entries yet.")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("Daily News")
            .onAppear {
                checkEmptyState()
            }
        }
    }

    private func saveNews() {
        let entry = NewsEntry(title: title, description: description, date: selectedDate)
        newsEntries.append(entry)

        title = ""
        description = ""
        selectedDate = Date()

        checkEmptyState()
    }

    private func deleteNews(offsets: IndexSet) {
        newsEntries.remove(atOffsets: offsets)
        checkEmptyState()
    }

    private func moveNews(from source: IndexSet, to destination: Int) {
        newsEntries.move(fromOffsets: source, toOffset: destination)
    }

    private func checkEmptyState() {
        isShowingEmptyState = newsEntries.isEmpty
    }

    private func editNews(editedNews: NewsEntry, index: Int) {
        if index < newsEntries.count {
            newsEntries[index] = editedNews
        }
    }
}

struct NewsEntryDetailView: View {
    @State private var editedNewsEntry: NewsEntry
    let onEdit: (NewsEntry) -> Void

    init(newsEntry: NewsEntry, onEdit: @escaping (NewsEntry) -> Void) {
        _editedNewsEntry = State(initialValue: newsEntry)
        self.onEdit = onEdit
    }

    var body: some View {
        EditNewsView(newsEntry: $editedNewsEntry, onSave: {
            onEdit(editedNewsEntry)
        }, onCancel: {})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
