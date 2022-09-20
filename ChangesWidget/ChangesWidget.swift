//
//  ChangesWidget.swift
//  ChangesWidget
//
//  Created by aiqin139 on 2022/8/9.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
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
    let date: Date
    let configuration: ConfigurationIntent
}

struct SmallView: View {
    var body: some View {
        VStack {
            HStack {
                DerivedSymbol(id: 20)
                    .frame(width: 50, height: 50, alignment: .center)
                
                VStack {
                    Text("时运")
                    Text("乾卦")
                }
            }
            Text("品行端正，名利自成。")
        }
    }
}

struct MediumView: View {

    var body: some View {
        HStack {
            
            let digitalData = DigitalData()
            
            VStack {
                DerivedSymbol(id: digitalData.id)
                    .frame(width: 100, height: 100, alignment: .center)
            }
            VStack {
                Text("初")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
        }
        .padding()
    }
}

struct LargeView: View {
    var body: some View {
        HStack {
            VStack {
                DerivedSymbol(id: 20)
                    .frame(width: 100, height: 100, alignment: .center)
                Text("哈哈")
            }
            
            VStack {
                Text("测试")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
        }
        .padding()
    }
}

struct ChangesWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    @ViewBuilder
    var body: some View {
        VStack {
            switch widgetFamily {
            case .systemSmall:
                SmallView()
            case .systemMedium:
                MediumView()
            case .systemLarge:
                LargeView()
            default:
                Text(entry.date, style: .time)
            }
        }
    }
}

@main
struct ChangesWidget: Widget {
    let kind: String = "易经"
    
    @Environment(\.widgetFamily) var widgetFamily

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ChangesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("占卦设置")
        .description("逢凶化吉，遇难呈祥")
    }
}

struct ChangesWidget_Previews: PreviewProvider {
    static var previews: some View {
        ChangesWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        ChangesWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        ChangesWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
