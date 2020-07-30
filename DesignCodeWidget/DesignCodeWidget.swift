//
//  DesignCodeWidget.swift
//  DesignCodeWidget
//
//  Created by Prudhvi Gadiraju on 7/30/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct DesignCodeWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        if family == .systemSmall {
            DesignCodeWidgetSmall()
        } else {
            DesignCodeWidgetMedium()

        }
    }
}

struct DesignCodeWidgetSmall: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            Text("Matched Geometry Effect")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("Learn how to quickly transition different views")
                .font(.footnote)
                .foregroundColor(.secondary)
        }.padding(12)
    }
}

struct DesignCodeWidgetMedium: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            CourseRow()
        }.padding(12)
    }
}

@main
struct DesignCodeWidget: Widget {
    private let kind: String = "DesignCodeWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            DesignCodeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("DesignCode")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct DesignCodeWidget_Previews: PreviewProvider {
    static var previews: some View {
        DesignCodeWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
