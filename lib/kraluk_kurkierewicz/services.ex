defmodule KralukKurkierewicz.Services do
  @moduledoc """
  Service (practice area) pages served at `/uslugi/<slug>`.

  Content is plain data rendered by `page_html/service.html.heex`. Facts here must
  stay consistent with the home page and the related blog posts (linked through
  `KralukKurkierewicz.Blog.Post.service`). Legal acts link to ISAP via their
  `WDU…` document id, or to a full URL (EU regulations on EUR-Lex).

  The home page "Specjalizacje" lists are rendered from `home/1`: each service's
  `audience` (`:private` / `:business`), `home_name` and `home_text`, in the
  order of `@home_order`.
  """

  @isap "https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id="

  @acts %{
    kro: {"Ustawa z dnia 25 lutego 1964 r. — Kodeks rodzinny i opiekuńczy", "WDU19640090059"},
    kc: {"Ustawa z dnia 23 kwietnia 1964 r. — Kodeks cywilny", "WDU19640160093"},
    kpc: {"Ustawa z dnia 17 listopada 1964 r. — Kodeks postępowania cywilnego", "WDU19640430296"},
    uksc:
      {"Ustawa z dnia 28 lipca 2005 r. o kosztach sądowych w sprawach cywilnych",
       "WDU20051671398"},
    pu: {"Ustawa z dnia 28 lutego 2003 r. — Prawo upadłościowe", "WDU20030600535"},
    deweloperska:
      {"Ustawa z dnia 20 maja 2021 r. o ochronie praw nabywcy lokalu mieszkalnego lub domu jednorodzinnego oraz Deweloperskim Funduszu Gwarancyjnym",
       "WDU20210001177"},
    deweloperska_nowelizacja:
      {"Ustawa z dnia 4 grudnia 2025 r. o zmianie ustawy o ochronie praw nabywcy lokalu mieszkalnego lub domu jednorodzinnego oraz Deweloperskim Funduszu Gwarancyjnym (Dz.U. z 2026 r. poz. 27)",
       "WDU20260000027"},
    kk: {"Ustawa z dnia 6 czerwca 1997 r. — Kodeks karny", "WDU19970880553"},
    kpk: {"Ustawa z dnia 6 czerwca 1997 r. — Kodeks postępowania karnego", "WDU19970890555"},
    ksh: {"Ustawa z dnia 15 września 2000 r. — Kodeks spółek handlowych", "WDU20000941037"},
    krs: {"Ustawa z dnia 20 sierpnia 1997 r. o Krajowym Rejestrze Sądowym", "WDU19971210769"},
    pr: {"Ustawa z dnia 15 maja 2015 r. — Prawo restrukturyzacyjne", "WDU20150000978"},
    uodo: {"Ustawa z dnia 10 maja 2018 r. o ochronie danych osobowych", "WDU20180001000"},
    rodo:
      {"Rozporządzenie Parlamentu Europejskiego i Rady (UE) 2016/679 (RODO)",
       "https://eur-lex.europa.eu/eli/reg/2016/679/oj"},
    ai_act:
      {"Rozporządzenie Parlamentu Europejskiego i Rady (UE) 2024/1689 (akt w sprawie sztucznej inteligencji)",
       "https://eur-lex.europa.eu/eli/reg/2024/1689/oj"},
    pacjent:
      {"Ustawa z dnia 6 listopada 2008 r. o prawach pacjenta i Rzeczniku Praw Pacjenta",
       "WDU20090520417"},
    lecznicza: {"Ustawa z dnia 15 kwietnia 2011 r. o działalności leczniczej", "WDU20111120654"},
    konsument: {"Ustawa z dnia 30 maja 2014 r. o prawach konsumenta", "WDU20140000827"},
    kw: {"Ustawa z dnia 6 lipca 1982 r. o księgach wieczystych i hipotece", "WDU19820190147"},
    sukcesja:
      {"Ustawa z dnia 5 lipca 2018 r. o zarządzie sukcesyjnym przedsiębiorstwem osoby fizycznej i innych ułatwieniach związanych z sukcesją przedsiębiorstw",
       "WDU20180001629"},
    fundacja: {"Ustawa z dnia 26 stycznia 2023 r. o fundacji rodzinnej", "WDU20230000326"}
  }

  # Order of the two "Specjalizacje" columns on the home page.
  @home_order [
    private:
      ~w(sprawy-o-zaplate odszkodowania zawyzony-metraz nieruchomosci rozwod sprawy-rodzinne
               podzial-majatku prawa-konsumentow upadlosc-konsumencka sprawy-spadkowe prawo-karne),
    business: ~w(obsluga-przedsiebiorcow zakladanie-spolek umowy egzekucja-wierzytelnosci
                restrukturyzacja obsluga-korporacyjna nowe-technologie sukcesja-firm
                prawo-medyczne spory-gospodarcze rodo)
  ]

  @services [
    %{
      slug: "rozwod",
      audience: :private,
      home_name: "Rozwód",
      home_text:
        "Pozew o rozwód lub odpowiedź na pozew, rozwód z orzekaniem o winie i bez, uregulowanie spraw dzieci i mieszkania.",
      name: "Rozwód",
      title: "Rozwód — adwokat w Gdańsku",
      meta_title: "Adwokat rozwód Gdańsk – pozew, wina, dzieci, koszty",
      description:
        "Rozwód w Gdańsku: pozew o rozwód, orzekanie o winie, władza rodzicielska, alimenty i mieszkanie. Opłata sądowa 600 zł. Kancelaria adwokacka Kraluk Kurkierewicz.",
      lead:
        "Prowadzimy sprawy rozwodowe od pierwszej rozmowy do prawomocnego wyroku — z orzekaniem o winie i bez, także gdy trzeba uregulować sprawy dzieci, alimentów i wspólnego mieszkania.",
      intro: [
        "Rozwód orzeka sąd okręgowy, jeżeli między małżonkami nastąpił zupełny i trwały rozkład pożycia (art. 56 § 1 Kodeksu rodzinnego i opiekuńczego). Opłata sądowa od pozwu o rozwód wynosi 600 zł. Gdy małżonkowie zgodnie wnoszą o rozwód bez orzekania o winie, sprawa może zakończyć się już na pierwszej rozprawie, a sąd zwraca połowę opłaty; orzekanie o winie wymaga postępowania dowodowego i wyraźnie wydłuża sprawę.",
        "W wyroku rozwodowym sąd rozstrzyga nie tylko o rozwiązaniu małżeństwa, ale też o władzy rodzicielskiej, kontaktach z dziećmi, alimentach i sposobie korzystania ze wspólnego mieszkania. Dlatego przed złożeniem pozwu ustalamy z Klientem, o co wnosić w każdym z tych punktów i jakimi dowodami to poprzeć.",
        "Reprezentujemy Klientów przed Sądem Okręgowym w Gdańsku oraz przed innymi sądami w Polsce — zarówno stronę wnoszącą pozew, jak i pozwaną."
      ],
      scope: [
        {"Pozew o rozwód i odpowiedź na pozew",
         "Przygotowanie pozwu albo odpowiedzi na pozew, wniosków dowodowych i stanowiska co do winy, dzieci, alimentów i mieszkania."},
        {"Rozwód bez orzekania o winie",
         "Uzgodnienie warunków rozstania i przygotowanie porozumienia rodzicielskiego, tak aby sprawa mogła zakończyć się możliwie szybko."},
        {"Rozwód z orzekaniem o winie",
         "Ocena, czy żądanie orzeczenia o winie jest uzasadnione, zebranie dowodów i reprezentacja w postępowaniu dowodowym."},
        {"Dzieci, alimenty i mieszkanie",
         "Władza rodzicielska, miejsce pobytu dziecka i kontakty, alimenty na dzieci i między małżonkami, korzystanie ze wspólnego mieszkania na czas po rozwodzie."}
      ],
      notes_title: "Ile kosztuje i jak długo trwa rozwód?",
      notes: [
        "Opłata sądowa od pozwu o rozwód jest stała i wynosi 600 zł. Jeżeli sąd orzeknie rozwód bez orzekania o winie na zgodny wniosek stron, po uprawomocnieniu się wyroku zwraca połowę opłaty, czyli 300 zł.",
        "Czas trwania sprawy zależy przede wszystkim od tego, czy małżonkowie są zgodni. Rozwód bez orzekania o winie, przy uzgodnionych sprawach dzieci, może zakończyć się na pierwszej rozprawie. Spór o winę, władzę rodzicielską lub alimenty oznacza przesłuchania świadków, a często także opinię biegłych, i wydłuża postępowanie."
      ],
      acts: [:kro, :kpc, :uksc]
    },
    %{
      slug: "sprawy-rodzinne",
      audience: :private,
      home_name: "Sprawy rodzinne",
      home_text:
        "Alimenty, władza rodzicielska, kontakty z dziećmi, separacja oraz ustalenie pochodzenia dziecka.",
      name: "Sprawy rodzinne i alimenty",
      title: "Sprawy rodzinne i alimenty — adwokat w Gdańsku",
      meta_title: "Sprawy rodzinne i alimenty – adwokat Gdańsk",
      description:
        "Rozwody, alimenty, władza rodzicielska i kontakty z dzieckiem. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku — konsultacje osobiście, telefonicznie i przez wideo.",
      lead:
        "Prowadzimy sprawy rodzinne z dbałością o interesy Klienta i dzieci — od pierwszej rozmowy, przez przygotowanie pozwu i dowodów, po reprezentację przed sądem.",
      intro: [
        "Sprawy o alimenty, kontakty z dzieckiem i władzę rodzicielską rozpoznaje sąd rejonowy, a sprawy o rozwód i separację — sąd okręgowy. Pozew o alimenty na dziecko, także o ich podwyższenie, jest wolny od opłat sądowych; w sprawie o obniżenie alimentów opłata zależy od wartości przedmiotu sporu (przy wartości do 20 000 zł jest stała, powyżej wynosi 5%), a opłata od pozwu o rozwód — 600 zł. Przepisy nie przewidują tabel ani minimalnej kwoty alimentów: o ich wysokości decydują usprawiedliwione potrzeby dziecka oraz zarobkowe i majątkowe możliwości rodzica.",
        "Sprawy rodzinne wymagają nie tylko znajomości przepisów i doświadczenia procesowego, ale też indywidualnego podejścia. Każdą sprawę zaczynamy od rozmowy o Twojej sytuacji i celach, a następnie przedstawiamy możliwe rozwiązania, przewidywany czas trwania postępowania oraz jego koszty.",
        "Reprezentujemy Klientów przed sądami w Gdańsku i całym Trójmieście, a także w innych miastach w Polsce."
      ],
      scope: [
        {"Rozwód i separacja",
         "Przygotowanie pozwu lub odpowiedzi na pozew, reprezentacja w sprawie rozwodowej lub o separację, uregulowanie kwestii dotyczących dzieci i wspólnego mieszkania."},
        {"Alimenty",
         "Ustalenie, podwyższenie, obniżenie lub uchylenie alimentów — w tym przygotowanie zestawienia kosztów utrzymania dziecka i dokumentów, które je potwierdzają."},
        {"Władza rodzicielska i kontakty z dzieckiem",
         "Sprawy o ograniczenie lub pozbawienie władzy rodzicielskiej, ustalenie miejsca pobytu dziecka oraz uregulowanie kontaktów z dzieckiem."},
        {"Ustalenie pochodzenia dziecka",
         "Sprawy o ustalenie lub zaprzeczenie ojcostwa i macierzyństwa."}
      ],
      notes_title: "Jak sąd ustala wysokość alimentów?",
      notes: [
        "Przepisy nie przewidują jednej tabeli ani minimalnej kwoty alimentów. Zgodnie z art. 135 § 1 Kodeksu rodzinnego i opiekuńczego sąd bierze pod uwagę usprawiedliwione potrzeby dziecka oraz zarobkowe i majątkowe możliwości rodzica — nie tylko jego aktualne wynagrodzenie.",
        "Znaczenie ma także osobista opieka nad dzieckiem: rodzic, który na co dzień się nim zajmuje, realizuje w ten sposób część obowiązku alimentacyjnego. Dlatego tak ważne jest rzetelne zestawienie kosztów utrzymania dziecka, poparte rachunkami i innymi dokumentami.",
        "Osoba dochodząca alimentów na dziecko jest zwolniona od kosztów sądowych — dotyczy to także sprawy o podwyższenie alimentów."
      ],
      acts: [:kro, :kpc, :uksc]
    },
    %{
      slug: "podzial-majatku",
      audience: :private,
      home_name: "Majątek małżonków",
      home_text:
        "Podział majątku wspólnego, rozliczenia nakładów i wydatków oraz inne spory majątkowe między małżonkami.",
      name: "Podział majątku małżonków",
      title: "Podział majątku po rozwodzie — adwokat w Gdańsku",
      meta_title: "Podział majątku małżonków – adwokat Gdańsk",
      description:
        "Podział majątku wspólnego, mieszkanie z kredytem hipotecznym, rozliczenie nakładów i spłaconych rat. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy uporządkować sprawy majątkowe po rozwodzie lub ustaniu wspólności — tak, aby podział był sprawiedliwy, a jego skutki przewidywalne.",
      intro: [
        "Majątek wspólny można podzielić umową — u notariusza, jeżeli obejmuje nieruchomość — albo przed sądem rejonowym. Opłata od wniosku o podział majątku wynosi 1 000 zł, a przy zgodnym projekcie podziału 300 zł. Rozwód nie zmienia odpowiedzialności za wspólny kredyt: wobec banku oboje byli małżonkowie odpowiadają solidarnie, dopóki bank nie zgodzi się na zmianę umowy.",
        "Podział majątku wspólnego to często najtrudniejszy finansowo etap zakończenia małżeństwa. Trzeba ustalić, co wchodzi w skład majątku, jaka jest jego wartość, kto poniósł jakie nakłady oraz jak rozliczyć zobowiązania — zwłaszcza kredyt hipoteczny.",
        "Doradzamy przy podziale umownym, a gdy porozumienie nie jest możliwe, reprezentujemy Klientów w sądowym postępowaniu o podział majątku."
      ],
      scope: [
        {"Podział majątku wspólnego",
         "Ustalenie składu i wartości majątku, przygotowanie wniosku o podział lub projektu porozumienia, reprezentacja przed sądem."},
        {"Mieszkanie z kredytem hipotecznym",
         "Wycena nieruchomości obciążonej hipoteką, przyznanie mieszkania jednemu z małżonków i ustalenie spłaty, rozmowy z bankiem o przejęciu kredytu."},
        {"Rozliczenie nakładów i spłaconych rat",
         "Zwrot nakładów z majątku osobistego na wspólny (i odwrotnie) oraz rozliczenie rat kredytu spłaconych przez jednego z byłych małżonków."},
        {"Inne spory majątkowe między małżonkami",
         "Ustalenie nierównych udziałów w majątku wspólnym, rozdzielność majątkowa, spory o składniki majątku."}
      ],
      notes_title: "Kredyt hipoteczny przy podziale majątku",
      notes: [
        "Rozwód nie zwalnia żadnego z małżonków z obowiązku spłaty wspólnego kredytu. Dopóki nie dojdzie do zmiany umowy z bankiem, oboje byli małżonkowie odpowiadają za kredyt solidarnie — także wtedy, gdy w mieszkaniu zostaje tylko jedno z nich.",
        "Sąd w sprawie o podział majątku dzieli aktywa, ale co do zasady nie dzieli długów. Może przyznać mieszkanie jednemu z małżonków, nie może jednak samym postanowieniem zwolnić drugiego z odpowiedzialności wobec banku. Dlatego warunki podziału warto ustalać z uwzględnieniem dalszej obsługi kredytu."
      ],
      acts: [:kro, :kc, :kpc]
    },
    %{
      slug: "upadlosc-konsumencka",
      audience: :private,
      home_name: "Upadłość konsumencka",
      home_text: "Przygotowanie wniosku i wsparcie na każdym etapie postępowania.",
      name: "Upadłość konsumencka",
      title: "Upadłość konsumencka — pomoc adwokata w Gdańsku",
      meta_title: "Upadłość konsumencka – adwokat Gdańsk",
      description:
        "Ocena możliwości oddłużenia, przygotowanie wniosku o upadłość konsumencką i reprezentacja w postępowaniu. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy ocenić, czy upadłość konsumencka jest właściwym rozwiązaniem, przygotować wniosek i przejść przez postępowanie aż do oddłużenia.",
      intro: [
        "Upadłość konsumencką może ogłosić osoba fizyczna nieprowadząca działalności gospodarczej, która stała się niewypłacalna. Wniosek składa się do sądu upadłościowego, a opłata od niego wynosi 30 zł. Plan spłaty wierzycieli trwa co do zasady do 3 lat, a od 3 do 7 lat — gdy dłużnik doprowadził do niewypłacalności umyślnie lub wskutek rażącego niedbalstwa. Umorzeniu nie podlegają między innymi alimenty i grzywny.",
        "Upadłość konsumencka może prowadzić do umorzenia części albo całości niespłaconych zobowiązań, ale wiąże się z obowiązkami i może oznaczać sprzedaż majątku. Przed złożeniem wniosku warto zrozumieć, jak postępowanie wpłynie na mieszkanie, dochody i rodzinę.",
        "Podczas konsultacji omawiamy możliwe skutki postępowania dla zadłużenia, majątku i bliskich oraz ustalamy zakres potrzebnej pomocy."
      ],
      scope: [
        {"Ocena możliwości oddłużenia",
         "Analiza, czy spełnione są przesłanki ogłoszenia upadłości i na jakich warunkach możliwe będzie umorzenie długów."},
        {"Przygotowanie wniosku",
         "Skompletowanie dokumentów, opis sytuacji majątkowej i przyczyn niewypłacalności, złożenie wniosku do sądu."},
        {"Reprezentacja w postępowaniu",
         "Kontakt z syndykiem i sądem, udział w ustalaniu planu spłaty, wnioski o umorzenie zobowiązań."},
        {"Rozwiązania alternatywne",
         "Ocena, czy w danej sprawie lepszy będzie układ z wierzycielami — na przykład gdy celem jest zachowanie nieruchomości."}
      ],
      notes_title: "Kto może skorzystać z upadłości konsumenckiej?",
      notes: [
        "Upadłość konsumencka dotyczy osób fizycznych nieprowadzących działalności gospodarczej. Podstawowym warunkiem jest niewypłacalność, czyli utrata zdolności do spłacania wymagalnych zobowiązań. Nie trzeba czekać na egzekucję komorniczą ani mieć kilku wierzycieli.",
        "Z procedury mogą korzystać również byli przedsiębiorcy, także w zakresie długów z okresu prowadzenia firmy. Szczególnej analizy wymagają sprawy dotyczące majątku wspólnego małżonków, wcześniejszej działalności gospodarczej lub rozporządzania majątkiem przed złożeniem wniosku."
      ],
      acts: [:pu]
    },
    %{
      slug: "zawyzony-metraz",
      audience: :private,
      home_name: "Roszczenia z tytułu zawyżonego metrażu",
      home_text:
        "Dochodzenie zwrotu części ceny, gdy rzeczywista powierzchnia lokalu jest mniejsza niż wskazana w umowie.",
      name: "Zawyżony metraż mieszkania",
      title: "Zawyżony metraż mieszkania — adwokat w Gdańsku",
      meta_title: "Zawyżony metraż mieszkania – adwokat Gdańsk",
      description:
        "Ścianki działowe wliczone do powierzchni użytkowej? Analizujemy umowę deweloperską i dochodzimy zwrotu nadpłaconej części ceny. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Jeżeli rzeczywista powierzchnia mieszkania jest mniejsza niż ta, za którą zapłaciłeś, przeanalizujemy umowę i ocenimy, czy możesz odzyskać od dewelopera część ceny.",
      intro: [
        "Jeżeli deweloper wliczył do powierzchni użytkowej mieszkania stałe ścianki działowe, nabywca może żądać zwrotu części ceny: różnicy powierzchni pomnożonej przez cenę metra kwadratowego z umowy. W wyrokach opublikowanych przez sądy zasądzano od ok. 11 tys. do ok. 24 tys. zł na jednego nabywcę. Roszczenie przedawnia się co do zasady po 6 latach, a nowelizacja ustawy deweloperskiej z 13 lutego 2026 r. dotyczy wyłącznie umów zawartych od tego dnia.",
        "Cena mieszkania od dewelopera to zwykle iloczyn powierzchni użytkowej i ceny za metr kwadratowy. Część deweloperów wliczała do powierzchni użytkowej powierzchnię zajętą przez ścianki działowe — nabywca płacił więc za metry, z których nie może korzystać. Przy obecnych cenach nawet różnica jednego lub dwóch metrów oznacza realną kwotę.",
        "Sądy przyznają rację kupującym przede wszystkim wtedy, gdy ściany mają charakter stały, a umowa nie informowała w jasny sposób o metodzie pomiaru."
      ],
      scope: [
        {"Analiza umowy i dokumentów",
         "Umowa deweloperska i umowa przeniesienia własności, prospekt informacyjny, rzut lokalu, data wniosku o pozwolenie na budowę i zastosowana wersja normy PN-ISO 9836."},
        {"Ocena roszczenia",
         "Ustalenie, czy postanowienie o sposobie liczenia powierzchni może zostać uznane za niedozwolone i jakiej kwoty można dochodzić."},
        {"Wezwanie do zapłaty i negocjacje",
         "Przygotowanie wezwania do zapłaty i rozmowy z deweloperem przed skierowaniem sprawy do sądu."},
        {"Postępowanie sądowe",
         "Pozew o zwrot nadpłaconej części ceny jako świadczenia nienależnego i reprezentacja przed sądem."}
      ],
      notes_title: "Czy nowelizacja ustawy deweloperskiej zamyka sprawę?",
      notes: [
        "Od 13 lutego 2026 r. ustawa deweloperska wprost przewiduje, że powierzchnię użytkową lokalu ustala się zgodnie z Polską Normą. Nowe zasady dotyczą jednak wyłącznie umów zawartych od tego dnia.",
        "Umowy wcześniejsze ocenia się według dotychczasowych reguł, dlatego spory o metraż mieszkań kupionych przed nowelizacją pozostają aktualne. Roszczenia majątkowe ulegają przedawnieniu, więc nie warto odkładać analizy umowy."
      ],
      acts: [:deweloperska, :deweloperska_nowelizacja, :kc]
    },
    # ——— Dla osób prywatnych ———
    %{
      slug: "sprawy-o-zaplate",
      audience: :private,
      home_name: "Sprawy o zapłatę i dochodzenie należności",
      home_text:
        "Dochodzenie roszczeń pieniężnych oraz obrona przed niezasadnymi żądaniami zapłaty.",
      name: "Sprawy o zapłatę",
      title: "Sprawy o zapłatę i dochodzenie należności — adwokat w Gdańsku",
      meta_title: "Sprawy o zapłatę – adwokat Gdańsk",
      description:
        "Dochodzenie roszczeń pieniężnych i obrona przed niezasadnymi żądaniami zapłaty, także w postępowaniu upominawczym i nakazowym. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Pomagamy odzyskać pieniądze, które Ci się należą, i bronimy przed żądaniami zapłaty, które nie mają podstaw.",
      intro: [
        "Sprawy o zapłatę dotyczą najróżniejszych sytuacji: niezapłaconej pożyczki, wynagrodzenia za wykonaną pracę, zwrotu zaliczki czy kary umownej. Równie często zgłaszają się do nas osoby, które otrzymały wezwanie do zapłaty, nakaz zapłaty albo pozew i nie wiedzą, czy roszczenie jest zasadne.",
        "Zaczynamy od analizy dokumentów i oceny szans, a następnie rekomendujemy sposób działania — od wezwania do zapłaty i negocjacji po postępowanie sądowe."
      ],
      scope: [
        {"Ocena roszczenia",
         "Analiza umowy, korespondencji i dowodów, sprawdzenie terminu przedawnienia i wysokości należności wraz z odsetkami."},
        {"Wezwanie do zapłaty i negocjacje",
         "Przygotowanie przedsądowego wezwania do zapłaty i rozmowy z dłużnikiem — często pozwalają zakończyć sprawę bez sądu."},
        {"Postępowanie sądowe",
         "Pozew o zapłatę, w tym w postępowaniu upominawczym, nakazowym lub elektronicznym, i reprezentacja przed sądem."},
        {"Obrona przed żądaniem zapłaty",
         "Sprzeciw od nakazu zapłaty lub zarzuty, odpowiedź na pozew, zarzut przedawnienia i inne środki obrony."}
      ],
      notes_title: "Nakaz zapłaty — liczy się czas",
      notes: [
        "Nakaz zapłaty wydany w postępowaniu upominawczym można zaskarżyć sprzeciwem w terminie dwóch tygodni od jego doręczenia. Jeżeli termin minie, nakaz się uprawomocni i może stać się podstawą egzekucji komorniczej.",
        "Roszczenia majątkowe ulegają przedawnieniu — co do zasady po sześciu latach, a roszczenia o świadczenia okresowe i związane z prowadzeniem działalności gospodarczej po trzech latach. Koniec terminu przypada na ostatni dzień roku kalendarzowego, chyba że termin jest krótszy niż dwa lata."
      ],
      acts: [:kc, :kpc]
    },
    %{
      slug: "odszkodowania",
      audience: :private,
      home_name: "Odszkodowania i zadośćuczynienia",
      home_text:
        "Dochodzenie roszczeń za szkody majątkowe i niemajątkowe, w szczególności wynikające z czynów niedozwolonych i wypadków.",
      name: "Odszkodowania i zadośćuczynienia",
      title: "Odszkodowania i zadośćuczynienia — adwokat w Gdańsku",
      meta_title: "Odszkodowania i zadośćuczynienia – adwokat Gdańsk",
      description:
        "Dochodzenie odszkodowania i zadośćuczynienia po wypadkach i innych zdarzeniach, także od ubezpieczyciela. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy uzyskać należne odszkodowanie za szkodę majątkową i zadośćuczynienie za krzywdę — w rozmowach z ubezpieczycielem i przed sądem.",
      intro: [
        "Wypadek komunikacyjny, upadek na nieodśnieżonym chodniku, pogryzienie przez psa czy zalanie mieszkania — każde z tych zdarzeń może rodzić roszczenia wobec sprawcy lub jego ubezpieczyciela. Proponowane przez ubezpieczycieli kwoty nie zawsze odpowiadają rzeczywistym stratom.",
        "Oceniamy, komu i w jakiej wysokości przysługują roszczenia, gromadzimy dowody i prowadzimy sprawę aż do uzyskania świadczenia."
      ],
      scope: [
        {"Odszkodowanie za szkodę majątkową",
         "Zwrot kosztów leczenia, rehabilitacji i naprawy, utracone zarobki oraz inne straty wynikające ze zdarzenia."},
        {"Zadośćuczynienie za krzywdę",
         "Pieniężne zadośćuczynienie za ból, cierpienie i ograniczenia w codziennym życiu po uszkodzeniu ciała lub rozstroju zdrowia."},
        {"Renta",
         "Roszczenie o rentę, gdy poszkodowany utracił całkowicie lub częściowo zdolność do pracy albo zwiększyły się jego potrzeby."},
        {"Spory z ubezpieczycielem",
         "Odwołanie od decyzji ubezpieczyciela, dopłata zaniżonego świadczenia i pozew, gdy negocjacje nie przynoszą efektu."}
      ],
      notes_title: "Kiedy przedawnia się roszczenie o odszkodowanie?",
      notes: [
        "Roszczenie o naprawienie szkody wyrządzonej czynem niedozwolonym przedawnia się z upływem trzech lat od dnia, w którym poszkodowany dowiedział się o szkodzie i o osobie obowiązanej do jej naprawienia, ale nie później niż dziesięć lat od zdarzenia.",
        "Jeżeli szkoda wynikła ze zbrodni lub występku — na przykład z wypadku drogowego, który był przestępstwem — termin przedawnienia wynosi dwadzieścia lat od popełnienia przestępstwa."
      ],
      acts: [:kc, :kpc]
    },
    %{
      slug: "nieruchomosci",
      audience: :private,
      home_name: "Nieruchomości",
      home_text:
        "Sprawy dotyczące własności, posiadania, zasiedzenia, służebności, wydania nieruchomości oraz rozliczeń związanych z nieruchomościami.",
      name: "Nieruchomości",
      title: "Sprawy o nieruchomości — adwokat w Gdańsku",
      meta_title: "Prawo nieruchomości – adwokat Gdańsk",
      description:
        "Własność, zasiedzenie, służebności, zniesienie współwłasności, wydanie nieruchomości i księgi wieczyste. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy w sporach o własność i korzystanie z nieruchomości oraz w porządkowaniu ich stanu prawnego.",
      intro: [
        "Nieruchomość to dla wielu osób najcenniejszy składnik majątku, a spory jej dotyczące bywają długotrwałe i emocjonalne — zwłaszcza między sąsiadami lub członkami rodziny. Kluczowe jest dokładne ustalenie stanu prawnego i faktycznego jeszcze przed podjęciem działań.",
        "Analizujemy księgi wieczyste, umowy i dokumentację geodezyjną, a następnie proponujemy rozwiązanie — polubowne lub sądowe."
      ],
      scope: [
        {"Własność i współwłasność",
         "Zniesienie współwłasności, spory między współwłaścicielami, ochrona własności i wydanie nieruchomości."},
        {"Zasiedzenie",
         "Stwierdzenie nabycia własności nieruchomości lub służebności przez zasiedzenie, a także obrona przed takim wnioskiem."},
        {"Służebności",
         "Ustanowienie drogi koniecznej, służebności przesyłu i innych służebności oraz spory o ich wykonywanie."},
        {"Posiadanie i rozliczenia",
         "Ochrona posiadania, wynagrodzenie za bezumowne korzystanie z nieruchomości, rozliczenie nakładów oraz sprawy dotyczące wpisów w księdze wieczystej."}
      ],
      notes_title: "Zasiedzenie nieruchomości",
      notes: [
        "Posiadacz samoistny nabywa własność nieruchomości przez zasiedzenie po dwudziestu latach nieprzerwanego posiadania, jeżeli uzyskał je w dobrej wierze, albo po trzydziestu latach — jeżeli w złej wierze.",
        "Sąd nie przyznaje własności w drodze zasiedzenia, lecz stwierdza, że nastąpiło ono z mocy prawa. Dlatego tak ważne jest udokumentowanie, od kiedy i w jaki sposób nieruchomość była posiadana."
      ],
      acts: [:kc, :kw, :kpc]
    },
    %{
      slug: "prawa-konsumentow",
      audience: :private,
      home_name: "Ochrona praw konsumentów",
      home_text:
        "Dochodzenie roszczeń wynikających z umów konsumenckich oraz ochrona przed nieuczciwymi praktykami przedsiębiorców.",
      name: "Ochrona praw konsumentów",
      title: "Ochrona praw konsumentów — adwokat w Gdańsku",
      meta_title: "Prawa konsumenta – adwokat Gdańsk",
      description:
        "Reklamacje, odstąpienie od umowy, niedozwolone postanowienia umowne i spory z przedsiębiorcami. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy konsumentom egzekwować ich prawa wobec sprzedawców, usługodawców i innych przedsiębiorców.",
      intro: [
        "Przepisy zapewniają konsumentom szeroką ochronę, ale w praktyce przedsiębiorcy nie zawsze ją respektują — odmawiają uwzględnienia reklamacji, utrudniają odstąpienie od umowy albo stosują postanowienia, które nie powinny wiązać klienta.",
        "Oceniamy umowę i okoliczności sprawy, przygotowujemy pisma i reprezentujemy Klientów w sporach z przedsiębiorcami."
      ],
      scope: [
        {"Reklamacje i niezgodność z umową",
         "Dochodzenie naprawy, wymiany, obniżenia ceny lub zwrotu pieniędzy za towar albo usługę niezgodną z umową."},
        {"Odstąpienie od umowy",
         "Odstąpienie od umowy zawartej na odległość lub poza lokalem przedsiębiorstwa i rozliczenie wzajemnych świadczeń."},
        {"Niedozwolone postanowienia umowne",
         "Ocena, czy postanowienia umowy kształtują prawa konsumenta sprzecznie z dobrymi obyczajami i rażąco naruszają jego interesy."},
        {"Spory z przedsiębiorcami",
         "Wezwania do zapłaty, pozwy i reprezentacja w sprawach wynikających z umów konsumenckich."}
      ],
      notes_title: "Odstąpienie od umowy zawartej przez internet",
      notes: [
        "Konsument, który zawarł umowę na odległość — na przykład w sklepie internetowym — może co do zasady odstąpić od niej bez podawania przyczyny w terminie czternastu dni. Od tej reguły istnieją jednak wyjątki, np. dla towarów wyprodukowanych według specyfikacji konsumenta.",
        "Postanowienia umowy, które nie zostały uzgodnione indywidualnie i rażąco naruszają interesy konsumenta, nie wiążą go — umowa obowiązuje wówczas w pozostałym zakresie."
      ],
      acts: [:konsument, :kc]
    },
    %{
      slug: "sprawy-spadkowe",
      audience: :private,
      home_name: "Sprawy spadkowe",
      home_text:
        "Stwierdzenie nabycia spadku, dział spadku, zachowek, testamenty oraz odpowiedzialność za długi spadkowe.",
      name: "Sprawy spadkowe",
      title: "Sprawy spadkowe i zachowek — adwokat w Gdańsku",
      meta_title: "Sprawy spadkowe i zachowek – adwokat Gdańsk",
      description:
        "Stwierdzenie nabycia spadku, dział spadku, zachowek, testamenty i długi spadkowe. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy uporządkować sprawy spadkowe — od stwierdzenia nabycia spadku, przez dział spadku, po spory o zachowek.",
      intro: [
        "Sprawy spadkowe zbiegają się zwykle z trudnym okresem po stracie bliskiej osoby. Jednocześnie wymagają podjęcia decyzji w ściśle określonych terminach — przede wszystkim co do przyjęcia lub odrzucenia spadku.",
        "Wyjaśniamy, jakie prawa i obowiązki przysługują spadkobiercom, a następnie prowadzimy sprawę przed sądem lub notariuszem."
      ],
      scope: [
        {"Stwierdzenie nabycia spadku",
         "Wniosek do sądu lub przygotowanie do aktu poświadczenia dziedziczenia u notariusza."},
        {"Dział spadku",
         "Podział majątku spadkowego między spadkobierców, w tym nieruchomości i przedsiębiorstwa, wraz z rozliczeniem darowizn i nakładów."},
        {"Zachowek",
         "Dochodzenie zachowku przez osoby pominięte w testamencie oraz obrona przed roszczeniem o zachowek."},
        {"Testamenty i długi spadkowe",
         "Ocena ważności testamentu, przyjęcie lub odrzucenie spadku oraz ograniczenie odpowiedzialności za długi spadkowe."}
      ],
      notes_title: "Sześć miesięcy na decyzję o spadku",
      notes: [
        "Spadkobierca może przyjąć spadek wprost, przyjąć go z dobrodziejstwem inwentarza albo go odrzucić w terminie sześciu miesięcy od dnia, w którym dowiedział się o tytule swojego powołania. Brak oświadczenia w tym terminie oznacza przyjęcie spadku z dobrodziejstwem inwentarza.",
        "Zachowek wynosi co do zasady połowę wartości udziału, który przypadłby uprawnionemu przy dziedziczeniu ustawowym, a dwie trzecie — gdy uprawniony jest trwale niezdolny do pracy lub małoletni. Roszczenie o zachowek z testamentu przedawnia się z upływem pięciu lat od ogłoszenia testamentu."
      ],
      acts: [:kc, :kpc]
    },
    %{
      slug: "prawo-karne",
      audience: :private,
      home_name: "Prawo karne",
      home_text: "Reprezentacja pokrzywdzonych w postępowaniu karnym.",
      name: "Prawo karne",
      title: "Prawo karne — pełnomocnik pokrzywdzonego w Gdańsku",
      meta_title: "Adwokat prawo karne – Gdańsk",
      description:
        "Reprezentacja pokrzywdzonych w postępowaniu karnym — od postępowania przygotowawczego po postępowanie sądowe. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Reprezentujemy osoby pokrzywdzone przestępstwem — na każdym etapie postępowania karnego.",
      intro: [
        "Postępowanie karne toczy się według ścisłych reguł i terminów, a decyzje podjęte na jego początku — choćby co do treści zawiadomienia o przestępstwie — mogą mieć znaczenie dla całej sprawy. Dlatego warto skontaktować się z adwokatem jak najwcześniej.",
        "Reprezentujemy pokrzywdzonych w postępowaniu przygotowawczym przed policją i prokuraturą oraz w postępowaniu przed sądem."
      ],
      scope: [
        {"Zawiadomienie o przestępstwie",
         "Przygotowanie zawiadomienia o przestępstwie i udział w przesłuchaniu pokrzywdzonego."},
        {"Reprezentacja pokrzywdzonych",
         "Udział w postępowaniu przygotowawczym jako pełnomocnik pokrzywdzonego, wnioski dowodowe oraz występowanie przed sądem w roli oskarżyciela posiłkowego."},
        {"Naprawienie szkody",
         "Wniosek o zobowiązanie sprawcy do naprawienia szkody lub zadośćuczynienia za doznaną krzywdę."},
        {"Środki zaskarżenia",
         "Zażalenia na postanowienia w toku postępowania, apelacje od wyroków i inne środki zaskarżenia."}
      ],
      notes_title: "Prawa pokrzywdzonego",
      notes: [
        "Pokrzywdzony nie jest jedynie świadkiem. Może składać wnioski dowodowe, przeglądać akta, zaskarżać decyzje o umorzeniu postępowania, a w postępowaniu sądowym działać jako oskarżyciel posiłkowy.",
        "W razie skazania sąd może na wniosek pokrzywdzonego orzec obowiązek naprawienia szkody w całości lub w części albo zadośćuczynienia za doznaną krzywdę."
      ],
      acts: [:kk, :kpk]
    },
    # ——— Dla przedsiębiorców ———
    %{
      slug: "obsluga-przedsiebiorcow",
      audience: :business,
      home_name: "Bieżąca obsługa przedsiębiorców",
      home_text: "Stałe wsparcie prawne w codziennym prowadzeniu firmy.",
      name: "Bieżąca obsługa prawna firm",
      title: "Bieżąca obsługa prawna firm — kancelaria w Gdańsku",
      meta_title: "Obsługa prawna firm – kancelaria Gdańsk",
      description:
        "Stałe wsparcie prawne w codziennym prowadzeniu firmy: umowy, opinie prawne, spory i decyzje biznesowe. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Zapewniamy stałe wsparcie prawne, dzięki któremu możesz skupić się na prowadzeniu firmy.",
      intro: [
        "Celem stałej obsługi prawnej jest nie tylko reagowanie na pojawiające się problemy, ale przede wszystkim takie doradztwo, które pozwala ograniczać ryzyko i świadomie podejmować decyzje biznesowe.",
        "Poznajemy Twoją firmę, jej model działania i potrzeby, a następnie ustalamy zakres i sposób współpracy dopasowany do skali działalności."
      ],
      scope: [
        {"Doradztwo bieżące",
         "Odpowiedzi na pytania prawne pojawiające się w codziennej działalności oraz opinie prawne."},
        {"Umowy i dokumenty",
         "Przygotowanie, weryfikacja i negocjowanie umów z kontrahentami, regulaminów i wzorców umownych."},
        {"Ocena ryzyka prawnego",
         "Analiza skutków prawnych planowanych decyzji i transakcji, zanim zostaną podjęte."},
        {"Spory i windykacja",
         "Reprezentacja w sporach z kontrahentami oraz odzyskiwanie należności."}
      ],
      notes_title: "Jak wygląda współpraca?",
      notes: [
        "Każdą współpracę rozpoczynamy od rozmowy o profilu działalności i najczęstszych potrzebach prawnych firmy. Na tej podstawie przedstawiamy proponowany zakres i koszty obsługi.",
        "Stała współpraca pozwala nam dobrze poznać Twoją firmę, dzięki czemu możemy reagować szybciej i trafniej oceniać ryzyko w kolejnych sprawach."
      ],
      acts: [:kc, :ksh]
    },
    %{
      slug: "zakladanie-spolek",
      audience: :business,
      home_name: "Zakładanie i rejestracja spółek",
      home_text: "Wybór formy działalności, umowa spółki i rejestracja w KRS.",
      name: "Zakładanie i rejestracja spółek",
      title: "Zakładanie i rejestracja spółek — adwokat w Gdańsku",
      meta_title: "Założenie spółki i rejestracja w KRS – Gdańsk",
      description:
        "Wybór formy prawnej, umowa spółki i rejestracja w KRS — sp. z o.o., spółki osobowe, prosta spółka akcyjna. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Pomagamy wybrać formę prawną działalności, przygotować umowę spółki i zarejestrować ją w Krajowym Rejestrze Sądowym.",
      intro: [
        "Wybór formy prawnej ma długofalowe skutki — dla odpowiedzialności wspólników, opodatkowania, sposobu podejmowania decyzji i możliwości pozyskania inwestora. Warto podjąć go świadomie, zanim firma zacznie działać.",
        "Doradzamy przy wyborze formy, przygotowujemy dokumenty założycielskie dopasowane do potrzeb wspólników i przeprowadzamy rejestrację."
      ],
      scope: [
        {"Wybór formy działalności",
         "Porównanie spółki z o.o., prostej spółki akcyjnej, spółki akcyjnej i spółek osobowych pod kątem Twoich celów."},
        {"Umowa spółki",
         "Indywidualna umowa spółki — zasady reprezentacji, podejmowania uchwał, zbywania udziałów i wyjścia wspólnika."},
        {"Rejestracja w KRS",
         "Przygotowanie i złożenie wniosku o wpis do rejestru przedsiębiorców wraz z wymaganymi dokumentami."},
        {"Umowy wspólników",
         "Porozumienia regulujące relacje między wspólnikami, wkłady, zakaz konkurencji i rozwiązywanie impasów."}
      ],
      notes_title: "Rejestracja spółki jest dziś elektroniczna",
      notes: [
        "Wnioski do Krajowego Rejestru Sądowego składa się wyłącznie elektronicznie, przez Portal Rejestrów Sądowych. Spółkę z o.o. można też założyć przez system S24 na wzorcu umowy — to szybkie, ale wzorzec nie pozwala na indywidualne ustalenia między wspólnikami.",
        "Przy kilku wspólnikach warto od początku uregulować zasady wyjścia ze spółki i zbywania udziałów. Późniejsze zmiany umowy wymagają zgody wspólników, o którą w razie konfliktu bywa trudno."
      ],
      acts: [:ksh, :krs]
    },
    %{
      slug: "umowy",
      audience: :business,
      home_name: "Analiza i sporządzanie umów",
      home_text: "Przygotowanie, weryfikacja i negocjowanie umów.",
      name: "Analiza i sporządzanie umów",
      title: "Sporządzanie i analiza umów — adwokat w Gdańsku",
      meta_title: "Sporządzanie i analiza umów – adwokat Gdańsk",
      description:
        "Przygotowanie, weryfikacja i negocjowanie umów handlowych, umów o współpracy i umów z klientami. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Przygotowujemy, sprawdzamy i negocjujemy umowy tak, aby chroniły Twoje interesy i ograniczały ryzyko sporów.",
      intro: [
        "Dobrze napisana umowa to najtańszy sposób na uniknięcie sporu. Wiele konfliktów, które trafiają do sądu, wynika z niejasnych postanowień, braku regulacji ważnych kwestii albo podpisania wzorca kontrahenta bez jego analizy.",
        "Analizujemy umowy pod kątem ryzyk prawnych i biznesowych, proponujemy zmiany i wspieramy w negocjacjach."
      ],
      scope: [
        {"Przygotowanie umów",
         "Umowy handlowe, o współpracy, o świadczenie usług, o dzieło, dostawy, najmu i inne — dopasowane do konkretnej transakcji."},
        {"Weryfikacja umów",
         "Analiza umowy przedstawionej przez kontrahenta, wskazanie ryzyk i propozycje zmian."},
        {"Negocjacje", "Udział w negocjacjach lub przygotowanie stanowiska negocjacyjnego."},
        {"Wzorce i regulaminy",
         "Ogólne warunki umów, regulaminy sprzedaży i świadczenia usług, w tym w relacjach z konsumentami."}
      ],
      notes_title: "Na co zwracamy uwagę w umowie?",
      notes: [
        "Poza głównymi świadczeniami stron sprawdzamy przede wszystkim postanowienia o odpowiedzialności i jej ograniczeniach, karach umownych, terminach, warunkach rozwiązania umowy oraz sposobie rozstrzygania sporów.",
        "W umowach z konsumentami szczególne znaczenie mają przepisy o niedozwolonych postanowieniach umownych — postanowienia kształtujące prawa konsumenta sprzecznie z dobrymi obyczajami nie będą go wiązać."
      ],
      acts: [:kc]
    },
    %{
      slug: "egzekucja-wierzytelnosci",
      audience: :business,
      home_name: "Egzekucja wierzytelności",
      home_text: "Odzyskiwanie należności — od wezwania do zapłaty po egzekucję komorniczą.",
      name: "Egzekucja wierzytelności",
      title: "Windykacja i egzekucja wierzytelności — adwokat w Gdańsku",
      meta_title: "Windykacja i egzekucja należności – Gdańsk",
      description:
        "Odzyskiwanie należności dla firm: wezwanie do zapłaty, nakaz zapłaty, klauzula wykonalności i egzekucja komornicza. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Odzyskujemy należności — od wezwania do zapłaty, przez uzyskanie nakazu zapłaty, po egzekucję komorniczą.",
      intro: [
        "Nieopłacone faktury obciążają płynność firmy, a im dłużej wierzyciel zwleka, tym trudniej odzyskać pieniądze. Skuteczna windykacja wymaga szybkiego działania i właściwego wyboru drogi.",
        "Prowadzimy cały proces odzyskiwania należności i na bieżąco informujemy o kolejnych krokach oraz ich kosztach."
      ],
      scope: [
        {"Windykacja polubowna",
         "Wezwanie do zapłaty, negocjacje z dłużnikiem i porozumienia o spłacie w ratach."},
        {"Nakaz zapłaty",
         "Pozew w postępowaniu nakazowym, upominawczym lub elektronicznym — często najszybsza droga do tytułu egzekucyjnego."},
        {"Egzekucja komornicza",
         "Uzyskanie klauzuli wykonalności, wniosek egzekucyjny i współpraca z komornikiem."},
        {"Zabezpieczenie roszczeń",
         "Wniosek o zabezpieczenie roszczenia jeszcze przed wydaniem wyroku, gdy istnieje ryzyko wyzbycia się majątku przez dłużnika."}
      ],
      notes_title: "Od faktury do komornika",
      notes: [
        "Podstawą egzekucji jest tytuł wykonawczy, czyli tytuł egzekucyjny — najczęściej prawomocny wyrok lub nakaz zapłaty — zaopatrzony w klauzulę wykonalności.",
        "Roszczenia związane z prowadzeniem działalności gospodarczej przedawniają się co do zasady po trzech latach, z końcem roku kalendarzowego. Nie warto więc odkładać działań windykacyjnych."
      ],
      acts: [:kpc, :kc]
    },
    %{
      slug: "restrukturyzacja",
      audience: :business,
      home_name: "Restrukturyzacja",
      home_text: "Wsparcie firm w trudnej sytuacji finansowej.",
      name: "Restrukturyzacja",
      title: "Restrukturyzacja firm — adwokat w Gdańsku",
      meta_title: "Restrukturyzacja przedsiębiorstwa – Gdańsk",
      description:
        "Wsparcie firm w trudnej sytuacji finansowej: wybór postępowania restrukturyzacyjnego, układ z wierzycielami i negocjacje. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Pomagamy firmom w trudnej sytuacji finansowej wybrać właściwą drogę naprawy i porozumieć się z wierzycielami.",
      intro: [
        "Restrukturyzacja daje przedsiębiorcy szansę na uniknięcie upadłości — przez zawarcie układu z wierzycielami, a w niektórych postępowaniach także przez przeprowadzenie działań sanacyjnych. Im wcześniej zostanie podjęta, tym więcej możliwości pozostaje.",
        "Oceniamy sytuację firmy, przedstawiamy dostępne postępowania i ich konsekwencje oraz wspieramy przy przygotowaniu propozycji układowych."
      ],
      scope: [
        {"Analiza sytuacji",
         "Ocena, czy firma jest niewypłacalna lub zagrożona niewypłacalnością i które postępowanie będzie właściwe."},
        {"Postępowania restrukturyzacyjne",
         "Wsparcie w postępowaniu o zatwierdzenie układu, przyspieszonym postępowaniu układowym, postępowaniu układowym i sanacyjnym."},
        {"Negocjacje z wierzycielami",
         "Przygotowanie propozycji układowych i rozmowy z kluczowymi wierzycielami."},
        {"Współpraca z doradcą restrukturyzacyjnym",
         "Współpracujemy z doradcami restrukturyzacyjnymi, którzy pełnią funkcje nadzorcy lub zarządcy w postępowaniu."}
      ],
      notes_title: "Restrukturyzacja czy upadłość?",
      notes: [
        "Postępowanie restrukturyzacyjne może prowadzić dłużnik niewypłacalny albo zagrożony niewypłacalnością. Jego celem jest zawarcie układu z wierzycielami i uniknięcie ogłoszenia upadłości.",
        "Zarząd spółki ma obowiązek złożyć wniosek o ogłoszenie upadłości w ustawowym terminie od wystąpienia niewypłacalności — zwlekanie może prowadzić do osobistej odpowiedzialności członków zarządu. Dlatego decyzję o restrukturyzacji warto podjąć odpowiednio wcześnie."
      ],
      acts: [:pr, :pu]
    },
    %{
      slug: "obsluga-korporacyjna",
      audience: :business,
      home_name: "Obsługa korporacyjna i spory masowe",
      home_text:
        "Stała obsługa spółek. Mamy też doświadczenie we współpracy z innymi kancelariami przy obsłudze sporów masowych.",
      name: "Obsługa korporacyjna i spory masowe",
      title: "Obsługa korporacyjna spółek i spory masowe — Gdańsk",
      meta_title: "Obsługa korporacyjna spółek – kancelaria Gdańsk",
      description:
        "Stała obsługa korporacyjna spółek: uchwały, zgromadzenia, zmiany w KRS, a także współpraca przy obsłudze sporów masowych. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Zapewniamy stałą obsługę korporacyjną spółek i wspieramy inne kancelarie w prowadzeniu sporów masowych.",
      intro: [
        "Życie spółki to nie tylko bieżące kontrakty, ale też formalności korporacyjne: zgromadzenia wspólników, uchwały, zmiany w składzie organów i umowie spółki oraz zgłoszenia do rejestrów. Zaniedbania w tym zakresie mogą skutkować nieważnością uchwał lub sankcjami.",
        "Mamy też doświadczenie we współpracy z innymi kancelariami przy prowadzeniu sporów masowych — wymagających sprawnej organizacji pracy, konsekwentnej strategii procesowej i zarządzania dużą liczbą postępowań."
      ],
      scope: [
        {"Organy spółki i uchwały",
         "Przygotowanie i obsługa zgromadzeń wspólników i walnych zgromadzeń, projekty uchwał i protokoły."},
        {"Zmiany korporacyjne",
         "Zmiany umowy spółki, podwyższenie i obniżenie kapitału, zmiany w zarządzie oraz wpisy do KRS."},
        {"Spory korporacyjne",
         "Zaskarżanie uchwał, spory między wspólnikami oraz odpowiedzialność członków zarządu."},
        {"Spory masowe",
         "Współpraca z innymi kancelariami przy prowadzeniu dużej liczby podobnych postępowań sądowych."}
      ],
      notes_title: "Formalności, o których łatwo zapomnieć",
      notes: [
        "Zwyczajne zgromadzenie wspólników spółki z o.o. powinno odbyć się w ciągu sześciu miesięcy po zakończeniu roku obrotowego, a sprawozdanie finansowe trzeba następnie złożyć do repozytorium dokumentów finansowych.",
        "Zmiany w składzie zarządu czy w umowie spółki wymagają zgłoszenia do KRS, a zmiany beneficjentów rzeczywistych — do Centralnego Rejestru Beneficjentów Rzeczywistych."
      ],
      acts: [:ksh, :krs, :kpc]
    },
    %{
      slug: "nowe-technologie",
      audience: :business,
      home_name: "Sztuczna inteligencja i nowe technologie",
      home_text:
        "Wsparcie prawne przedsiębiorców przy wdrażaniu AI, automatyzacji procesów oraz korzystaniu z nowych technologii w biznesie.",
      name: "Sztuczna inteligencja i nowe technologie",
      title: "Prawo nowych technologii i AI — adwokat w Gdańsku",
      meta_title: "Prawo AI i nowych technologii – adwokat Gdańsk",
      description:
        "Wsparcie prawne przy wdrażaniu sztucznej inteligencji, automatyzacji i nowych technologii: umowy IT, AI Act, dane osobowe. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Wspieramy przedsiębiorców we wdrażaniu sztucznej inteligencji, automatyzacji procesów i nowych technologii — bezpiecznie i zgodnie z prawem.",
      intro: [
        "Sztuczna inteligencja i automatyzacja zmieniają sposób prowadzenia biznesu, ale rodzą też nowe pytania prawne: kto odpowiada za błędy systemu, do kogo należą prawa do wygenerowanych treści, jak chronić dane i tajemnice przedsiębiorstwa.",
        "Sami wykorzystujemy nowe technologie w pracy kancelarii, dlatego rozumiemy zarówno ich możliwości, jak i ryzyka."
      ],
      scope: [
        {"Wdrożenia AI",
         "Ocena prawna planowanych zastosowań sztucznej inteligencji, w tym w świetle unijnego aktu w sprawie sztucznej inteligencji."},
        {"Umowy IT",
         "Umowy z dostawcami oprogramowania i usług chmurowych, umowy wdrożeniowe, licencyjne i SLA."},
        {"Polityki i procedury",
         "Zasady korzystania z narzędzi AI przez pracowników i współpracowników, ochrona tajemnicy przedsiębiorstwa."},
        {"Dane i prawa autorskie",
         "Przetwarzanie danych osobowych w systemach AI oraz kwestie praw do danych wejściowych i wygenerowanych wyników."}
      ],
      notes_title: "Akt w sprawie sztucznej inteligencji",
      notes: [
        "Unijne rozporządzenie w sprawie sztucznej inteligencji (AI Act) wprowadza obowiązki zróżnicowane według poziomu ryzyka systemu AI. Jego przepisy wchodzą w życie etapami, dlatego warto już teraz sprawdzić, które z nich dotyczą Twojej firmy.",
        "Niezależnie od AI Act korzystanie z narzędzi AI podlega przepisom o ochronie danych osobowych, prawie autorskim i ochronie tajemnicy przedsiębiorstwa."
      ],
      acts: [:ai_act, :rodo]
    },
    %{
      slug: "sukcesja-firm",
      audience: :business,
      home_name: "Sukcesja i firmy rodzinne",
      home_text:
        "Planowanie sukcesji, zabezpieczenie ciągłości firmy oraz uporządkowanie kwestii majątkowych i korporacyjnych związanych ze zmianą pokoleniową.",
      name: "Sukcesja i firmy rodzinne",
      title: "Sukcesja firm rodzinnych — adwokat w Gdańsku",
      meta_title: "Sukcesja firmy rodzinnej – adwokat Gdańsk",
      description:
        "Planowanie sukcesji, zarząd sukcesyjny, fundacja rodzinna i zabezpieczenie ciągłości firmy przy zmianie pokoleniowej. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Pomagamy zaplanować przekazanie firmy następnemu pokoleniu tak, aby zachować jej ciągłość i uniknąć sporów w rodzinie.",
      intro: [
        "Sukcesja to jedno z największych wyzwań firm rodzinnych. Brak planu może sparaliżować działalność po śmierci właściciela, a niejasne zasady — doprowadzić do konfliktów między spadkobiercami.",
        "Łączymy wiedzę z zakresu prawa spółek, prawa spadkowego i prawa rodzinnego, aby przygotować rozwiązanie dopasowane do firmy i rodziny."
      ],
      scope: [
        {"Plan sukcesji",
         "Analiza struktury firmy i majątku rodziny oraz wybór sposobu przekazania przedsiębiorstwa."},
        {"Zarząd sukcesyjny",
         "Ustanowienie zarządcy sukcesyjnego w jednoosobowej działalności gospodarczej, aby firma mogła działać po śmierci właściciela."},
        {"Przekształcenia i fundacja rodzinna",
         "Przekształcenie działalności w spółkę, umowy wspólników oraz utworzenie fundacji rodzinnej."},
        {"Dokumenty spadkowe",
         "Testamenty, zapisy windykacyjne i umowy dotyczące przyszłego spadku w zakresie dopuszczalnym przez prawo."}
      ],
      notes_title: "Zarząd sukcesyjny i fundacja rodzinna",
      notes: [
        "Przedsiębiorca prowadzący jednoosobową działalność gospodarczą może za życia powołać zarządcę sukcesyjnego. Dzięki temu po jego śmierci firma może dalej działać — zachowuje NIP, umowy i zezwolenia — do czasu uregulowania spraw spadkowych.",
        "Od 2023 r. możliwe jest także utworzenie fundacji rodzinnej, która pozwala zarządzać majątkiem rodzinnym i przekazywać go kolejnym pokoleniom według zasad określonych przez fundatora."
      ],
      acts: [:sukcesja, :fundacja, :ksh, :kc]
    },
    %{
      slug: "prawo-medyczne",
      audience: :business,
      home_name: "Prawo medyczne i obsługa podmiotów leczniczych",
      home_text:
        "Obsługa prawna gabinetów, klinik i innych podmiotów leczniczych, w tym umów, dokumentacji, praw pacjenta oraz odpowiedzialności związanej z udzielaniem świadczeń.",
      name: "Prawo medyczne",
      title: "Prawo medyczne i obsługa podmiotów leczniczych — Gdańsk",
      meta_title: "Prawo medyczne – obsługa gabinetów i klinik, Gdańsk",
      description:
        "Obsługa prawna gabinetów, klinik i podmiotów leczniczych: umowy, dokumentacja medyczna, prawa pacjenta i odpowiedzialność. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Zapewniamy obsługę prawną gabinetów, klinik i innych podmiotów leczniczych — od umów i dokumentacji po spory z pacjentami.",
      intro: [
        "Działalność lecznicza podlega szczególnym wymogom — od rejestracji podmiotu, przez prowadzenie dokumentacji medycznej, po przestrzeganie praw pacjenta. Uchybienia w tym zakresie mogą prowadzić do odpowiedzialności cywilnej, zawodowej i administracyjnej.",
        "Pomagamy uporządkować dokumentację i umowy, a w razie sporu reprezentujemy podmioty lecznicze przed sądami."
      ],
      scope: [
        {"Umowy w ochronie zdrowia",
         "Umowy z lekarzami i personelem, umowy o udzielanie świadczeń, umowy najmu i współpracy z innymi podmiotami."},
        {"Dokumentacja i zgody",
         "Wzory zgód pacjenta, regulaminy organizacyjne, zasady prowadzenia i udostępniania dokumentacji medycznej."},
        {"Prawa pacjenta",
         "Wdrożenie procedur zapewniających przestrzeganie praw pacjenta i obsługa skarg."},
        {"Odpowiedzialność i spory",
         "Reprezentacja w sporach z pacjentami dotyczących odszkodowania i zadośćuczynienia."}
      ],
      notes_title: "Dokumentacja medyczna i RODO",
      notes: [
        "Podmiot leczniczy ma obowiązek prowadzić, przechowywać i udostępniać dokumentację medyczną na zasadach określonych w ustawie o prawach pacjenta. Dokumentacja jest też często kluczowym dowodem w sporze z pacjentem.",
        "Dane o zdrowiu należą do szczególnych kategorii danych osobowych, dlatego ich przetwarzanie wymaga szczególnej staranności również na gruncie RODO."
      ],
      acts: [:lecznicza, :pacjent, :rodo]
    },
    %{
      slug: "spory-gospodarcze",
      audience: :business,
      home_name: "Spory gospodarcze",
      home_text:
        "Reprezentacja przedsiębiorców w sporach z kontrahentami oraz postępowaniach sądowych związanych z prowadzeniem działalności.",
      name: "Spory gospodarcze",
      title: "Spory gospodarcze — adwokat w Gdańsku",
      meta_title: "Spory gospodarcze – adwokat Gdańsk",
      description:
        "Reprezentacja przedsiębiorców w sporach z kontrahentami i postępowaniach w sprawach gospodarczych. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Reprezentujemy przedsiębiorców w sporach z kontrahentami — w negocjacjach i przed sądem.",
      intro: [
        "Szczególne miejsce w naszej praktyce zajmuje reprezentacja Klientów przed sądami. Mamy wieloletnie doświadczenie w prowadzeniu postępowań sądowych, w tym spraw o znacznym stopniu złożoności.",
        "Zanim sprawa trafi do sądu, oceniamy jej perspektywy, ryzyka i koszty, a także możliwość polubownego rozwiązania."
      ],
      scope: [
        {"Spory z kontrahentami",
         "Spory o zapłatę, wykonanie umowy, kary umowne i odszkodowania między przedsiębiorcami."},
        {"Postępowanie w sprawach gospodarczych",
         "Reprezentacja w odrębnym postępowaniu w sprawach gospodarczych przed sądami gospodarczymi."},
        {"Negocjacje i mediacja",
         "Rozmowy ugodowe i mediacja jako sposób na szybsze i tańsze zakończenie sporu."},
        {"Zabezpieczenie roszczeń",
         "Wnioski o zabezpieczenie, które chronią interesy Klienta jeszcze przed zakończeniem procesu."}
      ],
      notes_title: "Sprawy gospodarcze rządzą się surowszymi regułami",
      notes: [
        "Spory między przedsiębiorcami rozpoznawane są w odrębnym postępowaniu w sprawach gospodarczych. Obowiązują w nim surowsze zasady dotyczące dowodów — co do zasady wszystkie twierdzenia i dowody należy powołać już w pozwie lub odpowiedzi na pozew.",
        "Dlatego przygotowanie sprawy przed jej wniesieniem do sądu ma w sporach gospodarczych szczególne znaczenie."
      ],
      acts: [:kpc, :kc]
    },
    %{
      slug: "rodo",
      audience: :business,
      home_name: "RODO i ochrona danych osobowych",
      home_text:
        "Wdrożenia RODO w przedsiębiorstwach i organizacjach, audyty zgodności, tworzenie i aktualizacja dokumentacji, projektowanie procedur ochrony danych oraz bieżące wsparcie w ich praktycznym stosowaniu.",
      name: "RODO i ochrona danych osobowych",
      title: "RODO i ochrona danych osobowych — adwokat w Gdańsku",
      meta_title: "RODO – wdrożenia i audyty, adwokat Gdańsk",
      description:
        "Wdrożenia RODO, audyty zgodności, dokumentacja i procedury ochrony danych oraz bieżące wsparcie. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy firmom i organizacjom przetwarzać dane osobowe zgodnie z RODO — w sposób praktyczny i dopasowany do skali działalności.",
      intro: [
        "Ochrona danych osobowych dotyczy każdej firmy, która ma klientów, pracowników lub kontrahentów. Dokumentacja RODO powinna odpowiadać rzeczywistym procesom w organizacji — szablonowe rozwiązania rzadko spełniają ten warunek.",
        "Zaczynamy od poznania, jakie dane i w jaki sposób przetwarza Twoja organizacja, a następnie przygotowujemy dokumentację i procedury, które da się stosować w praktyce."
      ],
      scope: [
        {"Wdrożenia RODO",
         "Kompleksowe wdrożenie zasad ochrony danych w przedsiębiorstwach i organizacjach."},
        {"Audyty zgodności",
         "Ocena, czy procesy przetwarzania danych są zgodne z RODO, i rekomendacje zmian."},
        {"Dokumentacja",
         "Klauzule informacyjne, rejestr czynności przetwarzania, umowy powierzenia, polityki i upoważnienia."},
        {"Procedury i bieżące wsparcie",
         "Procedury obsługi żądań osób, których dane dotyczą, i naruszeń ochrony danych oraz pomoc w ich stosowaniu."}
      ],
      notes_title: "Naruszenie ochrony danych — 72 godziny",
      notes: [
        "Administrator danych ma obowiązek zgłosić naruszenie ochrony danych osobowych do Prezesa Urzędu Ochrony Danych Osobowych bez zbędnej zwłoki, w miarę możliwości w ciągu 72 godzin od jego stwierdzenia — chyba że jest mało prawdopodobne, by naruszenie skutkowało ryzykiem dla praw lub wolności osób fizycznych.",
        "Dlatego procedurę postępowania w razie naruszenia warto mieć przygotowaną z wyprzedzeniem, zanim do niego dojdzie."
      ],
      acts: [:rodo, :uodo]
    }
  ]

  # "W skrócie" facts shown at the top of each service page: short, self-contained
  # statements with numbers, taken from that page's own text (keep them in sync).
  @summaries %{
    "rozwod" => [
      "Sąd: rozwód orzeka sąd okręgowy; przesłanką jest zupełny i trwały rozkład pożycia (art. 56 § 1 k.r.o.).",
      "Opłata od pozwu: 600 zł; przy rozwodzie bez orzekania o winie na zgodny wniosek sąd zwraca połowę, czyli 300 zł.",
      "Czas: rozwód bez orzekania o winie może zakończyć się na pierwszej rozprawie; spór o winę lub dzieci wydłuża sprawę."
    ],
    "sprawy-rodzinne" => [
      "Alimenty na dziecko: brak tabel i kwot minimalnych — decydują potrzeby dziecka i możliwości zarobkowe rodzica (art. 135 § 1 k.r.o.).",
      "Pozew o alimenty na dziecko i o ich podwyższenie: 0 zł opłaty sądowej.",
      "Obniżenie alimentów: opłata stała od 30 zł do 1 000 zł przy wartości przedmiotu sporu (suma świadczeń za rok) do 20 000 zł, powyżej — 5% tej wartości."
    ],
    "podzial-majatku" => [
      "Opłata od wniosku o podział majątku: 1 000 zł, a przy zgodnym projekcie podziału 300 zł.",
      "Kredyt: po rozwodzie oboje byli małżonkowie odpowiadają wobec banku solidarnie, dopóki bank nie zgodzi się na zmianę umowy.",
      "Wycena: mieszkanie z hipoteką wycenia się co do zasady według wartości rynkowej, bez odliczania kredytu (uchwała SN III CZP 14/19)."
    ],
    "upadlosc-konsumencka" => [
      "Dla kogo: osoba fizyczna nieprowadząca działalności gospodarczej, która jest niewypłacalna.",
      "Opłata od wniosku: 30 zł.",
      "Plan spłaty: do 3 lat, a przy umyślnym lub rażąco niedbałym doprowadzeniu do niewypłacalności od 3 do 7 lat.",
      "Umorzeniu nie podlegają m.in. alimenty i grzywny orzeczone przez sąd."
    ],
    "zawyzony-metraz" => [
      "Kwota: różnica powierzchni × cena za m² z umowy; w opublikowanych wyrokach ok. 11–24 tys. zł na nabywcę.",
      "Przedawnienie: co do zasady 6 lat, z końcem roku kalendarzowego.",
      "Nowelizacja z 13 lutego 2026 r. dotyczy tylko umów zawartych od tego dnia — wcześniejsze ocenia się według dotychczasowych reguł."
    ],
    "sprawy-o-zaplate" => [
      "Sprzeciw od nakazu zapłaty: 2 tygodnie od doręczenia.",
      "Przedawnienie: co do zasady 6 lat; świadczenia okresowe i roszczenia z działalności gospodarczej — 3 lata.",
      "Termin przedawnienia kończy się 31 grudnia, chyba że jest krótszy niż 2 lata."
    ],
    "odszkodowania" => [
      "Przedawnienie: 3 lata od dowiedzenia się o szkodzie i osobie zobowiązanej, nie później niż 10 lat od zdarzenia.",
      "Szkoda wynikła z przestępstwa: 20 lat od jego popełnienia.",
      "Roszczenia: odszkodowanie za szkodę majątkową, zadośćuczynienie za krzywdę i renta."
    ],
    "nieruchomosci" => [
      "Zasiedzenie nieruchomości: 20 lat w dobrej wierze, 30 lat w złej wierze.",
      "Sąd stwierdza zasiedzenie, które nastąpiło z mocy prawa — nie przyznaje własności.",
      "Zakres: współwłasność, służebności, wydanie nieruchomości, wpisy w księdze wieczystej."
    ],
    "prawa-konsumentow" => [
      "Odstąpienie od umowy zawartej na odległość: 14 dni, bez podawania przyczyny (z ustawowymi wyjątkami).",
      "Niedozwolone postanowienia umowne nie wiążą konsumenta; umowa obowiązuje w pozostałym zakresie.",
      "Zakres: reklamacje, odstąpienie od umowy, spory z przedsiębiorcami."
    ],
    "sprawy-spadkowe" => [
      "Przyjęcie lub odrzucenie spadku: 6 miesięcy od dowiedzenia się o tytule powołania.",
      "Zachowek: 1/2 udziału ustawowego, a 2/3 dla małoletnich i trwale niezdolnych do pracy.",
      "Roszczenie o zachowek z testamentu przedawnia się po 5 latach od ogłoszenia testamentu."
    ],
    "prawo-karne" => [
      "Reprezentujemy pokrzywdzonych na każdym etapie: przed policją, prokuraturą i sądem.",
      "Pokrzywdzony może składać wnioski dowodowe, przeglądać akta i działać jako oskarżyciel posiłkowy.",
      "W razie skazania sąd może orzec obowiązek naprawienia szkody lub zadośćuczynienia."
    ],
    "obsluga-przedsiebiorcow" => [
      "Zakres: doradztwo bieżące, umowy, ocena ryzyka prawnego, spory i windykacja.",
      "Początek współpracy: rozmowa o profilu działalności, a potem propozycja zakresu i kosztów obsługi."
    ],
    "zakladanie-spolek" => [
      "Wnioski do KRS składa się wyłącznie elektronicznie, przez Portal Rejestrów Sądowych.",
      "Sp. z o.o. można założyć w systemie S24 na wzorcu umowy — bez indywidualnych ustaleń wspólników.",
      "Formy: sp. z o.o., prosta spółka akcyjna, spółka akcyjna i spółki osobowe."
    ],
    "umowy" => [
      "Zakres: przygotowanie, weryfikacja i negocjowanie umów oraz regulaminów.",
      "Sprawdzamy m.in. odpowiedzialność i jej ograniczenia, kary umowne, terminy, rozwiązanie umowy i rozstrzyganie sporów.",
      "W umowach z konsumentami niedozwolone postanowienia nie wiążą klienta."
    ],
    "egzekucja-wierzytelnosci" => [
      "Podstawa egzekucji: tytuł wykonawczy, czyli wyrok lub nakaz zapłaty z klauzulą wykonalności.",
      "Przedawnienie roszczeń z działalności gospodarczej: co do zasady 3 lata, z końcem roku kalendarzowego.",
      "Droga: wezwanie do zapłaty, nakaz zapłaty, klauzula wykonalności, komornik."
    ],
    "restrukturyzacja" => [
      "Dla kogo: firma niewypłacalna albo zagrożona niewypłacalnością.",
      "Cel: układ z wierzycielami i uniknięcie ogłoszenia upadłości.",
      "4 postępowania: o zatwierdzenie układu, przyspieszone układowe, układowe i sanacyjne."
    ],
    "obsluga-korporacyjna" => [
      "Zwyczajne zgromadzenie wspólników sp. z o.o.: w ciągu 6 miesięcy po zakończeniu roku obrotowego.",
      "Zmiany w zarządzie i umowie spółki zgłasza się do KRS, a zmiany beneficjentów rzeczywistych — do CRBR.",
      "Zakres: uchwały i zgromadzenia, zmiany korporacyjne, spory korporacyjne i masowe."
    ],
    "nowe-technologie" => [
      "AI Act (rozporządzenie UE 2024/1689) nakłada obowiązki zależne od poziomu ryzyka systemu AI i wchodzi w życie etapami.",
      "Korzystanie z AI podlega też RODO, prawu autorskiemu i ochronie tajemnicy przedsiębiorstwa.",
      "Zakres: ocena wdrożeń AI, umowy IT i SLA, zasady korzystania z AI w firmie."
    ],
    "sukcesja-firm" => [
      "Zarządca sukcesyjny pozwala jednoosobowej firmie działać po śmierci właściciela — z zachowaniem NIP, umów i zezwoleń.",
      "Fundację rodzinną można utworzyć od 2023 r.",
      "Zakres: plan sukcesji, przekształcenia, testamenty i zapisy windykacyjne."
    ],
    "prawo-medyczne" => [
      "Dla kogo: gabinety, kliniki i inne podmioty lecznicze.",
      "Dokumentację medyczną prowadzi się i udostępnia według ustawy o prawach pacjenta; dane o zdrowiu to szczególna kategoria danych w RODO.",
      "Zakres: umowy z personelem, zgody pacjenta, regulaminy, spory z pacjentami."
    ],
    "spory-gospodarcze" => [
      "Spory między przedsiębiorcami toczą się w odrębnym postępowaniu w sprawach gospodarczych.",
      "Twierdzenia i dowody trzeba co do zasady powołać już w pozwie lub w odpowiedzi na pozew.",
      "Zakres: spory o zapłatę, wykonanie umowy i kary umowne, mediacja, zabezpieczenie roszczeń."
    ],
    "rodo" => [
      "Naruszenie ochrony danych zgłasza się do Prezesa UODO w ciągu 72 godzin od jego stwierdzenia.",
      "Zakres: wdrożenia, audyty zgodności, dokumentacja i procedury ochrony danych.",
      "Dokumentacja RODO musi odpowiadać rzeczywistym procesom w organizacji."
    ]
  }

  # Related practice areas linked from each service page ("Powiązane usługi").
  @related %{
    "rozwod" => ~w(podzial-majatku sprawy-rodzinne nieruchomosci),
    "sprawy-rodzinne" => ~w(rozwod podzial-majatku sprawy-spadkowe),
    "podzial-majatku" => ~w(rozwod sprawy-rodzinne nieruchomosci),
    "upadlosc-konsumencka" => ~w(sprawy-o-zaplate restrukturyzacja podzial-majatku),
    "zawyzony-metraz" => ~w(prawa-konsumentow nieruchomosci sprawy-o-zaplate),
    "sprawy-o-zaplate" => ~w(egzekucja-wierzytelnosci prawa-konsumentow odszkodowania),
    "odszkodowania" => ~w(sprawy-o-zaplate prawo-karne prawa-konsumentow),
    "nieruchomosci" => ~w(zawyzony-metraz sprawy-spadkowe podzial-majatku),
    "prawa-konsumentow" => ~w(zawyzony-metraz sprawy-o-zaplate odszkodowania),
    "sprawy-spadkowe" => ~w(sukcesja-firm nieruchomosci podzial-majatku),
    "prawo-karne" => ~w(odszkodowania sprawy-o-zaplate),
    "obsluga-przedsiebiorcow" => ~w(umowy obsluga-korporacyjna spory-gospodarcze),
    "zakladanie-spolek" => ~w(obsluga-korporacyjna umowy obsluga-przedsiebiorcow),
    "umowy" => ~w(obsluga-przedsiebiorcow spory-gospodarcze prawa-konsumentow),
    "egzekucja-wierzytelnosci" => ~w(sprawy-o-zaplate spory-gospodarcze restrukturyzacja),
    "restrukturyzacja" => ~w(egzekucja-wierzytelnosci upadlosc-konsumencka obsluga-korporacyjna),
    "obsluga-korporacyjna" => ~w(zakladanie-spolek obsluga-przedsiebiorcow spory-gospodarcze),
    "nowe-technologie" => ~w(rodo umowy obsluga-przedsiebiorcow),
    "sukcesja-firm" => ~w(sprawy-spadkowe zakladanie-spolek obsluga-korporacyjna),
    "prawo-medyczne" => ~w(rodo umowy odszkodowania),
    "spory-gospodarcze" => ~w(egzekucja-wierzytelnosci umowy sprawy-o-zaplate),
    "rodo" => ~w(nowe-technologie prawo-medyczne obsluga-przedsiebiorcow)
  }

  @doc "\"W skrócie\" points for a service page."
  def summary(service), do: Map.fetch!(@summaries, service.slug)

  @doc "Related services linked from a service page, in display order."
  def related(service), do: @related |> Map.fetch!(service.slug) |> Enum.map(&get/1)

  @doc "All service pages, in display order."
  def list, do: @services

  @doc "A service by slug, or `nil`."
  def get(slug), do: Enum.find(@services, &(&1.slug == slug))

  @doc "A service's legal acts as `{name, isap_url}` tuples."
  def acts(%{acts: keys}), do: Enum.map(keys, &act/1)

  @doc "`{name, url}` for an act key, e.g. `:kro` (ISAP) or `:rodo` (EUR-Lex)."
  def act(key) do
    case Map.fetch!(@acts, key) do
      {name, "http" <> _ = url} -> {name, url}
      {name, id} -> {name, @isap <> id}
    end
  end

  # Question form of `notes_title` where the heading is not already a question.
  @faq_questions %{
    "podzial-majatku" => "Co dzieje się z kredytem hipotecznym przy podziale majątku?",
    "sprawy-o-zaplate" => "Ile czasu jest na sprzeciw od nakazu zapłaty?",
    "nieruchomosci" => "Kiedy można zasiedzieć nieruchomość?",
    "prawa-konsumentow" => "Czy można odstąpić od umowy zawartej przez internet?",
    "sprawy-spadkowe" => "Ile jest czasu na przyjęcie lub odrzucenie spadku?",
    "prawo-karne" => "Jakie prawa ma pokrzywdzony w postępowaniu karnym?",
    "zakladanie-spolek" => "Jak zarejestrować spółkę w KRS?",
    "egzekucja-wierzytelnosci" => "Co jest potrzebne do egzekucji komorniczej?",
    "obsluga-korporacyjna" => "O jakich formalnościach korporacyjnych trzeba pamiętać?",
    "nowe-technologie" => "Czy AI Act dotyczy mojej firmy?",
    "sukcesja-firm" => "Jak zabezpieczyć firmę na wypadek śmierci właściciela?",
    "prawo-medyczne" => "Jakie obowiązki ma podmiot leczniczy wobec dokumentacji medycznej?",
    "spory-gospodarcze" => "Czym różni się postępowanie w sprawach gospodarczych?",
    "rodo" => "Ile czasu jest na zgłoszenie naruszenia ochrony danych osobowych?"
  }

  @doc """
  Visible FAQ for a service page (also its `FAQPage` JSON-LD): the topic
  question answered by the service notes, then the extended FAQ.
  """
  def faq(service) do
    extra =
      case KralukKurkierewicz.ServiceDetails.get(service.slug) do
        nil -> []
        details -> details.faq
      end

    [{Map.get(@faq_questions, service.slug, service.notes_title), Enum.join(service.notes, " ")}] ++
      extra
  end

  # Day the service pages were first published; pages without extended content
  # keep this date until their text really changes.
  @published ~D[2026-11-22]

  @doc """
  Date of the last real content change of a service page (sitemap `lastmod`).
  Set per page — never derived from the deploy date.
  """
  def updated(service) do
    case KralukKurkierewicz.ServiceDetails.get(service.slug) do
      %{updated: date} -> date
      nil -> @published
    end
  end

  @doc "Services for one home page column (`:private` or `:business`), in display order."
  def home(audience) do
    @home_order |> Keyword.fetch!(audience) |> Enum.map(&get/1)
  end
end
