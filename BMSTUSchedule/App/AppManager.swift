//
//  ScheduleManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 20/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Firebase
import RealmSwift

class AppManager {
    
    static let shared = AppManager()
    
    // MARK: Services
    let notificationsService = NotificationsService()
    
    func configureOnLaunching() {
        
        // Configure firebase
        FirebaseApp.configure()
        
        // Configure notifications
        notificationsService.registerForRemoteNotifications()
    }
    
    // MARK: -
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Keys
    
    private let currentGroupKey = "currentGroup"
    private let offlineModeKey = "offlineMode"
    
    // MARK: - Identifiers
    
    /// Current group
    var currentGroup: Group? {
        get {
            let groupName = defaults.string(forKey: currentGroupKey)
            
            if let newGroupName = groupName {
               return Group(name: newGroupName)
            } else {
                return nil
            }
        }
        
        set(new) {
            if let groupName = new?.name {
                defaults.set(groupName, forKey: currentGroupKey)
            }
        }
    }
    
    /// Unique user identifier
    var userIdentifier: String? {
        get {
            if let identifier = UIDevice.current.identifierForVendor?.uuidString {
                return "user(\(identifier))"
            } else {
                return nil
            }
        }
    }
    
    /// Offline mode flag
    var offlineMode: Bool {
        get {
            let mode = defaults.bool(forKey: offlineModeKey)
            return mode
        }
        set(new) {
            defaults.set(new, forKey: offlineModeKey)
        }
    }
    
    // MARK: - Schedule
    
    func getEvents() -> [Event] {
        
        let realm = try! Realm()
        
        let realmEvents = realm.objects(RealmEvent.self).sorted(byKeyPath: "date")
        if realmEvents.isEmpty {
            
            print("Save test events")
            
            try! realm.write {
                for event in testEvents {
                    realm.add(RealmEvent(event))
                }
            }
        }
        
        var events: [Event] = []
        for realmEvent in realmEvents {
            events.append(Event(realmEvent))
        }

        return events
    }
    
    fileprivate var testEvents: [Event] {
        
        // Teachers
    
        let teacherTerehov = Teacher(firstName: "Валерий",
                                     lastName: "Терехов",
                                     middleName: "Игоревич",
                                     department: "ИУ5",
                                     position: "Преподаватель",
                                     degree: "Доцент",
                                     photoURL: URL(string: "http://iu5.bmstu.ru/pluginfile.php/436/user/icon/boost/f1?rev=1"),
                                     about:
"""
Терехов Валерий Игоревич родился в 1962 году в Ташкенте.

В 1984 г. окончил факультет многоканальной электросвязи Московского электротехнического институт связи, по специальности инженер электросвязи.
В 1995 г. механико-математический факультет Московского государственного университета по специальности прикладная математика.
В 1998 г. факультет повышения квалификации научно–педагогических кадров Московского государственного университета.
В 1999 г. командный факультет Военно-инженерной академии.
В 2010 г. факультет повышения квалификации Военного учебно-научного центра «Общевойсковой академии ВС РФ».
            
Кандидат технических наук (2005 г.), доцент (2006 г.).
            
Научный стаж (2017 год) – 19 лет, педагогический – 19 лет.
        
Автор 112 работ (в том числе 85 опубликованные статьи и 27 учебно-методических работ) и 5 монографий. ")
""")
        
        let teacherNesterov = Teacher(firstName: "Юрий",
                                      lastName: "Нестеров",
                                      middleName: "Григорьевич",
                                      department: "ИУ5",
                                      position: "Преподаватель",
                                      degree: "Доцент",
                                      photoURL: URL(string: "http://iu5.bmstu.ru/pluginfile.php/404/user/icon/boost/f1?rev=8777"),
                                      about:
"""
1976 - окончил с отличием МВТУ им.Баумана, каф.П-6 (ЭВМ),
1984 - степень КТН,
1990 - звание снс, более 50 научных трудов, в т.ч. монография "Выбор состава программно-технического комплекса САПР" М:Высшая школа, 1990 (совместно с Папшевым И.С.),
с 1994 по 2012 работал в финансовом секторе в роли CIO.
        
Ведет следующие дисциплины:
    * ИУ5 - Архитектура КИС, ИТ-менеджмент, Элементы управления в АСОИУ, Управление проектированием ИС, СГН3- Вычислительные системы, сети и телекоммуникации, Имитационное моделирование,
    * ИБМ6- Распределенные системы, Вычислительные системы, сети и телекоммуникации, Теоретические основы информатики: имитационное моделирование,
    * ВИУ5(2-е высшее)- Теория принятия решений, Моделирование, Глобальные сети, Юриспруденция(компьютерная экспертиза) - Проектирование АСОИУ, Надежность АСОИУ, Моделирование систем,
    * ВИБМ5(2-е высшее) - Состояние и перспективы развития автоматизированных банковских систем.
""")
        
        let teacherMyushenkov = Teacher(firstName: "Константин",
                                        lastName: "Мышенков",
                                        middleName: "Сергеевич",
                                        department: "ИУ5",
                                        position: "Преподаватель",
                                        degree: "Профессор",
                                        photoURL: URL(string: "http://iu5.bmstu.ru/pluginfile.php/1282/user/icon/boost/f1?rev=9165"),
                                        about:
"""
Окончил в 1980 г. Московский технологический институт пищевой промышленности по специальности «Автоматизация и комплексная механизация химико-технологических процессов».

В период с 1980 г. по 2010 г. работал в Московском государственном университете пищевых производств (МГУПП, ранее МТИПП): младшим, старшим, ведущим научным сотрудником, доцентом, профессором, заведующим кафедрой «Автоматизированные системы и вычислительная техника», директором Института информационных технологий и управления.

В 1988 г. защитил кандидатскую диссертацию по специальности 05.13.07 «Автоматизация технологических процессов и производств». В 2005 г. защитил докторскую диссертацию по специальности 05.13.06 «Автоматизация и управление технологическими процессами и производствами».

С 2010 г. по 2016 г. работал зам. директора, директором центра  информатизации университета, профессором кафедры информационных систем МГТУ «СТАНКИН».

С 2016 г. - профессор кафедры ИУ5 «Системы обработки информации и управления» МГТУ им. Н.Э. Баумана.
""")
        
        let teacherChernenkiy = Teacher(firstName: "Михаил",
                                        lastName: "Черненький",
                                        middleName: "Валерьевич",
                                        department: "ИУ5",
                                        position: "Преподаватель",
                                        degree: "Доцент",
                                        photoURL: nil,
                                        about:
"""
Родился в Москве в 0x7AC. Окончил МВТУ им.Н.Э.Баумана в 1987. Работал в различных организациях (производство, разработка ПО, системная интеграция, банковский бизнес). Общий педагогический стаж - 020. Преподавал дисциплины - Информационная безопасность, Имитационное моделирование, Информатика, Программирование, Современные информационные технологии в социологии.
""")
    
        let teacherNaidis = Teacher(firstName: "Ольга",
                                    lastName: "Найдис",
                                    middleName: "Александровна",
                                    department: "ИБМ",
                                    position: "Преподаватель",
                                    degree: "Доцент",
                                    photoURL: URL(string: "https://studizba.com/thumb.php?w=200&h=240&zc=1&src=/uploads/dossier/2016-07/151-195-4993-1081345473-1469171078.jpg"),
                                    about:
"""
Образование высшее, в 2005 году окончила МГТУ им. Н.Э.Баумана по специальности менеджмент организации, и средне-специальное, в 1999 году окончила Московский техникум автоматизации и радиоэлектроники по специальности экономика, бухгалтерский учет и контроль.

Кандидатская диссертация «Разработка методов управления промышленными предприятиями на основе межфакторных производственно-экономических отношений», МГТУ им. Н.Э.Баумана (2015).
Опыт работы в должностях начальника отдела управленческого учета и контроля, главного бухгалтера, бухгалтера-экономиста.

Опыт преподавательской деятельности по ведению дисциплин: «Теория бухгалтерского учета с обучением программе 1С: Бухгалтерия» в образовательном центре; «Анализ финансово-хозяйственной деятельности» и «Банковские операции» в колледже; «Технологический маркетинг», «Организация и управление научно-исследовательскими опытно-конструкторскими работами», «Маркетинг в инновационной сфере», Управление ценообразованием на рынках наукоемкой продукции» в МГТУ им. Н.Э.Баумана.

Читает лекции и проводит семинары по дисциплинам: «Экономика», «Управление логистическими системами».
""")
        
        let teacherAdamova = Teacher(firstName: "Арина",
                                     lastName: "Адамова",
                                     middleName: "Александровна",
                                     department: "ИУ4",
                                     position: "Заместитель заведующего кафедрой по аспирантуре",
                                     degree: "Доцент",
                                     photoURL: URL(string: "http://iu4.ru/prepod/img/adamova.jpg"),
                                     about:
"""
Адамова Арина Александровна родилась 22 ноября 1975 ода в Республике Дагестан, городе Махачкала. С 1991 года проходила обучение в специализированной технической школе №39 им. Астемирова на базе Дагестанского Политехнического института. В 1993 году поступила в Дагестанский Политехнический Институт на факультет “Автоматика и управление” по специальности “Информационные системы в экономике”. В 1996 году продолжила обучение в Российском Государственном Технологическом Университете им. К.Э. Циолковского (МАТИ) на кафедре “Проектирование вычислительных коплексов”. В 1997 году защитила диплом бакалавра техники и технологии по теме "Разработка обучающей программы на базе нейронных сетей". В 1999 году с отличием завершила обучение в МАТИ-РГТУ им. К. Э. Циолковского. Присуждена квалификация инженер по специальности: “Автоматизированные системы обработки информации и управления”.

С 1999 года по 2003 год работала в сфере создания и внедрения мультимедийного проекционного и презентационного оборудования, а также компонентов систем “Умный дом”.

23 апреля 2003 года защитила кандидатскую диссертацию на тему: “Модельный анализ бизнес-процесов управления реинжинирином на предприятии по производству и эксплуатации электронных средств”.

С 2003 года по 2007 год возглавляла департамент по проектированию и инсталляции систем “Умный дом” на территории РФ и стран СНГ.

С 2007 года по настоящее время возглавляет департамент по проектированию и инсталляции акустических систем на территории РФ.

19 мая 2010 года присвоено звание доцента по кафедре "Наукоемких технологий радиоэлектроники" при МАТИ-РГТУ им. К. Э. Циолковского.

С 2010 года по 2012 год доцент кафедры ИУ4 “Проектирование и технология производства электронной аппаратуры” МГТУ им. Н. Э. Баумана (по совместительству). C 2012 года по настоящее время доцент кафедры ИУ4 МГТУ им. Н. Э. Баумана.
""")
        
        // Monday
        
        let event1 = Event(title: "Методы поддержки принятия решений", teacher: teacherTerehov, location: "533", kind: .lecture, date: Date("03.09.2018")!, repeatIn: 1, startTime: "10:15", endTime: "11:50")
        let event2 = Event(title: "Элементы управления в АСОИУ", teacher: teacherNesterov, location: "533", kind: .lecture, date: Date("03.09.2018")!, repeatIn: 1, startTime: "12:00", endTime: "13:35")
        
        // Numerator
        let event3 = Event(title: "Безопасность жизнедеятельности", teacher: nil, location: "533", kind: .lecture, date: Date("03.09.2018")!, repeatIn: 2, startTime: "13:50", endTime: "15:25")
        
        // Denominator
        let event4 = Event(title: "Методы поддержки принятия решени", teacher: teacherTerehov, location: "533", kind: .lecture, date: Date("10.09.2018")!, repeatIn: 2, startTime: "13:50", endTime: "15:25")

        // Tuesday

        let event5 = Event(title: "Организационное поведение и корпоративная культура", teacher: nil, location: "418ю", kind: .seminar, date: Date("04.09.2018")!, repeatIn: 1, startTime: "08:30", endTime: "10:05")
        let event6 = Event(title: "Безопасность жизнедеятельности", teacher: nil, location: "533", kind: .lecture, date: Date("04.09.2018")!, repeatIn: 1, startTime: "10:15", endTime: "11:50")
        let event7 = Event(title: "Технология конструирования ЭВМ", teacher: teacherAdamova, location: "533", kind: .lecture, date: Date("04.09.2018")!, repeatIn: 1, startTime: "12:00", endTime: "13:35")
        
        // Numerator
        let event8 = Event(title: "Технология конструирования ЭВМ", teacher: teacherAdamova, location: "533", kind: .lecture, date: Date("04.09.2018")!, repeatIn: 2, startTime: "13:50", endTime: "15:25")
        
        // Wednesday
        
        // Numerator
        let event9 = Event(title: "Средства проектирования АСОИУ", teacher: teacherMyushenkov, location: "362", kind: .lab, date: Date("05.09.2018")!, repeatIn: 2, startTime: "10:15", endTime: "11:50")
        let event10 = Event(title: "Средства проектирования АСОИУ", teacher: teacherMyushenkov, location: "362", kind: .lab, date: Date("05.09.2018")!, repeatIn: 2, startTime: "12:00", endTime: "13:35")
        let event11 = Event(title: "Методы поддержки принятия решений", teacher: teacherTerehov, location: "395", kind: .lab, date: Date("05.09.2018")!, repeatIn: 2, startTime: "13:50", endTime: "15:25")
        let event12 = Event(title: "Методы поддержки принятия решений", teacher: teacherTerehov, location: "395", kind: .lab, date: Date("05.09.2018")!, repeatIn: 2, startTime: "15:40", endTime: "17:15")

        // Thursday
        
        // Numerator
        let event13 = Event(title: "Экономика", teacher: teacherNaidis, location: "424ю", kind: .seminar, date: Date("06.09.2018")!, repeatIn: 2, startTime: "13:50", endTime: "15:25")
        let event14 = Event(title: "Имитационное моделирование дискретных процессов", teacher: teacherChernenkiy, location: "533", kind: .lecture, date: Date("06.09.2018")!, repeatIn: 2, startTime: "15:40", endTime: "17:15")
        
        // Denominator
        let event15 = Event(title: "Элементы управления АСОИУ", teacher: teacherNesterov, location: "362", kind: .lab, date: Date("13.09.2018")!, repeatIn: 2, startTime: "12:00", endTime: "13:35")
        let event16 = Event(title: "Элементы управления АСОИУ", teacher: teacherNesterov, location: "362", kind: .lab, date: Date("13.09.2018")!, repeatIn: 2, startTime: "13:50", endTime: "15:25")
        let event17 = Event(title: "Экономика", teacher: teacherNaidis, location: "533", kind: .lecture, date: Date("13.09.2018")!, repeatIn: 2, startTime: "15:40", endTime: "17:15")
        
        let event18 = Event(title: "Средства проектирования АСОИУ", teacher: teacherMyushenkov, location: "432", kind: .seminar, date: Date("06.09.2018")!, repeatIn: 1, startTime: "17:25", endTime: "19:00")

        // Friday
        
        let event19 = Event(title: "Имитационное моделирование дискретных процессов", teacher: teacherChernenkiy, location: "903", kind: .lab, date: Date("07.09.2018")!, repeatIn: 2, startTime: "10:15", endTime: "11:50")
        let event20 = Event(title: "Имитационное моделирование дискретных процессов", teacher: teacherChernenkiy, location: "903", kind: .lab, date: Date("07.09.2018")!, repeatIn: 2, startTime: "12:00", endTime: "13:35")

        // Other
        
        let event21 = Event(title: "Технология конструирования ЭВМ", teacher: teacherAdamova, location: "533", kind: .lab, date: Date("14.09.2018")!, repeatIn: 0, startTime: "15:00", endTime: "20:00")
        let event22 = Event(title: "Технология конструирования ЭВМ", teacher: teacherAdamova, location: "533", kind: .lab, date: Date("12.10.2018")!, repeatIn: 0, startTime: "15:00", endTime: "20:00")
        
        return [event1, event2, event3, event4, event5, event6, event7, event8, event9, event10, event11, event12, event13, event14, event15, event16, event17, event18, event19, event20, event21, event22]
    }
    
    func getTeachers() -> [Teacher] {
        
        var teachers: [Teacher] = []
        
        let realm = try! Realm()
        let realmTeachers = realm.objects(RealmTeacher.self)
        
        for realmTeacher in realmTeachers {
            if let teacher = Teacher(realmTeacher), teachers.contains(where: { (currentTeacher) -> Bool in
                return teacher.fullName == currentTeacher.fullName
            }) == false {
                teachers.append(teacher)
            }
        }
        
        return teachers
    }
}

// MARK: - 3D Touch

extension AppManager {
    
    enum Action: String {
        case openSchedule
        case openTeachers
    }
    
    func perfomAction(_ action: Action) -> Bool {
        
        var quickActionHandled = false
        
        switch action {
            
        case .openSchedule:
            
            guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
                return quickActionHandled
            }
            
            if let tababarController = rootViewController as? UITabBarController {
                tababarController.selectedIndex = 0
            }
            
            quickActionHandled = true
            
        case .openTeachers:
            
            guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
                return quickActionHandled
            }
            
            if let tababarController = rootViewController as? UITabBarController {
                tababarController.selectedIndex = 1
            }
            
            quickActionHandled = true
        }
        
        return quickActionHandled
    }
    
    /// Support 3D-touch shortcuts
    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        let identifier = shortcutItem.type.components(separatedBy: ".").last!
        if let action = Action.init(rawValue: identifier) {
            return perfomAction(action)
        }
        
        return false
    }
    
    /// Support Siri intents
    func handleIntent(userActivity: NSUserActivity) -> Bool {
     
        let identifier = userActivity.activityType.components(separatedBy: ".").last!
        if let action = Action.init(rawValue: identifier) {
            return perfomAction(action)
        }
        
        return true
    }
}
