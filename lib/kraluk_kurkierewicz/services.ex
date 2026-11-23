defmodule KralukKurkierewicz.Services do
  @moduledoc """
  Service (practice area) pages served at `/uslugi/<slug>`.

  Content is plain data rendered by `page_html/service.html.heex`. Facts here must
  stay consistent with the home page and the related blog posts (linked through
  `KralukKurkierewicz.Blog.Post.service`). Legal acts link to ISAP via their
  `WDU…` document id, or to a full URL (EU regulations on EUR-Lex).

  `intro` paragraphs, `local/1` and the `ServiceDetails` section texts may link
  to other pages with `[label](/uslugi/slug)` (see `PageHTML.linked/1`). FAQ
  answers and `notes` stay plain text — they are copied into the JSON-LD.

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
    fundacja: {"Ustawa z dnia 26 stycznia 2023 r. o fundacji rodzinnej", "WDU20230000326"},
    fa:
      {"Ustawa z dnia 7 września 2007 r. o pomocy osobom uprawnionym do alimentów",
       "WDU20071921378"},
    uth:
      {"Ustawa z dnia 8 marca 2013 r. o przeciwdziałaniu nadmiernym opóźnieniom w transakcjach handlowych",
       "WDU20130000403"},
    uoc:
      {"Ustawa z dnia 22 maja 2003 r. o ubezpieczeniach obowiązkowych, Ubezpieczeniowym Funduszu Gwarancyjnym i Polskim Biurze Ubezpieczycieli Komunikacyjnych",
       "WDU20031241152"}
  }

  # Order of the two "Specjalizacje" columns on the home page.
  @home_order [
    private:
      ~w(sprawy-o-zaplate odszkodowania zawyzony-metraz nieruchomosci sluzebnosc-przesylu rozwod alimenty
               sprawy-rodzinne podzial-majatku prawa-konsumentow upadlosc-konsumencka
               sprawy-spadkowe zachowek prawo-karne),
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
      meta_title: "Adwokat rozwód Gdańsk - pozew, wina, dzieci, koszty",
      description:
        "Rozwód w Gdańsku: pozew o rozwód, orzekanie o winie, władza rodzicielska, alimenty i mieszkanie. Opłata sądowa 600 zł. Kancelaria adwokacka Kraluk Kurkierewicz.",
      lead:
        "Prowadzimy sprawy rozwodowe od pierwszej rozmowy do prawomocnego wyroku — z orzekaniem o winie i bez, także gdy trzeba uregulować sprawy dzieci, alimentów i wspólnego mieszkania.",
      intro: [
        "Rozwód orzeka sąd okręgowy, jeżeli między małżonkami nastąpił zupełny i trwały rozkład pożycia (art. 56 § 1 Kodeksu rodzinnego i opiekuńczego). Opłata sądowa od pozwu o rozwód wynosi 600 zł. Gdy małżonkowie zgodnie wnoszą o rozwód bez orzekania o winie, sprawa może zakończyć się już na pierwszej rozprawie, a sąd zwraca połowę opłaty; orzekanie o winie wymaga postępowania dowodowego i wyraźnie wydłuża sprawę.",
        "W wyroku rozwodowym sąd rozstrzyga nie tylko o rozwiązaniu małżeństwa, ale też o władzy rodzicielskiej, kontaktach z dziećmi, alimentach i sposobie korzystania ze wspólnego mieszkania. Dlatego przed złożeniem pozwu ustalamy z Klientem, o co wnosić w każdym z tych punktów i jakimi dowodami to poprzeć.",
        "Reprezentujemy Klientów przed Sądem Okręgowym w Gdańsku oraz przed innymi sądami w Polsce — zarówno stronę wnoszącą pozew, jak i pozwaną. Poza sprawą rozwodową osobno opisujemy [alimenty](/uslugi/alimenty) oraz kontakty z dzieckiem i władzę rodzicielską — na stronie o [sprawach rodzinnych](/uslugi/sprawy-rodzinne)."
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
        "Władza rodzicielska, kontakty z dziećmi, opieka naprzemienna, separacja oraz ustalenie pochodzenia dziecka.",
      name: "Sprawy rodzinne",
      title: "Kontakty z dzieckiem i władza rodzicielska — adwokat w Gdańsku",
      meta_title: "Adwokat sprawy rodzinne Gdańsk - kontakty z dzieckiem",
      description:
        "Kontakty z dzieckiem, władza rodzicielska, opieka naprzemienna, ustalenie ojcostwa i separacja. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Prowadzimy sprawy o kontakty z dzieckiem i władzę rodzicielską z dbałością o interesy Klienta i dziecka — od pierwszej rozmowy, przez wniosek i dowody, po reprezentację przed sądem.",
      intro: [
        "O kontaktach z dzieckiem, władzy rodzicielskiej i miejscu pobytu dziecka rozstrzyga sąd opiekuńczy, czyli sąd rejonowy właściwy dla miejsca zamieszkania dziecka. Opłata od wniosku wynosi 100 zł. Sąd kieruje się przede wszystkim dobrem dziecka, a nie oczekiwaniami rodziców — dlatego o wyniku decydują dowody pokazujące, jak naprawdę wygląda opieka nad dzieckiem.",
        "Sprawy rodzinne wymagają nie tylko znajomości przepisów i doświadczenia procesowego, ale też indywidualnego podejścia. Każdą sprawę zaczynamy od rozmowy o Twojej sytuacji i celach, a następnie przedstawiamy możliwe rozwiązania, przewidywany czas trwania postępowania oraz jego koszty.",
        "Osobno opisujemy [alimenty](/uslugi/alimenty) oraz [rozwód](/uslugi/rozwod), w którym sąd okręgowy rozstrzyga o sprawach dzieci w jednym wyroku."
      ],
      scope: [
        {"Kontakty z dzieckiem",
         "Ustalenie, zmiana lub ograniczenie kontaktów, zabezpieczenie kontaktów na czas postępowania oraz egzekwowanie orzeczenia, gdy drugi rodzic go nie wykonuje."},
        {"Władza rodzicielska",
         "Sprawy o powierzenie, ograniczenie, zawieszenie lub pozbawienie władzy rodzicielskiej, ustalenie miejsca pobytu dziecka i rozstrzygnięcie o istotnych sprawach dziecka."},
        {"Opieka naprzemienna i porozumienie rodzicielskie",
         "Przygotowanie porozumienia o sposobie wykonywania władzy rodzicielskiej i harmonogramu opieki, który sąd może zatwierdzić."},
        {"Pochodzenie dziecka i separacja",
         "Sprawy o ustalenie lub zaprzeczenie ojcostwa i macierzyństwa oraz reprezentacja w sprawie o separację."}
      ],
      notes_title: "Jak sąd ustala kontakty z dzieckiem?",
      notes: [
        "Jeżeli rodzice nie mogą dojść do porozumienia, sąd opiekuńczy ustala kontakty, kierując się dobrem dziecka i biorąc pod uwagę jego rozsądne życzenia. Przepisy nie przewidują jednego schematu — harmonogram zależy od wieku dziecka, jego dotychczasowej więzi z rodzicem, odległości między miejscami zamieszkania i trybu pracy rodziców.",
        "Kontakty są prawem i obowiązkiem zarówno rodzica, jak i dziecka, i nie zależą od władzy rodzicielskiej. Postanowienie o kontaktach sąd może zmienić, jeżeli wymaga tego dobro dziecka."
      ],
      acts: [:kro, :kpc, :uksc]
    },
    %{
      slug: "alimenty",
      audience: :private,
      home_name: "Alimenty",
      home_text:
        "Ustalenie, podwyższenie i obniżenie alimentów, zabezpieczenie na czas procesu oraz egzekucja zaległych świadczeń.",
      name: "Alimenty",
      title: "Alimenty — adwokat w Gdańsku",
      meta_title: "Adwokat alimenty Gdańsk - pozew, podwyższenie, zaległości",
      description:
        "Pozew o alimenty, podwyższenie i obniżenie alimentów, zabezpieczenie na czas procesu, zaległe alimenty. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy ustalić, podwyższyć lub obniżyć alimenty i wyegzekwować zaległe świadczenia — od zestawienia kosztów utrzymania dziecka po reprezentację przed sądem.",
      intro: [
        "Sprawy o alimenty rozpoznaje sąd rejonowy. Pozew o alimenty na dziecko, także o ich podwyższenie, jest wolny od opłat sądowych; w sprawie o obniżenie alimentów opłata zależy od wartości przedmiotu sporu (przy wartości do 20 000 zł jest stała, powyżej wynosi 5%). Przepisy nie przewidują tabel ani minimalnej kwoty alimentów: o ich wysokości decydują usprawiedliwione potrzeby dziecka oraz zarobkowe i majątkowe możliwości rodzica.",
        "Reprezentujemy zarówno rodziców dochodzących alimentów na dziecko, jak i osoby zobowiązane do ich płacenia — także w sprawach o zabezpieczenie alimentów na czas procesu i o uchylenie obowiązku alimentacyjnego.",
        "Kontakty z dzieckiem i władzę rodzicielską opisujemy na stronie o [sprawach rodzinnych](/uslugi/sprawy-rodzinne), a alimenty orzekane w wyroku rozwodowym — na stronie o [rozwodzie](/uslugi/rozwod)."
      ],
      scope: [
        {"Pozew o alimenty",
         "Przygotowanie pozwu z zestawieniem kosztów utrzymania dziecka i wnioskiem o zabezpieczenie alimentów na czas trwania procesu."},
        {"Podwyższenie i obniżenie alimentów",
         "Wykazanie zmiany stosunków — wzrostu potrzeb dziecka albo zmiany możliwości zarobkowych rodzica — oraz obrona przed nieuzasadnionym żądaniem."},
        {"Uchylenie obowiązku alimentacyjnego",
         "Sprawy o ustalenie, że obowiązek wygasł, na przykład wobec pełnoletniego dziecka, które może utrzymać się samodzielnie."},
        {"Zaległe alimenty",
         "Wniosek do komornika, świadczenia z funduszu alimentacyjnego i zawiadomienie o przestępstwie niealimentacji."}
      ],
      notes_title: "Ile wynoszą alimenty na dziecko w 2026 roku?",
      notes: [
        "Przepisy nie przewidują jednej tabeli ani minimalnej kwoty alimentów. Zgodnie z art. 135 § 1 Kodeksu rodzinnego i opiekuńczego sąd bierze pod uwagę usprawiedliwione potrzeby dziecka oraz zarobkowe i majątkowe możliwości rodzica — nie tylko jego aktualne wynagrodzenie.",
        "Znaczenie ma także osobista opieka nad dzieckiem: rodzic, który na co dzień się nim zajmuje, realizuje w ten sposób część obowiązku alimentacyjnego. Dlatego tak ważne jest rzetelne zestawienie kosztów utrzymania dziecka, poparte rachunkami i innymi dokumentami."
      ],
      acts: [:kro, :kpc, :uksc, :fa, :kk]
    },
    %{
      slug: "podzial-majatku",
      audience: :private,
      home_name: "Majątek małżonków",
      home_text:
        "Podział majątku wspólnego, rozliczenia nakładów i wydatków oraz inne spory majątkowe między małżonkami.",
      name: "Podział majątku małżonków",
      title: "Podział majątku po rozwodzie — adwokat w Gdańsku",
      meta_title: "Podział majątku po rozwodzie - adwokat Gdańsk",
      description:
        "Podział majątku wspólnego, mieszkanie z kredytem hipotecznym, rozliczenie nakładów i spłaconych rat. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy uporządkować sprawy majątkowe po rozwodzie lub ustaniu wspólności — tak, aby podział był sprawiedliwy, a jego skutki przewidywalne.",
      intro: [
        "Majątek wspólny można podzielić umową — u notariusza, jeżeli obejmuje nieruchomość — albo przed sądem rejonowym. Opłata od wniosku o podział majątku wynosi 1 000 zł, a przy zgodnym projekcie podziału 300 zł. Rozwód nie zmienia odpowiedzialności za wspólny kredyt: wobec banku oboje byli małżonkowie odpowiadają solidarnie, dopóki bank nie zgodzi się na zmianę umowy.",
        "Podział majątku wspólnego to często najtrudniejszy finansowo etap zakończenia małżeństwa. Trzeba ustalić, co wchodzi w skład majątku, jaka jest jego wartość, kto poniósł jakie nakłady oraz jak rozliczyć zobowiązania — zwłaszcza kredyt hipoteczny.",
        "Doradzamy przy podziale umownym, a gdy porozumienie nie jest możliwe, reprezentujemy Klientów w sądowym postępowaniu o podział majątku. Samą sprawę rozwodową opisujemy na stronie [rozwód — adwokat w Gdańsku](/uslugi/rozwod)."
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
      meta_title: "Upadłość konsumencka - adwokat Gdańsk",
      description:
        "Ocena możliwości oddłużenia, przygotowanie wniosku o upadłość konsumencką i reprezentacja w postępowaniu. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy ocenić, czy upadłość konsumencka jest właściwym rozwiązaniem, przygotować wniosek i przejść przez postępowanie aż do oddłużenia.",
      intro: [
        "Upadłość konsumencką może ogłosić osoba fizyczna nieprowadząca działalności gospodarczej, która stała się niewypłacalna. Wniosek składa się do sądu upadłościowego, a opłata od niego wynosi 30 zł. Plan spłaty wierzycieli trwa co do zasady do 3 lat, a od 3 do 7 lat — gdy dłużnik doprowadził do niewypłacalności umyślnie lub wskutek rażącego niedbalstwa. Umorzeniu nie podlegają między innymi alimenty i grzywny.",
        "Upadłość konsumencka może prowadzić do umorzenia części albo całości niespłaconych zobowiązań, ale wiąże się z obowiązkami i może oznaczać sprzedaż majątku. Przed złożeniem wniosku warto zrozumieć, jak postępowanie wpłynie na mieszkanie, dochody i rodzinę.",
        "Podczas konsultacji omawiamy możliwe skutki postępowania dla zadłużenia, majątku i bliskich oraz ustalamy zakres potrzebnej pomocy. Jeżeli wierzyciel uzyskał już nakaz zapłaty, sprawdzamy też, czy warto go zaskarżyć — piszemy o tym na stronie o [sprawach o zapłatę](/uslugi/sprawy-o-zaplate)."
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
      meta_title: "Zaniżony metraż mieszkania - adwokat, zwrot od dewelopera",
      description:
        "Deweloper zaniżył metraż albo wliczył ścianki działowe do powierzchni? Dochodzimy zwrotu części ceny w całej Polsce, także w Warszawie. Adwokaci z Gdańska.",
      lead:
        "Jeżeli rzeczywista powierzchnia mieszkania jest mniejsza niż ta, za którą zapłaciłeś, przeanalizujemy umowę i ocenimy, czy możesz odzyskać od dewelopera część ceny.",
      intro: [
        "Jeżeli deweloper wliczył do powierzchni użytkowej mieszkania stałe ścianki działowe, nabywca może żądać zwrotu części ceny: różnicy powierzchni pomnożonej przez cenę metra kwadratowego z umowy. W wyrokach opublikowanych przez sądy zasądzano od ok. 11 tys. do ok. 24 tys. zł na jednego nabywcę. Roszczenie przedawnia się co do zasady po 6 latach, a nowelizacja ustawy deweloperskiej z 13 lutego 2026 r. dotyczy wyłącznie umów zawartych od tego dnia.",
        "Nabywcy opisują ten problem różnie: jako zaniżony metraż — bo mieszkanie jest mniejsze, niż wynika z umowy — albo zawyżony metraż, bo deweloper policzył więcej metrów, niż lokal rzeczywiście ma. Chodzi o to samo: zapłatę za powierzchnię, której nie ma. Potocznie mówi się o odszkodowaniu lub rekompensacie za metraż, a prawnie jest to zwrot nadpłaconej części ceny wraz z odsetkami.",
        "Cena mieszkania od dewelopera to zwykle iloczyn powierzchni użytkowej i ceny za metr kwadratowy. Część deweloperów wliczała do powierzchni użytkowej powierzchnię zajętą przez ścianki działowe — nabywca płacił więc za metry, z których nie może korzystać. Przy obecnych cenach nawet różnica jednego lub dwóch metrów oznacza realną kwotę.",
        "Sądy przyznają rację kupującym przede wszystkim wtedy, gdy ściany mają charakter stały, a umowa nie informowała w jasny sposób o metodzie pomiaru. To jeden z przykładów sporów, w których pomagamy w ramach [ochrony praw konsumentów](/uslugi/prawa-konsumentow)."
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
      meta_title: "Nakaz zapłaty i sprawy o zapłatę - adwokat Gdańsk",
      description:
        "Pozew o zapłatę, sprzeciw od nakazu zapłaty, zarzut przedawnienia. Dochodzimy należności i bronimy przed niezasadnymi żądaniami. Kancelaria adwokacka w Gdańsku.",
      lead:
        "Pomagamy odzyskać pieniądze, które Ci się należą, i bronimy przed żądaniami zapłaty, które nie mają podstaw.",
      intro: [
        "Sprawy o zapłatę dotyczą najróżniejszych sytuacji: niezapłaconej pożyczki, wynagrodzenia za wykonaną pracę, zwrotu zaliczki czy kary umownej. Równie często zgłaszają się do nas osoby, które otrzymały wezwanie do zapłaty, nakaz zapłaty albo pozew i nie wiedzą, czy roszczenie jest zasadne.",
        "Zaczynamy od analizy dokumentów i oceny szans, a następnie rekomendujemy sposób działania — od wezwania do zapłaty i negocjacji po postępowanie sądowe. Ta strona dotyczy przede wszystkim spraw osób prywatnych; przedsiębiorcom, którzy odzyskują niezapłacone faktury, polecamy stronę o [windykacji i egzekucji wierzytelności](/uslugi/egzekucja-wierzytelnosci)."
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
      acts: [:kc, :kpc, :uksc]
    },
    %{
      slug: "odszkodowania",
      audience: :private,
      home_name: "Odszkodowania i zadośćuczynienia",
      home_text:
        "Dochodzenie roszczeń za szkody majątkowe i niemajątkowe, w szczególności wynikające z czynów niedozwolonych i wypadków.",
      name: "Odszkodowania i zadośćuczynienia",
      title: "Odszkodowania i zadośćuczynienia — adwokat w Gdańsku",
      meta_title: "Odszkodowania i zadośćuczynienia - adwokat Gdańsk",
      description:
        "Dochodzenie odszkodowania i zadośćuczynienia po wypadkach i innych zdarzeniach, także od ubezpieczyciela. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy uzyskać należne odszkodowanie za szkodę majątkową i zadośćuczynienie za krzywdę — w rozmowach z ubezpieczycielem i przed sądem.",
      intro: [
        "Wypadek komunikacyjny, upadek na nieodśnieżonym chodniku, pogryzienie przez psa czy zalanie mieszkania — każde z tych zdarzeń może rodzić roszczenia wobec sprawcy lub jego ubezpieczyciela. Proponowane przez ubezpieczycieli kwoty nie zawsze odpowiadają rzeczywistym stratom.",
        "Oceniamy, komu i w jakiej wysokości przysługują roszczenia, gromadzimy dowody i prowadzimy sprawę aż do uzyskania świadczenia. Jeżeli szkoda wynika z przestępstwa, działamy także jako [pełnomocnik pokrzywdzonego](/uslugi/prawo-karne) w postępowaniu karnym."
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
      acts: [:kc, :uoc, :kpc, :uksc]
    },
    %{
      slug: "nieruchomosci",
      audience: :private,
      home_name: "Nieruchomości",
      home_text:
        "Sprawy dotyczące własności, posiadania, zasiedzenia, służebności, wydania nieruchomości oraz rozliczeń związanych z nieruchomościami.",
      name: "Nieruchomości",
      title: "Sprawy o nieruchomości — adwokat w Gdańsku",
      meta_title: "Sprawy o nieruchomości - adwokat Gdańsk",
      description:
        "Własność, zasiedzenie, służebności, zniesienie współwłasności, wydanie nieruchomości i księgi wieczyste. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy w sporach o własność i korzystanie z nieruchomości oraz w porządkowaniu ich stanu prawnego.",
      intro: [
        "Nieruchomość to dla wielu osób najcenniejszy składnik majątku, a spory jej dotyczące bywają długotrwałe i emocjonalne — zwłaszcza między sąsiadami lub członkami rodziny. Kluczowe jest dokładne ustalenie stanu prawnego i faktycznego jeszcze przed podjęciem działań.",
        "Analizujemy księgi wieczyste, umowy i dokumentację geodezyjną, a następnie proponujemy rozwiązanie — polubowne lub sądowe. Osobno opisujemy [podział majątku małżonków](/uslugi/podzial-majatku), [dział spadku](/uslugi/sprawy-spadkowe) oraz roszczenia nabywców wobec deweloperów z tytułu [zawyżonego metrażu](/uslugi/zawyzony-metraz)."
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
      acts: [:kc, :kw, :kpc, :uksc]
    },
    %{
      slug: "sluzebnosc-przesylu",
      audience: :private,
      home_name: "Służebność przesyłu i słupy na działce",
      home_text:
        "Wynagrodzenie za słupy, linie energetyczne i gazociągi na prywatnej działce oraz uregulowanie służebności przesyłu.",
      name: "Służebność przesyłu",
      title: "Służebność przesyłu — adwokat w Gdańsku",
      meta_title: "Służebność przesyłu Gdańsk - wynagrodzenie za słupy",
      description:
        "Słup, linia energetyczna lub gazociąg na działce? Dochodzimy wynagrodzenia za służebność przesyłu i bezumowne korzystanie. Kancelaria adwokacka w Gdańsku.",
      lead:
        "Pomagamy właścicielom działek, przez które biegną linie energetyczne, gazociągi lub wodociągi, uzyskać wynagrodzenie i uregulować stan prawny urządzeń.",
      intro: [
        "Jeżeli na działce stoją słupy albo biegną linie i rury należące do przedsiębiorcy, a nie ma on do tego tytułu prawnego, właściciel może żądać ustanowienia służebności przesyłu za wynagrodzeniem oraz zapłaty za bezumowne korzystanie z gruntu. Przepisy nie przewidują stawek — wysokość wynagrodzenia zależy od rodzaju urządzeń i tego, jak ograniczają korzystanie z nieruchomości.",
        "Przez lata przedsiębiorstwa przesyłowe broniły się zarzutem zasiedzenia służebności. Wyrokiem z 2 grudnia 2025 r. (P 10/16) Trybunał Konstytucyjny zakwestionował zasiedzenie takiej służebności przed 3 sierpnia 2008 r., co zmieniło sytuację wielu właścicieli — także tych, którzy wcześniej przegrali sprawę.",
        "Pozostałe spory dotyczące gruntów — zasiedzenie, współwłasność i drogę konieczną — opisujemy na stronie o [sprawach o nieruchomości](/uslugi/nieruchomosci)."
      ],
      scope: [
        {"Analiza stanu prawnego",
         "Sprawdzenie księgi wieczystej, decyzji administracyjnych i umów oraz ustalenie, czy przedsiębiorca ma tytuł prawny do korzystania z działki."},
        {"Wezwanie i negocjacje z operatorem",
         "Wystąpienie do przedsiębiorcy przesyłowego o zawarcie umowy i zapłatę oraz negocjowanie wysokości wynagrodzenia."},
        {"Ustanowienie służebności przesyłu przed sądem",
         "Wniosek o ustanowienie służebności za wynagrodzeniem i udział w postępowaniu z opinią biegłego rzeczoznawcy."},
        {"Bezumowne korzystanie i wznowienie postępowania",
         "Pozew o wynagrodzenie za bezumowne korzystanie z nieruchomości oraz ocena możliwości wznowienia prawomocnie przegranej sprawy."}
      ],
      notes_title: "Czy za słup energetyczny na działce należy się odszkodowanie?",
      notes: [
        "Właścicielowi mogą przysługiwać dwa roszczenia: o ustanowienie służebności przesyłu za odpowiednim wynagrodzeniem oraz o wynagrodzenie za bezumowne korzystanie z nieruchomości za okres nieobjęty przedawnieniem. Warunkiem jest to, że przedsiębiorca nie ma tytułu prawnego do korzystania z działki — umowy, służebności, decyzji administracyjnej ani orzeczenia stwierdzającego zasiedzenie.",
        "To samo dotyczy innych urządzeń przesyłowych: linii kablowych, gazociągów, wodociągów i sieci ciepłowniczej."
      ],
      acts: [:kc, :kpc, :uksc]
    },
    %{
      slug: "prawa-konsumentow",
      audience: :private,
      home_name: "Ochrona praw konsumentów",
      home_text:
        "Dochodzenie roszczeń wynikających z umów konsumenckich oraz ochrona przed nieuczciwymi praktykami przedsiębiorców.",
      name: "Ochrona praw konsumentów",
      title: "Ochrona praw konsumentów — adwokat w Gdańsku",
      meta_title: "Prawa konsumenta - adwokat Gdańsk",
      description:
        "Reklamacje, odstąpienie od umowy, niedozwolone postanowienia umowne i spory z przedsiębiorcami. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy konsumentom egzekwować ich prawa wobec sprzedawców, usługodawców i innych przedsiębiorców.",
      intro: [
        "Przepisy zapewniają konsumentom szeroką ochronę, ale w praktyce przedsiębiorcy nie zawsze ją respektują — odmawiają uwzględnienia reklamacji, utrudniają odstąpienie od umowy albo stosują postanowienia, które nie powinny wiązać klienta.",
        "Oceniamy umowę i okoliczności sprawy, przygotowujemy pisma i reprezentujemy Klientów w sporach z przedsiębiorcami. Przykładem sporu konsumenckiego są roszczenia nabywców mieszkań o zwrot części ceny za [zawyżony metraż](/uslugi/zawyzony-metraz)."
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
        "Stwierdzenie nabycia spadku, dział spadku, testamenty oraz odpowiedzialność za długi spadkowe.",
      name: "Sprawy spadkowe",
      title: "Sprawy spadkowe — adwokat w Gdańsku",
      meta_title: "Adwokat sprawy spadkowe Gdańsk - spadek, dział, testament",
      description:
        "Stwierdzenie nabycia spadku, dział spadku, testamenty, odrzucenie spadku i długi spadkowe. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy uporządkować sprawy spadkowe — od stwierdzenia nabycia spadku, przez przyjęcie lub odrzucenie spadku, po dział spadku.",
      intro: [
        "Sprawy spadkowe zbiegają się zwykle z trudnym okresem po stracie bliskiej osoby. Jednocześnie wymagają podjęcia decyzji w ściśle określonych terminach — przede wszystkim co do przyjęcia lub odrzucenia spadku.",
        "Wyjaśniamy, jakie prawa i obowiązki przysługują spadkobiercom, a następnie prowadzimy sprawę przed sądem lub notariuszem. Roszczenia osób pominiętych w testamencie opisujemy osobno na stronie o [zachowku](/uslugi/zachowek); gdy w skład spadku wchodzi przedsiębiorstwo, pomagamy także zaplanować [sukcesję firmy](/uslugi/sukcesja-firm)."
      ],
      scope: [
        {"Stwierdzenie nabycia spadku",
         "Wniosek do sądu lub przygotowanie do aktu poświadczenia dziedziczenia u notariusza."},
        {"Dział spadku",
         "Podział majątku spadkowego między spadkobierców, w tym nieruchomości i przedsiębiorstwa, wraz z rozliczeniem darowizn i nakładów."},
        {"Testamenty",
         "Ocena ważności testamentu, spory o jego treść oraz wykonanie zapisów i poleceń."},
        {"Długi spadkowe",
         "Przyjęcie lub odrzucenie spadku, także w imieniu dzieci, oraz ograniczenie odpowiedzialności za długi spadkowe."}
      ],
      notes_title: "Sześć miesięcy na decyzję o spadku",
      notes: [
        "Spadkobierca może przyjąć spadek wprost, przyjąć go z dobrodziejstwem inwentarza albo go odrzucić w terminie sześciu miesięcy od dnia, w którym dowiedział się o tytule swojego powołania. Brak oświadczenia w tym terminie oznacza przyjęcie spadku z dobrodziejstwem inwentarza.",
        "Oświadczenie składa się przed sądem albo przed notariuszem. Przyjęcie spadku z dobrodziejstwem inwentarza ogranicza odpowiedzialność za długi spadkowe do wartości odziedziczonego majątku."
      ],
      acts: [:kc, :kpc, :kro, :uksc]
    },
    %{
      slug: "zachowek",
      audience: :private,
      home_name: "Zachowek",
      home_text:
        "Dochodzenie zachowku od spadkobierców i obdarowanych oraz obrona przed takim roszczeniem.",
      name: "Zachowek",
      title: "Zachowek — adwokat w Gdańsku",
      meta_title: "Zachowek - adwokat Gdańsk: ile wynosi, komu przysługuje",
      description:
        "Zachowek po rodzicach: komu przysługuje, ile wynosi, zachowek od darowizny, przedawnienie i pozew. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Dochodzimy zachowku dla osób pominiętych w testamencie lub przy darowiznach i bronimy spadkobierców oraz obdarowanych przed zawyżonymi żądaniami.",
      intro: [
        "Zachowek to roszczenie o zapłatę, które chroni najbliższych spadkodawcy: zstępnych, małżonka i rodziców. Wynosi połowę wartości udziału, który przypadłby uprawnionemu przy dziedziczeniu ustawowym, a dwie trzecie — gdy uprawniony jest małoletni albo trwale niezdolny do pracy. Roszczenie przedawnia się z upływem pięciu lat.",
        "W praktyce spór dotyczy najczęściej nie samego prawa do zachowku, lecz jego wysokości: wyceny nieruchomości, doliczenia darowizn sprzed lat i tego, co uprawniony sam już otrzymał od spadkodawcy. Dlatego zaczynamy od ustalenia składu spadku i historii darowizn.",
        "Pozostałe sprawy po śmierci bliskiej osoby — stwierdzenie nabycia spadku, dział spadku i odrzucenie spadku — opisujemy na stronie o [sprawach spadkowych](/uslugi/sprawy-spadkowe)."
      ],
      scope: [
        {"Obliczenie zachowku",
         "Ustalenie wartości spadku, doliczenie darowizn i zapisów windykacyjnych oraz wyliczenie kwoty należnej uprawnionemu."},
        {"Wezwanie do zapłaty i ugoda",
         "Przedsądowe wezwanie do zapłaty zachowku i negocjacje, w tym co do rozłożenia płatności na raty."},
        {"Pozew o zachowek",
         "Przygotowanie pozwu, wnioski o opinię biegłego rzeczoznawcy i reprezentacja przed sądem."},
        {"Obrona przed roszczeniem",
         "Zarzut przedawnienia, wydziedziczenie, zaliczenie otrzymanych darowizn, wniosek o obniżenie zachowku lub rozłożenie go na raty."}
      ],
      notes_title: "Ile wynosi zachowek?",
      notes: [
        "Zachowek wynosi co do zasady połowę wartości udziału, który przypadłby uprawnionemu przy dziedziczeniu ustawowym, a dwie trzecie — gdy uprawniony jest trwale niezdolny do pracy lub małoletni (art. 991 § 1 k.c.).",
        "Podstawą obliczeń jest czysta wartość spadku powiększona o doliczane darowizny i zapisy windykacyjne. Od wyliczonej kwoty odejmuje się to, co uprawniony sam otrzymał od spadkodawcy w darowiźnie, zapisie lub w spadku."
      ],
      acts: [:kc, :kpc, :uksc]
    },
    %{
      slug: "prawo-karne",
      audience: :private,
      home_name: "Prawo karne",
      home_text: "Reprezentacja pokrzywdzonych w postępowaniu karnym.",
      name: "Prawo karne",
      title: "Pełnomocnik pokrzywdzonego — adwokat w Gdańsku",
      meta_title: "Pełnomocnik pokrzywdzonego - adwokat Gdańsk",
      description:
        "Reprezentacja pokrzywdzonych przestępstwem: zawiadomienie, postępowanie przygotowawcze, oskarżyciel posiłkowy, naprawienie szkody. Kancelaria w Gdańsku.",
      lead:
        "Reprezentujemy osoby pokrzywdzone przestępstwem — na każdym etapie postępowania karnego.",
      intro: [
        "Postępowanie karne toczy się według ścisłych reguł i terminów, a decyzje podjęte na jego początku — choćby co do treści zawiadomienia o przestępstwie — mogą mieć znaczenie dla całej sprawy. Dlatego warto skontaktować się z adwokatem jak najwcześniej.",
        "Reprezentujemy pokrzywdzonych w postępowaniu przygotowawczym przed policją i prokuraturą oraz w postępowaniu przed sądem. Nie prowadzimy obron oskarżonych — zajmujemy się wyłącznie stroną pokrzywdzoną, w tym dochodzeniem [odszkodowania i zadośćuczynienia](/uslugi/odszkodowania) od sprawcy."
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
      meta_title: "Obsługa prawna firm - kancelaria Gdańsk",
      description:
        "Stałe wsparcie prawne w codziennym prowadzeniu firmy: umowy, opinie prawne, spory i decyzje biznesowe. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Zapewniamy stałe wsparcie prawne, dzięki któremu możesz skupić się na prowadzeniu firmy.",
      intro: [
        "Celem stałej obsługi prawnej jest nie tylko reagowanie na pojawiające się problemy, ale przede wszystkim takie doradztwo, które pozwala ograniczać ryzyko i świadomie podejmować decyzje biznesowe.",
        "Poznajemy Twoją firmę, jej model działania i potrzeby, a następnie ustalamy zakres i sposób współpracy dopasowany do skali działalności. Stała obsługa obejmuje codzienne sprawy firmy; formalności spółki — uchwały, zgromadzenia i wpisy w KRS — opisujemy na stronie o [obsłudze korporacyjnej](/uslugi/obsluga-korporacyjna), a pojedyncze zlecenia dotyczące kontraktów na stronie o [sporządzaniu i analizie umów](/uslugi/umowy)."
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
      meta_title: "Zakładanie spółek i rejestracja w KRS - adwokat Gdańsk",
      description:
        "Wybór formy prawnej, umowa spółki i rejestracja w KRS — sp. z o.o., spółki osobowe, prosta spółka akcyjna. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Pomagamy wybrać formę prawną działalności, przygotować umowę spółki i zarejestrować ją w Krajowym Rejestrze Sądowym.",
      intro: [
        "Wybór formy prawnej ma długofalowe skutki — dla odpowiedzialności wspólników, opodatkowania, sposobu podejmowania decyzji i możliwości pozyskania inwestora. Warto podjąć go świadomie, zanim firma zacznie działać.",
        "Doradzamy przy wyborze formy, przygotowujemy dokumenty założycielskie dopasowane do potrzeb wspólników i przeprowadzamy rejestrację. Po rejestracji możemy przejąć bieżącą [obsługę korporacyjną](/uslugi/obsluga-korporacyjna) spółki."
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
      meta_title: "Sporządzanie i analiza umów - adwokat Gdańsk",
      description:
        "Przygotowanie, weryfikacja i negocjowanie umów handlowych, umów o współpracy i umów z klientami. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Przygotowujemy, sprawdzamy i negocjujemy umowy tak, aby chroniły Twoje interesy i ograniczały ryzyko sporów.",
      intro: [
        "Dobrze napisana umowa to najtańszy sposób na uniknięcie sporu. Wiele konfliktów, które trafiają do sądu, wynika z niejasnych postanowień, braku regulacji ważnych kwestii albo podpisania wzorca kontrahenta bez jego analizy.",
        "Analizujemy umowy pod kątem ryzyk prawnych i biznesowych, proponujemy zmiany i wspieramy w negocjacjach. Umowę można zlecić jednorazowo albo w ramach [stałej obsługi prawnej firmy](/uslugi/obsluga-przedsiebiorcow); gdy kontrahent umowy nie wykonuje, prowadzimy [spór gospodarczy](/uslugi/spory-gospodarcze)."
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
      meta_title: "Windykacja należności dla firm - adwokat Gdańsk",
      description:
        "Windykacja należności dla firm: wezwanie do zapłaty, nakaz zapłaty, klauzula wykonalności i egzekucja komornicza. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Odzyskujemy należności — od wezwania do zapłaty, przez uzyskanie nakazu zapłaty, po egzekucję komorniczą.",
      intro: [
        "Nieopłacone faktury obciążają płynność firmy, a im dłużej wierzyciel zwleka, tym trudniej odzyskać pieniądze. Skuteczna windykacja wymaga szybkiego działania i właściwego wyboru drogi. Jeżeli zatory płatnicze zagrażają już wypłacalności Twojej firmy, warto równolegle rozważyć [restrukturyzację](/uslugi/restrukturyzacja).",
        "Prowadzimy cały proces odzyskiwania należności i na bieżąco informujemy o kolejnych krokach oraz ich kosztach. Ta strona dotyczy bezspornych należności firm; gdy kontrahent kwestionuje roszczenie, sprawa staje się [sporem gospodarczym](/uslugi/spory-gospodarcze), a obronę przed nakazem zapłaty i sprawy osób prywatnych opisujemy na stronie o [sprawach o zapłatę](/uslugi/sprawy-o-zaplate)."
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
      acts: [:kpc, :kc, :uth]
    },
    %{
      slug: "restrukturyzacja",
      audience: :business,
      home_name: "Restrukturyzacja",
      home_text: "Wsparcie firm w trudnej sytuacji finansowej.",
      name: "Restrukturyzacja",
      title: "Restrukturyzacja firm — adwokat w Gdańsku",
      meta_title: "Restrukturyzacja firmy - adwokat Gdańsk",
      description:
        "Wsparcie firm w trudnej sytuacji finansowej: wybór postępowania restrukturyzacyjnego i układ z wierzycielami. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Pomagamy firmom w trudnej sytuacji finansowej wybrać właściwą drogę naprawy i porozumieć się z wierzycielami.",
      intro: [
        "Restrukturyzacja daje przedsiębiorcy szansę na uniknięcie upadłości — przez zawarcie układu z wierzycielami, a w niektórych postępowaniach także przez przeprowadzenie działań sanacyjnych. Im wcześniej zostanie podjęta, tym więcej możliwości pozostaje.",
        "Oceniamy sytuację firmy, przedstawiamy dostępne postępowania i ich konsekwencje oraz wspieramy przy przygotowaniu propozycji układowych. Osobom, które nie prowadzą już działalności gospodarczej, pomagamy w [upadłości konsumenckiej](/uslugi/upadlosc-konsumencka)."
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
      title: "Obsługa korporacyjna spółek i spory masowe — kancelaria w Gdańsku",
      meta_title: "Obsługa korporacyjna spółek - kancelaria Gdańsk",
      description:
        "Obsługa korporacyjna spółek: uchwały, zgromadzenia, zmiany w KRS oraz współpraca przy sporach masowych. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Zapewniamy stałą obsługę korporacyjną spółek i wspieramy inne kancelarie w prowadzeniu sporów masowych.",
      intro: [
        "Życie spółki to nie tylko bieżące kontrakty, ale też formalności korporacyjne: zgromadzenia wspólników, uchwały, zmiany w składzie organów i umowie spółki oraz zgłoszenia do rejestrów. Zaniedbania w tym zakresie mogą skutkować nieważnością uchwał lub sankcjami.",
        "Mamy też doświadczenie we współpracy z innymi kancelariami przy prowadzeniu sporów masowych — wymagających sprawnej organizacji pracy, konsekwentnej strategii procesowej i zarządzania dużą liczbą postępowań.",
        "Nową spółkę pomagamy założyć i zarejestrować — piszemy o tym na stronie o [zakładaniu spółek](/uslugi/zakladanie-spolek). Codzienne doradztwo dla firmy obejmuje z kolei [bieżąca obsługa prawna](/uslugi/obsluga-przedsiebiorcow)."
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
      meta_title: "Prawo AI i nowych technologii - adwokat Gdańsk",
      description:
        "Wsparcie prawne przy wdrażaniu sztucznej inteligencji i nowych technologii: umowy IT, AI Act, dane osobowe. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Wspieramy przedsiębiorców we wdrażaniu sztucznej inteligencji, automatyzacji procesów i nowych technologii — bezpiecznie i zgodnie z prawem.",
      intro: [
        "Sztuczna inteligencja i automatyzacja zmieniają sposób prowadzenia biznesu, ale rodzą też nowe pytania prawne: kto odpowiada za błędy systemu, do kogo należą prawa do wygenerowanych treści, jak chronić dane i tajemnice przedsiębiorstwa.",
        "Sami wykorzystujemy nowe technologie w pracy kancelarii, dlatego rozumiemy zarówno ich możliwości, jak i ryzyka. Wdrożenie AI prawie zawsze wiąże się z przetwarzaniem danych osobowych, dlatego łączymy je z doradztwem w zakresie [RODO](/uslugi/rodo) i z przygotowaniem [umów](/uslugi/umowy) z dostawcami."
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
      meta_title: "Sukcesja firmy rodzinnej - adwokat Gdańsk",
      description:
        "Planowanie sukcesji, zarząd sukcesyjny, fundacja rodzinna i zabezpieczenie ciągłości firmy przy zmianie pokoleniowej. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Pomagamy zaplanować przekazanie firmy następnemu pokoleniu tak, aby zachować jej ciągłość i uniknąć sporów w rodzinie.",
      intro: [
        "Sukcesja to jedno z największych wyzwań firm rodzinnych. Brak planu może sparaliżować działalność po śmierci właściciela, a niejasne zasady — doprowadzić do konfliktów między spadkobiercami.",
        "Łączymy wiedzę z zakresu prawa spółek, [prawa spadkowego](/uslugi/sprawy-spadkowe) i prawa rodzinnego, aby przygotować rozwiązanie dopasowane do firmy i rodziny. Jeżeli plan sukcesji wymaga przekształcenia działalności, pomagamy też [założyć spółkę](/uslugi/zakladanie-spolek). Plan powinien uwzględniać także roszczenia pominiętych członków rodziny o [zachowek](/uslugi/zachowek)."
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
      title: "Prawo medyczne i obsługa podmiotów leczniczych — kancelaria w Gdańsku",
      meta_title: "Prawo medyczne - kancelaria dla gabinetów i klinik, Gdańsk",
      description:
        "Obsługa prawna gabinetów, klinik i podmiotów leczniczych: umowy, dokumentacja medyczna, prawa pacjenta, spory. Kancelaria Kraluk Kurkierewicz, Gdańsk.",
      lead:
        "Zapewniamy obsługę prawną gabinetów, klinik i innych podmiotów leczniczych — od umów i dokumentacji po spory z pacjentami.",
      intro: [
        "Działalność lecznicza podlega szczególnym wymogom — od rejestracji podmiotu, przez prowadzenie dokumentacji medycznej, po przestrzeganie praw pacjenta. Uchybienia w tym zakresie mogą prowadzić do odpowiedzialności cywilnej, zawodowej i administracyjnej.",
        "Pomagamy uporządkować dokumentację i umowy, a w razie sporu reprezentujemy podmioty lecznicze przed sądami. Ochronę danych o zdrowiu opisujemy szerzej na stronie o [RODO](/uslugi/rodo)."
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
      meta_title: "Spory gospodarcze - adwokat Gdańsk",
      description:
        "Reprezentacja przedsiębiorców w sporach z kontrahentami i postępowaniach w sprawach gospodarczych. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Reprezentujemy przedsiębiorców w sporach z kontrahentami — w negocjacjach i przed sądem.",
      intro: [
        "Spór gospodarczy zaczyna się zwykle od niezapłaconej faktury, wadliwie wykonanej umowy albo naliczonej kary umownej. Gdy kontrahent kwestionuje roszczenie i rozmowy nie przynoszą efektu, o wyniku decyduje sąd — a w sprawach między przedsiębiorcami także to, jak starannie przygotowano pozew lub odpowiedź na pozew.",
        "Reprezentacja przed sądami zajmuje szczególne miejsce w naszej praktyce: mamy wieloletnie doświadczenie w prowadzeniu postępowań sądowych, w tym spraw o znacznym stopniu złożoności. Zanim sprawa trafi do sądu, oceniamy jej perspektywy, ryzyka i koszty, a także możliwość polubownego rozwiązania.",
        "Bezsporne należności odzyskujemy w trybie opisanym na stronie o [windykacji i egzekucji wierzytelności](/uslugi/egzekucja-wierzytelnosci), a ryzyko przyszłych sporów ograniczają dobrze przygotowane [umowy](/uslugi/umowy)."
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
      title: "RODO i ochrona danych osobowych — kancelaria w Gdańsku",
      meta_title: "Wdrożenie i audyt RODO - kancelaria Gdańsk",
      description:
        "Wdrożenia RODO, audyty zgodności, dokumentacja i procedury ochrony danych oraz bieżące wsparcie. Kancelaria adwokacka Kraluk Kurkierewicz w Gdańsku.",
      lead:
        "Pomagamy firmom i organizacjom przetwarzać dane osobowe zgodnie z RODO — w sposób praktyczny i dopasowany do skali działalności.",
      intro: [
        "Ochrona danych osobowych dotyczy każdej firmy, która ma klientów, pracowników lub kontrahentów. Dokumentacja RODO powinna odpowiadać rzeczywistym procesom w organizacji — szablonowe rozwiązania rzadko spełniają ten warunek.",
        "Zaczynamy od poznania, jakie dane i w jaki sposób przetwarza Twoja organizacja, a następnie przygotowujemy dokumentację i procedury, które da się stosować w praktyce. Osobno opisujemy ochronę danych przy [wdrażaniu sztucznej inteligencji](/uslugi/nowe-technologie) oraz dane o zdrowiu w [podmiotach leczniczych](/uslugi/prawo-medyczne)."
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
      "Sąd: sprawy o kontakty i władzę rodzicielską rozpoznaje sąd rejonowy miejsca zamieszkania dziecka.",
      "Opłata od wniosku o ustalenie kontaktów: 100 zł.",
      "Utrudnianie kontaktów: sąd może nakazać zapłatę sumy pieniężnej za każde naruszenie."
    ],
    "alimenty" => [
      "Alimenty na dziecko: brak tabel i kwot minimalnych — decydują potrzeby dziecka i możliwości zarobkowe rodzica (art. 135 § 1 k.r.o.).",
      "Pozew o alimenty na dziecko i o ich podwyższenie: 0 zł opłaty sądowej.",
      "Do kiedy: do czasu, gdy dziecko jest w stanie utrzymać się samodzielnie — ukończenie 18 lat nie kończy obowiązku.",
      "Zaległe raty alimentów przedawniają się po 3 latach."
    ],
    "zachowek" => [
      "Wysokość: 1/2 udziału ustawowego, a 2/3 dla małoletnich i trwale niezdolnych do pracy.",
      "Uprawnieni: zstępni, małżonek i rodzice spadkodawcy — rodzeństwo nie.",
      "Przedawnienie: 5 lat od ogłoszenia testamentu albo od otwarcia spadku.",
      "Darowizny dolicza się do spadku, z wyjątkami z art. 994 k.c."
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
      "Kwota: różnica powierzchni × cena za m² z umowy; w opublikowanych wyrokach ok. 11-24 tys. zł na nabywcę.",
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
    "sluzebnosc-przesylu" => [
      "Roszczenia: ustanowienie służebności przesyłu za wynagrodzeniem oraz zapłata za bezumowne korzystanie z działki.",
      "Wyrok TK z 2 grudnia 2025 r. (P 10/16) zakwestionował zasiedzenie służebności przed 3 sierpnia 2008 r.",
      "Bezumowne korzystanie: co do zasady do 6 lat wstecz.",
      "Wniosek o ustanowienie służebności przesyłu: sąd rejonowy miejsca położenia działki, opłata 100 zł."
    ],
    "prawa-konsumentow" => [
      "Odstąpienie od umowy zawartej na odległość: 14 dni, bez podawania przyczyny (z ustawowymi wyjątkami).",
      "Niedozwolone postanowienia umowne nie wiążą konsumenta; umowa obowiązuje w pozostałym zakresie.",
      "Zakres: reklamacje, odstąpienie od umowy, spory z przedsiębiorcami."
    ],
    "sprawy-spadkowe" => [
      "Przyjęcie lub odrzucenie spadku: 6 miesięcy od dowiedzenia się o tytule powołania.",
      "Stwierdzenie nabycia spadku w sądzie: 100 zł opłaty i 5 zł za wpis do Rejestru Spadkowego.",
      "Dział spadku: 500 zł, a przy zgodnym projekcie 300 zł."
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
    "rozwod" => ~w(podzial-majatku alimenty sprawy-rodzinne),
    "sprawy-rodzinne" => ~w(alimenty rozwod podzial-majatku),
    "alimenty" => ~w(sprawy-rodzinne rozwod podzial-majatku),
    "zachowek" => ~w(sprawy-spadkowe nieruchomosci sukcesja-firm),
    "podzial-majatku" => ~w(rozwod sprawy-rodzinne nieruchomosci),
    "upadlosc-konsumencka" => ~w(sprawy-o-zaplate restrukturyzacja podzial-majatku),
    "zawyzony-metraz" => ~w(prawa-konsumentow nieruchomosci sprawy-o-zaplate),
    "sprawy-o-zaplate" => ~w(egzekucja-wierzytelnosci prawa-konsumentow odszkodowania),
    "odszkodowania" => ~w(sprawy-o-zaplate prawo-karne prawa-konsumentow),
    "nieruchomosci" => ~w(sluzebnosc-przesylu zawyzony-metraz sprawy-spadkowe),
    "sluzebnosc-przesylu" => ~w(nieruchomosci odszkodowania sprawy-o-zaplate),
    "prawa-konsumentow" => ~w(zawyzony-metraz sprawy-o-zaplate odszkodowania),
    "sprawy-spadkowe" => ~w(zachowek nieruchomosci sukcesja-firm),
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

  # "W Gdańsku i Trójmieście" paragraph of each service page: which local court or
  # office handles the matter. Court facts only — re-check after a court reorganisation.
  @local %{
    "rozwod" =>
      "Sprawy rozwodowe małżonków, których ostatnie wspólne miejsce zamieszkania znajdowało się w Gdańsku, Gdyni lub Sopocie, rozpoznaje Sąd Okręgowy w Gdańsku przy ul. Nowe Ogrody 30/34. Kancelaria mieści się przy ul. Strzeleckiej 7B w Gdańsku; konsultację można też odbyć telefonicznie lub przez wideo.",
    "sprawy-rodzinne" =>
      "Sprawy o kontakty i władzę rodzicielską rozpoznaje sąd rejonowy właściwy dla miejsca zamieszkania dziecka. W Gdańsku jest to — zależnie od dzielnicy — Sąd Rejonowy Gdańsk-Północ albo Sąd Rejonowy Gdańsk-Południe; sprawy dzieci mieszkających w Gdyni i Sopocie trafiają do tamtejszych sądów rejonowych. Sprawy o separację rozpoznaje Sąd Okręgowy w Gdańsku.",
    "alimenty" =>
      "Pozew o alimenty można wnieść do sądu rejonowego właściwego dla miejsca zamieszkania osoby uprawnionej, czyli najczęściej dziecka (art. 32 k.p.c.). W Gdańsku jest to — zależnie od dzielnicy — Sąd Rejonowy Gdańsk-Północ albo Sąd Rejonowy Gdańsk-Południe; sprawy z Gdyni i Sopotu trafiają do tamtejszych sądów rejonowych. Rodzic mieszkający z dzieckiem w Gdańsku nie musi więc prowadzić sprawy w mieście, w którym mieszka pozwany.",
    "zachowek" =>
      "Pozew o zachowek rozpoznaje wyłącznie sąd ostatniego miejsca zwykłego pobytu spadkodawcy (art. 39 k.p.c.). Jeżeli zmarły mieszkał w Gdańsku, jest to Sąd Rejonowy Gdańsk-Północ albo Sąd Rejonowy Gdańsk-Południe, a przy roszczeniach powyżej 100 000 zł — Sąd Okręgowy w Gdańsku. Uprawniony może mieszkać w innym mieście lub za granicą.",
    "podzial-majatku" =>
      "Wniosek o podział majątku wspólnego składa się do sądu rejonowego właściwego dla miejsca położenia majątku (art. 566 k.p.c.). Gdy mieszkanie lub dom znajduje się w Gdańsku, sprawę prowadzi Sąd Rejonowy Gdańsk-Północ albo Sąd Rejonowy Gdańsk-Południe — zależnie od dzielnicy. Umowny podział majątku obejmujący nieruchomość wymaga wizyty u notariusza.",
    "upadlosc-konsumencka" =>
      "Sądem upadłościowym dla osób mieszkających w Gdańsku i Trójmieście jest Sąd Rejonowy Gdańsk-Północ w Gdańsku. Wniosek składa się elektronicznie przez Krajowy Rejestr Zadłużonych albo na formularzu papierowym, a dokumenty do niego można omówić w kancelarii w Gdańsku lub zdalnie.",
    "zawyzony-metraz" =>
      "Nabywca będący konsumentem może pozwać dewelopera przed sąd właściwy dla swojego miejsca zamieszkania (art. 37² k.p.c.) — mieszkaniec Gdańska nie musi więc prowadzić sprawy w mieście, w którym deweloper ma siedzibę. Pomagamy nabywcom mieszkań w Gdańsku, Gdyni, Sopocie i w całym województwie pomorskim, a sprawy o zwrot za metraż prowadzimy także w Warszawie i innych miastach — dokumenty analizujemy zdalnie, a konsultację można odbyć telefonicznie lub przez wideo.",
    "sprawy-o-zaplate" =>
      "Sprawy o zapłatę do 100 000 zł rozpoznaje sąd rejonowy, a powyżej tej kwoty — sąd okręgowy. Co do zasady właściwy jest sąd miejsca zamieszkania pozwanego; w Gdańsku są to Sąd Rejonowy Gdańsk-Północ, Sąd Rejonowy Gdańsk-Południe albo Sąd Okręgowy w Gdańsku.",
    "odszkodowania" =>
      "Roszczeń z ubezpieczenia OC można dochodzić przed sądem właściwym dla miejsca zamieszkania poszkodowanego, a roszczeń z czynu niedozwolonego — także przed sądem, w którego okręgu doszło do zdarzenia (art. 35 k.p.c.). Poszkodowani z Gdańska i Trójmiasta mogą więc zwykle prowadzić sprawę na miejscu: przed sądem rejonowym albo, przy roszczeniach powyżej 100 000 zł, przed Sądem Okręgowym w Gdańsku.",
    "nieruchomosci" =>
      "Sprawy o własność i inne prawa rzeczowe na nieruchomości rozpoznaje wyłącznie sąd miejsca jej położenia (art. 38 k.p.c.). Dla nieruchomości w Gdańsku jest to Sąd Rejonowy Gdańsk-Północ lub Sąd Rejonowy Gdańsk-Południe albo — w sprawach o wyższej wartości — Sąd Okręgowy w Gdańsku. Księgi wieczyste gdańskich nieruchomości prowadzi Sąd Rejonowy Gdańsk-Północ.",
    "sluzebnosc-przesylu" =>
      "Operatorem sieci dystrybucyjnej energii elektrycznej na większości obszaru województwa pomorskiego jest Energa-Operator. Wniosek o ustanowienie służebności przesyłu rozpoznaje sąd rejonowy właściwy dla miejsca położenia działki — dla nieruchomości w Gdańsku jest to Sąd Rejonowy Gdańsk-Północ albo Sąd Rejonowy Gdańsk-Południe. Prowadzimy sprawy właścicieli działek z Gdańska, Trójmiasta i całego Pomorza.",
    "prawa-konsumentow" =>
      "Konsument może pozwać przedsiębiorcę przed sąd właściwy dla swojego miejsca zamieszkania (art. 37² k.p.c.). Mieszkaniec Gdańska prowadzi więc spór przed sądem w Gdańsku — także wtedy, gdy sprzedawca lub usługodawca ma siedzibę w innym mieście.",
    "sprawy-spadkowe" =>
      "Sądem spadku jest sąd rejonowy ostatniego miejsca zwykłego pobytu spadkodawcy (art. 628 k.p.c.). Jeżeli zmarły mieszkał w Gdańsku, sprawę o stwierdzenie nabycia spadku i o dział spadku prowadzi Sąd Rejonowy Gdańsk-Północ albo Sąd Rejonowy Gdańsk-Południe — zależnie od dzielnicy.",
    "prawo-karne" =>
      "Reprezentujemy pokrzywdzonych w postępowaniach prowadzonych przez jednostki policji i prokuratury w Gdańsku i Trójmieście oraz przed sądami rejonowymi i Sądem Okręgowym w Gdańsku.",
    "obsluga-przedsiebiorcow" =>
      "Obsługujemy przedsiębiorców z Gdańska, Gdyni, Sopotu i całego województwa pomorskiego. Spotykamy się w kancelarii przy ul. Strzeleckiej 7B w Gdańsku albo pracujemy zdalnie — telefonicznie i przez wideo.",
    "zakladanie-spolek" =>
      "Spółki z siedzibą w Gdańsku, Gdyni i Sopocie rejestruje Sąd Rejonowy Gdańsk-Północ w Gdańsku — jego wydziały gospodarcze Krajowego Rejestru Sądowego. Wniosek składa się elektronicznie, więc całą rejestrację można przeprowadzić bez wizyty w sądzie.",
    "umowy" =>
      "Umowy przygotowujemy i sprawdzamy dla przedsiębiorców i osób prywatnych z Gdańska, Trójmiasta i całego województwa pomorskiego. W umowie między przedsiębiorcami warto świadomie wskazać sąd właściwy do rozstrzygania sporów (art. 46 k.p.c.) — na przykład sąd w Gdańsku, jeżeli tu działa Twoja firma.",
    "egzekucja-wierzytelnosci" =>
      "Wierzyciel może co do zasady wybrać komornika na obszarze właściwości sądu apelacyjnego, w którym działa komornik właściwy według przepisów ogólnych — przy dłużnikach z Pomorza jest to apelacja gdańska. Wyboru nie ma między innymi przy egzekucji z nieruchomości, którą prowadzi komornik miejsca jej położenia.",
    "restrukturyzacja" =>
      "Sądem restrukturyzacyjnym dla przedsiębiorców, których główny ośrodek działalności znajduje się w Gdańsku lub Trójmieście, jest Sąd Rejonowy Gdańsk-Północ w Gdańsku. Pisma w postępowaniu składa się elektronicznie przez Krajowy Rejestr Zadłużonych.",
    "obsluga-korporacyjna" =>
      "Wnioski o wpis zmian w spółkach z siedzibą w Gdańsku i Trójmieście rozpoznaje Sąd Rejonowy Gdańsk-Północ w Gdańsku (wydziały gospodarcze KRS), a sprawy o uchylenie lub stwierdzenie nieważności uchwał — Sąd Okręgowy w Gdańsku.",
    "nowe-technologie" =>
      "Doradzamy przedsiębiorcom z Gdańska, Gdyni, Sopotu i całego województwa pomorskiego, którzy wdrażają sztuczną inteligencję lub automatyzują procesy — w kancelarii w Gdańsku albo zdalnie.",
    "sukcesja-firm" =>
      "Doradzamy właścicielom firm rodzinnych z Gdańska, Trójmiasta i województwa pomorskiego. Zarządcę sukcesyjnego zgłasza się do CEIDG, a fundację rodzinną rejestruje Sąd Okręgowy w Piotrkowie Trybunalskim — niezależnie od tego, gdzie mieszka fundator.",
    "prawo-medyczne" =>
      "Obsługujemy gabinety, kliniki i inne podmioty lecznicze z Gdańska, Gdyni, Sopotu i województwa pomorskiego. Organem prowadzącym rejestr podmiotów leczniczych z Pomorza jest Wojewoda Pomorski.",
    "spory-gospodarcze" =>
      "Sprawy gospodarcze w Gdańsku rozpoznają wydziały gospodarcze Sądu Rejonowego Gdańsk-Północ w Gdańsku, a przy wartości przedmiotu sporu powyżej 100 000 zł — Sądu Okręgowego w Gdańsku.",
    "rodo" =>
      "Wdrożenia i audyty RODO prowadzimy dla firm i organizacji z Gdańska, Gdyni, Sopotu i całego województwa pomorskiego — w kancelarii w Gdańsku albo zdalnie. Organem nadzorczym dla całej Polski jest Prezes Urzędu Ochrony Danych Osobowych z siedzibą w Warszawie."
  }

  @doc "\"W skrócie\" points for a service page."
  def summary(service), do: Map.fetch!(@summaries, service.slug)

  @doc "Local paragraph (\"W Gdańsku i Trójmieście\") of a service page."
  def local(service), do: Map.fetch!(@local, service.slug)

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

  # Questions Clients ask about the topics of the pages whose `ServiceDetails`
  # entry has no `:faq` of its own, phrased the way they are typed into a search engine or
  # an AI assistant. Rendered in the page FAQ and its `FAQPage` JSON-LD — plain text only.
  @questions %{
    "prawa-konsumentow" => [
      {"Ile czasu mam na reklamację towaru?",
       "Sprzedawca odpowiada za brak zgodności towaru z umową, który istniał w chwili dostarczenia i ujawnił się w ciągu dwóch lat od tej chwili. Przez ten czas domniemywa się, że brak istniał już w chwili dostarczenia towaru."},
      {"W jakim terminie sprzedawca musi odpowiedzieć na reklamację?",
       "W ciągu 14 dni od jej otrzymania. Jeżeli przedsiębiorca nie odpowie w tym terminie, uważa się, że reklamację uznał."},
      {"Czy można zwrócić towar kupiony w sklepie stacjonarnym?",
       "Ustawowe prawo odstąpienia od umowy w ciągu 14 dni dotyczy umów zawartych na odległość i poza lokalem przedsiębiorstwa. W sklepie stacjonarnym zwrot pełnowartościowego towaru jest możliwy tylko wtedy, gdy sprzedawca sam na to pozwala."},
      {"Kiedy mogę żądać zwrotu pieniędzy zamiast naprawy?",
       "Co do zasady najpierw można żądać naprawy lub wymiany towaru. Obniżenie ceny albo odstąpienie od umowy wchodzi w grę między innymi wtedy, gdy sprzedawca odmówił doprowadzenia towaru do zgodności z umową, nie zrobił tego albo brak występuje nadal mimo próby naprawy. Od umowy nie można odstąpić, gdy brak zgodności jest nieistotny."}
    ],
    "prawo-karne" => [
      {"Jak złożyć zawiadomienie o przestępstwie?",
       "Ustnie do protokołu w jednostce policji lub w prokuraturze albo na piśmie. Zawiadomienie jest wolne od opłat. Warto od razu wskazać znane dowody: świadków, dokumenty, nagrania i korespondencję."},
      {"Co zrobić, gdy prokurator umorzył postępowanie albo odmówił jego wszczęcia?",
       "Pokrzywdzony może złożyć zażalenie do sądu w terminie 7 dni od doręczenia postanowienia. W zażaleniu wskazuje się, jakich dowodów nie przeprowadzono i dlaczego ocena sprawy jest błędna."},
      {"Do kiedy można zostać oskarżycielem posiłkowym?",
       "Oświadczenie, że pokrzywdzony będzie działał jako oskarżyciel posiłkowy, można złożyć do czasu rozpoczęcia przewodu sądowego na rozprawie głównej."},
      {"Czy pokrzywdzony może uzyskać odszkodowanie w procesie karnym?",
       "Tak. Pokrzywdzony może złożyć wniosek o orzeczenie obowiązku naprawienia szkody lub zadośćuczynienia za krzywdę — aż do zamknięcia przewodu sądowego na rozprawie głównej. Pozostałej części roszczeń można dochodzić w procesie cywilnym."}
    ],
    "obsluga-przedsiebiorcow" => [
      {"Ile kosztuje stała obsługa prawna firmy?",
       "Koszt zależy od zakresu obsługi i liczby spraw w miesiącu. Zanim zaczniemy współpracę, rozmawiamy o potrzebach firmy i przedstawiamy proponowany zakres oraz koszty."},
      {"Czy mała firma potrzebuje stałej obsługi prawnej?",
       "Nie każda. Stała obsługa ma sens, gdy firma regularnie zawiera umowy, zatrudnia ludzi albo dochodzi należności. Przy sporadycznych sprawach wystarczą pojedyncze zlecenia, na przykład sprawdzenie konkretnej umowy."},
      {"Co to jest stała obsługa prawna i co obejmuje?",
       "To umowa, na podstawie której kancelaria na bieżąco wspiera firmę, zamiast przyjmować pojedyncze zlecenia. Zwykle obejmuje konsultacje, przygotowanie i sprawdzanie umów, opinie prawne, wezwania do zapłaty oraz reprezentację w sporach; dokładny zakres ustala się w umowie."},
      {"Czy stała obsługa prawna obejmuje sprawy sądowe?",
       "To zależy od umowy. Bieżące doradztwo i przygotowanie umów mieszczą się zwykle w stałym wynagrodzeniu, a prowadzenie spraw sądowych bywa rozliczane odrębnie — warto ustalić to na początku współpracy."},
      {"Czy obsługa prawna może odbywać się zdalnie?",
       "Tak. Dokumenty przekazujemy elektronicznie, a konsultacje prowadzimy telefonicznie lub przez wideo; spotkać można się także w kancelarii w Gdańsku."}
    ],
    "zakladanie-spolek" => [
      {"Ile kosztuje założenie spółki z o.o.?",
       "Opłata sądowa za wpis do KRS wynosi 500 zł, a przy rejestracji w systemie S24 — 250 zł; w obu przypadkach dolicza się 100 zł za ogłoszenie w Monitorze Sądowym i Gospodarczym. Do tego dochodzi podatek od czynności cywilnoprawnych (0,5% podstawy opodatkowania) oraz — przy umowie w formie aktu notarialnego — taksa notarialna."},
      {"Jaki jest minimalny kapitał zakładowy spółki?",
       "W spółce z o.o. 5 000 zł, przy czym wartość nominalna udziału nie może być niższa niż 50 zł. W spółce akcyjnej kapitał zakładowy wynosi co najmniej 100 000 zł, a w prostej spółce akcyjnej kapitał akcyjny — co najmniej 1 zł."},
      {"Ile trwa rejestracja spółki w KRS?",
       "Przepisy przewidują rozpoznanie wniosku o wpis spółki założonej w S24 w ciągu jednego dnia, a pozostałych wniosków — w ciągu siedmiu dni. W praktyce czas zależy od obłożenia sądu i kompletności wniosku."},
      {"Czy jedna osoba może założyć spółkę z o.o.?",
       "Tak, spółka z o.o. może mieć jednego wspólnika. Nie może jej jednak zawiązać wyłącznie inna jednoosobowa spółka z ograniczoną odpowiedzialnością."},
      {"Spółka z o.o. czy jednoosobowa działalność gospodarcza?",
       "Przedsiębiorca prowadzący jednoosobową działalność odpowiada za zobowiązania firmy całym swoim majątkiem. Wspólnicy spółki z o.o. nie odpowiadają za jej zobowiązania, choć w określonych sytuacjach odpowiedzialność mogą ponosić członkowie zarządu. Spółka oznacza za to więcej formalności i pełną księgowość."}
    ],
    "umowy" => [
      {"Czy umowa zawarta mailowo lub ustnie jest ważna?",
       "Co do zasady tak — większość umów można zawrzeć w dowolnej formie. Wyjątkiem są umowy, dla których ustawa wymaga formy szczególnej, na przykład aktu notarialnego przy sprzedaży nieruchomości. Forma pisemna ułatwia jednak wykazanie treści ustaleń w razie sporu."},
      {"Kiedy można odstąpić od umowy?",
       "Wtedy, gdy przewiduje to sama umowa albo ustawa. W umowach wzajemnych podstawą bywa zwłoka drugiej strony: co do zasady trzeba najpierw wyznaczyć jej odpowiedni dodatkowy termin z zagrożeniem odstąpienia (art. 491 k.c.)."},
      {"Czy karę umowną można obniżyć?",
       "Tak. Dłużnik może żądać zmniejszenia kary umownej, jeżeli zobowiązanie zostało w znacznej części wykonane albo kara jest rażąco wygórowana (art. 484 § 2 k.c.). Karę umowną można zastrzec tylko na wypadek niewykonania lub nienależytego wykonania zobowiązania niepieniężnego."},
      {"Ile kosztuje sprawdzenie umowy przez adwokata?",
       "Zależy od objętości i stopnia skomplikowania umowy. Po zapoznaniu się z dokumentem podajemy koszt i termin, zanim przystąpimy do pracy."}
    ],
    "egzekucja-wierzytelnosci" => [
      {"Jak odzyskać pieniądze za niezapłaconą fakturę?",
       "Zwykle w czterech krokach: wezwanie do zapłaty, pozew o wydanie nakazu zapłaty, uzyskanie klauzuli wykonalności i wniosek do komornika. Na każdym etapie możliwe jest porozumienie z dłużnikiem, na przykład rozłożenie długu na raty."},
      {"Jakie odsetki i rekompensata należą się za opóźnienie kontrahenta?",
       "W transakcjach handlowych wierzycielowi przysługują odsetki ustawowe za opóźnienie w transakcjach handlowych oraz rekompensata za koszty odzyskiwania należności: równowartość 40 euro przy świadczeniu do 5 000 zł, 70 euro przy świadczeniu wyższym niż 5 000 zł, ale niższym niż 50 000 zł, oraz 100 euro przy świadczeniu od 50 000 zł."},
      {"Kto płaci koszty egzekucji komorniczej?",
       "Co do zasady dłużnik: komornik ściąga od niego opłatę egzekucyjną razem z egzekwowanym świadczeniem. Wierzyciel może zostać wezwany do wpłacenia zaliczki na wydatki, na przykład na koszty korespondencji i zapytań."},
      {"Co zrobić, gdy komornik umorzył egzekucję jako bezskuteczną?",
       "Tytuł wykonawczy zachowuje ważność, więc egzekucję można wszcząć ponownie, gdy dłużnik uzyska majątek. Roszczenie stwierdzone prawomocnym orzeczeniem przedawnia się co do zasady po sześciu latach, a każdy wniosek egzekucyjny przerywa bieg tego terminu. Przy długach spółki z o.o. warto też ocenić odpowiedzialność członków jej zarządu."}
    ],
    "restrukturyzacja" => [
      {"Czy restrukturyzacja wstrzymuje egzekucję komorniczą?",
       "Tak, w zakresie określonym dla danego postępowania. Otwarcie postępowania układowego zawiesza egzekucje wierzytelności objętych układem, a otwarcie postępowania sanacyjnego — egzekucje skierowane do majątku wchodzącego w skład masy sanacyjnej. W postępowaniu o zatwierdzenie układu ochrona działa od obwieszczenia o ustaleniu dnia układowego i trwa nie dłużej niż cztery miesiące."},
      {"Czym różni się restrukturyzacja od upadłości?",
       "Restrukturyzacja ma pozwolić firmie dalej działać dzięki układowi z wierzycielami — przedsiębiorca co do zasady zachowuje firmę. Upadłość prowadzi do sprzedaży majątku przez syndyka i podziału uzyskanych środków między wierzycieli."},
      {"Kiedy zarząd musi złożyć wniosek o upadłość?",
       "W terminie 30 dni od dnia, w którym wystąpiła podstawa do ogłoszenia upadłości, czyli niewypłacalność. Zwłoka może prowadzić do osobistej odpowiedzialności członków zarządu za długi spółki."},
      {"Jaka większość wierzycieli jest potrzebna do przyjęcia układu?",
       "Układ zostaje przyjęty, jeżeli opowie się za nim większość głosujących wierzycieli, mających łącznie co najmniej dwie trzecie sumy wierzytelności przysługujących głosującym wierzycielom. Przyjęty układ zatwierdza następnie sąd."}
    ],
    "obsluga-korporacyjna" => [
      {"Do kiedy trzeba zatwierdzić i złożyć sprawozdanie finansowe?",
       "Sprawozdanie finansowe zatwierdza się w ciągu sześciu miesięcy od dnia bilansowego, a następnie w ciągu 15 dni od zatwierdzenia składa do repozytorium dokumentów finansowych."},
      {"W jakim terminie zgłosić zmianę zarządu do KRS?",
       "Wniosek o wpis składa się w ciągu siedmiu dni od zmiany. Opłata sądowa wynosi 250 zł, a za ogłoszenie w Monitorze Sądowym i Gospodarczym dolicza się 100 zł. Sama zmiana jest skuteczna od chwili podjęcia uchwały — wpis ją jedynie ujawnia."},
      {"Czy zmiana umowy spółki z o.o. wymaga notariusza?",
       "Tak. Uchwałę o zmianie umowy spółki umieszcza się w protokole sporządzonym przez notariusza, a zmiana staje się skuteczna dopiero z chwilą wpisu do KRS. Wyjątkiem są spółki założone w S24, które mogą zmienić umowę w tym systemie w zakresie przewidzianym przez wzorzec."},
      {"Jak zaskarżyć uchwałę wspólników?",
       "Powództwo o uchylenie uchwały wnosi się w terminie miesiąca od otrzymania wiadomości o uchwale, nie później niż sześć miesięcy od jej powzięcia. Powództwo o stwierdzenie nieważności uchwały — w terminie sześciu miesięcy od otrzymania wiadomości o niej, nie później niż trzy lata od jej powzięcia."}
    ],
    "nowe-technologie" => [
      {"Od kiedy stosuje się AI Act?",
       "Rozporządzenie weszło w życie 1 sierpnia 2024 r. i jest stosowane etapami. Zakazy niedopuszczalnych praktyk oraz obowiązek zapewnienia pracownikom odpowiednich kompetencji w zakresie AI stosuje się od 2 lutego 2025 r., a obowiązki dostawców modeli ogólnego przeznaczenia — od 2 sierpnia 2025 r. Terminy dla systemów wysokiego ryzyka są późniejsze i były przedmiotem zmian, dlatego w każdej sprawie sprawdzamy aktualny stan prawny."},
      {"Czy można wpisywać dane klientów do narzędzi takich jak ChatGPT?",
       "Wpisanie danych osobowych do zewnętrznego narzędzia AI jest ich przetwarzaniem i wymaga podstawy prawnej z RODO. Trzeba sprawdzić warunki dostawcy: czy zawiera umowę powierzenia, gdzie przechowuje dane i czy używa ich do trenowania modelu. Osobną kwestią jest tajemnica przedsiębiorstwa i poufność wobec kontrahentów."},
      {"Kto ma prawa autorskie do obrazów i tekstów wygenerowanych przez AI?",
       "W polskim prawie utworem jest przejaw działalności twórczej człowieka, dlatego treści wygenerowane wyłącznie przez AI co do zasady nie korzystają z ochrony prawnoautorskiej. Chroniony może być twórczy wkład człowieka. Zakres dozwolonego korzystania z wyników określają też warunki licencji narzędzia."},
      {"Kto odpowiada za błąd systemu AI?",
       "Wobec klientów i kontrahentów co do zasady odpowiada firma, która posługuje się systemem — na ogólnych zasadach odpowiedzialności. To, czy może następnie żądać zwrotu od dostawcy, zależy od umowy z nim, dlatego postanowienia o odpowiedzialności warto negocjować przed wdrożeniem."}
    ],
    "sukcesja-firm" => [
      {"Co dzieje się z jednoosobową firmą po śmierci właściciela?",
       "Bez zarządcy sukcesyjnego działalność w praktyce ustaje: co do zasady wygasają umowy o pracę, pełnomocnictwa i część decyzji administracyjnych. Jeżeli zarządca został powołany, przedsiębiorstwo w spadku działa dalej pod dotychczasowym NIP do czasu uregulowania spraw spadkowych."},
      {"Czy zarządcę sukcesyjnego można powołać po śmierci przedsiębiorcy?",
       "Tak, w ciągu dwóch miesięcy od dnia śmierci. Zarządcę może powołać między innymi małżonek, któremu przysługuje udział w przedsiębiorstwie w spadku, albo spadkobierca, który przyjął spadek. Powołanie wymaga formy aktu notarialnego i zgody osób, którym łącznie przysługuje udział w przedsiębiorstwie większy niż 85/100."},
      {"Jak długo trwa zarząd sukcesyjny?",
       "Co do zasady do działu spadku obejmującego przedsiębiorstwo, nie dłużej niż dwa lata od śmierci przedsiębiorcy. Z ważnych przyczyn sąd może przedłużyć ten okres — do pięciu lat od dnia śmierci."},
      {"Ile wynosi minimalny majątek fundacji rodzinnej?",
       "Fundusz założycielski fundacji rodzinnej musi wynosić co najmniej 100 000 zł. Fundację ustanawia się w akcie założycielskim albo w testamencie, w formie aktu notarialnego, a osobowość prawną uzyskuje ona z chwilą wpisu do rejestru fundacji rodzinnych."}
    ],
    "prawo-medyczne" => [
      {"W jakim terminie trzeba udostępnić pacjentowi dokumentację medyczną?",
       "Bez zbędnej zwłoki. Pierwsza kopia dokumentacji w żądanym zakresie jest dla pacjenta bezpłatna; za kolejne podmiot może pobrać opłatę w wysokości ograniczonej ustawą."},
      {"Jak długo przechowuje się dokumentację medyczną?",
       "Co do zasady 20 lat, licząc od końca roku kalendarzowego, w którym dokonano ostatniego wpisu. Ustawa przewiduje wyjątki — na przykład 30 lat w razie zgonu pacjenta wskutek uszkodzenia ciała lub zatrucia oraz 22 lata dla dokumentacji dzieci do ukończenia drugiego roku życia."},
      {"Czy zgoda pacjenta na zabieg musi być pisemna?",
       "Forma pisemna jest wymagana przy zabiegu operacyjnym oraz przy metodzie leczenia lub diagnostyki stwarzającej podwyższone ryzyko dla pacjenta. W każdym przypadku zgodę musi poprzedzać przystępna informacja o stanie zdrowia, proponowanych metodach, ryzyku i następstwach."},
      {"Czy gabinet lekarski musi mieć ubezpieczenie OC?",
       "Tak. Podmiot wykonujący działalność leczniczą ma obowiązek zawrzeć umowę ubezpieczenia odpowiedzialności cywilnej, a ochrona powinna obowiązywać najpóźniej od dnia poprzedzającego rozpoczęcie działalności."},
      {"Kiedy przedawniają się roszczenia pacjenta?",
       "Co do zasady z upływem trzech lat od dnia, w którym pacjent dowiedział się o szkodzie i o osobie obowiązanej do jej naprawienia. W razie szkody na osobie termin nie może skończyć się wcześniej niż po trzech latach od uzyskania tej wiedzy."}
    ],
    "spory-gospodarcze" => [
      {"Czy w sprawie gospodarczej można powołać świadków?",
       "Tak, ale w ograniczonym zakresie. Sąd dopuszcza dowód z zeznań świadków dopiero wtedy, gdy po wyczerpaniu innych środków dowodowych pozostały niewyjaśnione fakty istotne dla sprawy. Czynności stron, takie jak zawarcie lub zmiana umowy, wykazuje się co do zasady dokumentami."},
      {"Ile kosztuje pozew w sprawie gospodarczej?",
       "Opłata od pozwu zależy od wartości przedmiotu sporu: do 20 000 zł jest stała i wynosi od 30 zł do 1 000 zł, a powyżej tej kwoty — 5% wartości, nie więcej niż 200 000 zł."},
      {"Czy postępowanie gospodarcze dotyczy jednoosobowej działalności?",
       "Tak. Strona, która jest przedsiębiorcą będącym osobą fizyczną albo nie jest przedsiębiorcą, może jednak złożyć wniosek o rozpoznanie sprawy z pominięciem przepisów o postępowaniu w sprawach gospodarczych."},
      {"Kiedy przedawniają się roszczenia między przedsiębiorcami?",
       "Co do zasady po trzech latach, z końcem roku kalendarzowego. Dla niektórych umów terminy są krótsze — na przykład dwa lata dla roszczeń ze sprzedaży dokonanej w zakresie działalności przedsiębiorstwa sprzedawcy i dla roszczeń z umowy o dzieło."},
      {"Czy przed pozwem trzeba próbować mediacji?",
       "Mediacja nie jest obowiązkowa, ale w pozwie trzeba wskazać, czy strony próbowały rozwiązać spór pozasądowo. Ugoda zawarta przed mediatorem i zatwierdzona przez sąd ma moc ugody sądowej."}
    ],
    "rodo" => [
      {"Czy mała firma musi wdrożyć RODO?",
       "Tak. RODO stosuje się do każdego przedsiębiorcy, który przetwarza dane osobowe klientów, pracowników lub kontrahentów — niezależnie od wielkości firmy. Zakres dokumentacji i zabezpieczeń powinien być jednak proporcjonalny do skali i ryzyka przetwarzania."},
      {"Kiedy trzeba powołać inspektora ochrony danych?",
       "Obowiązek dotyczy organów i podmiotów publicznych oraz firm, których główna działalność polega na regularnym i systematycznym monitorowaniu osób na dużą skalę albo na przetwarzaniu na dużą skalę szczególnych kategorii danych, na przykład danych o zdrowiu (art. 37 RODO)."},
      {"Jakie kary grożą za naruszenie RODO?",
       "Administracyjna kara pieniężna może wynieść do 20 mln euro albo do 4% całkowitego rocznego światowego obrotu przedsiębiorstwa — zastosowanie ma kwota wyższa. Za część naruszeń górna granica to 10 mln euro albo 2% obrotu."},
      {"Kiedy potrzebna jest umowa powierzenia przetwarzania danych?",
       "Zawsze wtedy, gdy inny podmiot przetwarza dane osobowe w imieniu administratora — na przykład biuro rachunkowe, dostawca hostingu albo firma serwisująca system informatyczny (art. 28 RODO)."},
      {"W jakim terminie trzeba odpowiedzieć na żądanie dostępu do danych lub ich usunięcia?",
       "Bez zbędnej zwłoki, najpóźniej w ciągu miesiąca od otrzymania żądania. W razie skomplikowanego charakteru żądania lub dużej ich liczby termin można przedłużyć o kolejne dwa miesiące, informując o tym osobę w ciągu pierwszego miesiąca."}
    ]
  }

  # More questions per page, taken from what people actually type into Google:
  # autocomplete suggestions collected on 2026-11-23 for each topic ("ile kosztuje…",
  # "czy…", "kiedy…"), limited to legal questions within the scope of the page.
  # Answers are our own, written from the statutes. Plain text only (JSON-LD).
  @searched %{
    "obsluga-przedsiebiorcow" => [
      {"Czy jednoosobowa działalność może korzystać ze stałej obsługi prawnej?",
       "Tak. Forma prawna i wielkość firmy nie mają znaczenia — zakres obsługi dopasowuje się do liczby i rodzaju spraw."},
      {"Czy umowę o stałą obsługę prawną można wypowiedzieć?",
       "Tak. Do umowy stosuje się przepisy o zleceniu, więc każda ze stron może ją wypowiedzieć; okres wypowiedzenia i zasady rozliczenia rozpoczętych spraw określa umowa."},
      {"Czy rozmowy z adwokatem obsługującym firmę są poufne?",
       "Tak. Adwokata obowiązuje tajemnica zawodowa, która obejmuje wszystko, o czym dowiedział się w związku z udzielaniem pomocy prawnej, i nie jest ograniczona w czasie."},
      {"Czy adwokat może reprezentować firmę przed sądem i urzędami?",
       "Tak. Adwokat może reprezentować przedsiębiorcę przed sądami wszystkich instancji, organami administracji i w negocjacjach z kontrahentami — na podstawie udzielonego pełnomocnictwa."}
    ],
    "zawyzony-metraz" => [
      {"Jak liczy się powierzchnię użytkową mieszkania?",
       "Według Polskiej Normy PN-ISO 9836 — od 13 lutego 2026 r. ustawa deweloperska odsyła do niej wprost. W starszych umowach sposób pomiaru wynika z treści umowy i prospektu informacyjnego, dlatego trzeba je przeczytać przed oceną roszczenia."},
      {"Czy za zaniżony metraż mieszkania należy się odszkodowanie lub rekompensata?",
       "Nabywca może żądać zwrotu nadpłaconej części ceny: różnicy powierzchni pomnożonej przez cenę metra kwadratowego z umowy, wraz z odsetkami. Potocznie nazywa się to odszkodowaniem albo rekompensatą za zaniżony lub zawyżony metraż."},
      {"Czy prowadzicie sprawy o metraż mieszkania w Warszawie i innych miastach?",
       "Tak. Sprawy o zwrot części ceny od dewelopera prowadzimy w całej Polsce. Umowę i pomiar analizujemy na podstawie przesłanych dokumentów, konsultację można odbyć telefonicznie lub przez wideo, a konsument może pozwać dewelopera przed sąd właściwy dla swojego miejsca zamieszkania."},
      {"Co to jest powierzchnia rozliczeniowa mieszkania?",
       "To powierzchnia, według której deweloper ostatecznie rozlicza cenę lokalu — ustalana zwykle w pomiarze powykonawczym. Sposób jej liczenia powinien wynikać z umowy. Spór powstaje najczęściej wtedy, gdy do powierzchni rozliczeniowej doliczono powierzchnię pod ściankami działowymi, której nie obejmuje powierzchnia użytkowa liczona według normy."},
      {"Czy trzeba płacić za powierzchnię pod ściankami działowymi?",
       "Zależy od rodzaju ścian i treści umowy. Sądy przyznają rację nabywcom zwłaszcza wtedy, gdy ściany są stałe, a umowa nie informowała jasno, że cena obejmuje także powierzchnię, którą zajmują. Nadpłaconej części ceny można wówczas dochodzić od dewelopera."},
      {"Co zrobić przy niezgodności metrażu mieszkania z umową deweloperską?",
       "Najpierw sprawdzić w umowie postanowienia o różnicy powierzchni i sposobie pomiaru oraz porównać je z pomiarem powykonawczym. W razie wątpliwości warto zlecić własny pomiar geodecie, a następnie wezwać dewelopera do zwrotu nadpłaconej części ceny."},
      {"Kto wykonuje pomiar mieszkania i czy można go podważyć?",
       "Pomiar powykonawczy zleca zwykle deweloper. Nabywca może zlecić własny pomiar uprawnionemu geodecie, a w procesie powierzchnię ustala biegły powołany przez sąd."},
      {"Czy można żądać zwrotu od dewelopera kilka lat po zakupie mieszkania?",
       "Tak, dopóki roszczenie nie jest przedawnione. Konsument dochodzi go co do zasady w terminie sześciu lat, liczonym do końca roku kalendarzowego, dlatego roszczenia dotyczące mieszkań kupionych kilka lat temu często nadal są aktualne."}
    ],
    "rozwod" => [
      {"Kiedy wyrok rozwodowy staje się prawomocny?",
       "Jeżeli żadna ze stron nie złoży w ciągu tygodnia od ogłoszenia wyroku wniosku o jego uzasadnienie, wyrok uprawomocnia się z upływem tego terminu. Gdy wniosek zostanie złożony — po bezskutecznym upływie dwóch tygodni na wniesienie apelacji, liczonych od doręczenia wyroku z uzasadnieniem."},
      {"Czy rozwód z orzeczeniem o winie wpływa na podział majątku?",
       "Bezpośrednio nie. Udziały małżonków w majątku wspólnym są co do zasady równe niezależnie od winy. Sąd może ustalić nierówne udziały tylko z ważnych powodów i z uwzględnieniem stopnia, w którym każde z małżonków przyczyniło się do powstania majątku. Wina ma natomiast znaczenie dla alimentów między byłymi małżonkami."},
      {"Czym różni się rozwód od separacji?",
       "Separację sąd orzeka, gdy rozkład pożycia jest zupełny, ale nie musi być trwały. Małżeństwo formalnie trwa, więc małżonkowie nie mogą zawrzeć nowego związku, a separację można znieść na ich zgodne żądanie. Poza tym separacja wywołuje co do zasady takie skutki jak rozwód, w tym rozdzielność majątkową."},
      {"Czy można wycofać pozew o rozwód?",
       "Tak. Pozew można cofnąć bez zgody drugiego małżonka do rozpoczęcia rozprawy, a później — za jego zgodą albo wraz ze zrzeczeniem się roszczenia."}
    ],
    "sprawy-rodzinne" => [
      {"Czy kontakty z dzieckiem mogą odbywać się w obecności kuratora?",
       "Tak. Jeżeli wymaga tego dobro dziecka, sąd może ograniczyć kontakty — między innymi zezwolić na spotkania tylko w obecności drugiego rodzica, opiekuna albo kuratora sądowego."}
    ],
    "podzial-majatku" => [
      {"Ile jest czasu na podział majątku po rozwodzie?",
       "Nie ma terminu. Podział majątku nie jest obowiązkowy, a żądanie podziału nie ulega przedawnieniu — można go przeprowadzić także wiele lat po rozwodzie. Z upływem czasu trudniej jednak wykazać skład majątku i poniesione nakłady."},
      {"Co wchodzi w skład majątku wspólnego?",
       "Przede wszystkim przedmioty nabyte w czasie trwania wspólności przez oboje małżonków lub jedno z nich, w tym wynagrodzenia za pracę i dochody z majątku. Do majątku osobistego należą między innymi przedmioty nabyte przed ślubem oraz otrzymane w spadku lub darowiźnie, chyba że spadkodawca lub darczyńca postanowił inaczej."},
      {"Kiedy sąd ustali nierówne udziały w majątku wspólnym?",
       "Z ważnych powodów każde z małżonków może żądać ustalenia udziałów z uwzględnieniem stopnia, w którym przyczyniło się do powstania majątku. Sąd bierze przy tym pod uwagę także nakład osobistej pracy przy wychowaniu dzieci i we wspólnym gospodarstwie domowym — sam brak pracy zarobkowej nie uzasadnia więc mniejszego udziału."},
      {"Czy majątek można podzielić przed rozwodem?",
       "Tylko po ustaniu wspólności majątkowej. Przed rozwodem wymaga to ustanowienia rozdzielności — umową zawartą u notariusza albo orzeczeniem sądu."},
      {"Ile trwa sprawa o podział majątku?",
       "Przy zgodnym wniosku sprawa może zakończyć się na jednym posiedzeniu. Spór o skład i wartość majątku, wymagający opinii biegłych, trwa wyraźnie dłużej."}
    ],
    "upadlosc-konsumencka" => [
      {"Czy upadłość konsumencka obejmuje długi wobec ZUS i urzędu skarbowego?",
       "Co do zasady tak — umorzenie może objąć także zaległości podatkowe i składkowe powstałe przed ogłoszeniem upadłości."},
      {"Ile trwa upadłość konsumencka?",
       "Nie da się tego określić z góry. Czas zależy od kompletności wniosku, liczby wierzycieli i tego, czy trzeba sprzedać majątek; gdy majątku nie ma, postępowanie jest zwykle krótsze. Sam plan spłaty trwa do trzech lat, a w określonych przypadkach od trzech do siedmiu."},
      {"Czy długi po upadłości przechodzą na dzieci lub małżonka?",
       "Nie. Sama więź rodzinna nie tworzy obowiązku spłaty cudzych długów. Inaczej jest ze współkredytobiorcą lub poręczycielem — umorzenie zobowiązań upadłego nie zwalnia ich z długu."},
      {"Czy wniosek o upadłość konsumencką można złożyć samodzielnie?",
       "Tak, udział adwokata nie jest obowiązkowy. Wniosek składa się przez Krajowy Rejestr Zadłużonych albo na formularzu. Trzeba w nim rzetelnie opisać majątek, wierzycieli i przyczyny niewypłacalności, bo braki i nieścisłości utrudniają oddłużenie."},
      {"Jakie są skutki ogłoszenia upadłości konsumenckiej?",
       "Majątek upadłego staje się masą upadłości, którą zarządza syndyk, a część wynagrodzenia podlegająca zajęciu trafia do masy. Między małżonkami powstaje rozdzielność majątkowa. W okresie wykonywania planu spłaty upadły nie może dokonywać czynności, które pogorszyłyby jego zdolność do wykonania planu."}
    ],
    "sprawy-o-zaplate" => [
      {"Kiedy nakaz zapłaty staje się prawomocny?",
       "Po bezskutecznym upływie terminu na wniesienie sprzeciwu albo zarzutów. Prawomocny nakaz zapłaty ma skutki prawomocnego wyroku."},
      {"Czy nakaz zapłaty jest tytułem wykonawczym?",
       "Prawomocny nakaz zapłaty jest tytułem egzekucyjnym. Tytułem wykonawczym, na podstawie którego działa komornik, staje się po nadaniu mu klauzuli wykonalności."},
      {"Czy nakaz zapłaty można rozłożyć na raty?",
       "Sąd może w szczególnie uzasadnionych wypadkach rozłożyć zasądzone świadczenie na raty, ale wymaga to zaskarżenia nakazu i wniosku pozwanego. Po uprawomocnieniu się nakazu raty można uzgodnić już tylko z wierzycielem."},
      {"Jak długo ważny jest nakaz zapłaty?",
       "Roszczenie stwierdzone prawomocnym nakazem zapłaty przedawnia się z upływem sześciu lat, a odsetki należne w przyszłości — trzech lat. Każdy wniosek o wszczęcie egzekucji przerywa bieg tego terminu."}
    ],
    "odszkodowania" => [
      {"Ile wynosi zadośćuczynienie za wypadek?",
       "Przepisy nie przewidują stawek ani tabel. Sąd ustala kwotę indywidualnie, biorąc pod uwagę rodzaj i trwałość obrażeń, przebieg leczenia, wiek poszkodowanego oraz wpływ wypadku na jego pracę i życie codzienne."},
      {"Kto wypłaca odszkodowanie za wypadek przy pracy?",
       "Jednorazowe odszkodowanie za stały lub długotrwały uszczerbek na zdrowiu wypłaca ZUS. Jeżeli świadczenia z ubezpieczenia wypadkowego nie pokrywają całej szkody, poszkodowany może dochodzić roszczeń uzupełniających od pracodawcy na podstawie przepisów prawa cywilnego."},
      {"Czy za wypadek w drodze do pracy należy się odszkodowanie?",
       "Jednorazowe odszkodowanie z ZUS w takim przypadku nie przysługuje, ale zasiłek chorobowy wynosi 100% podstawy wymiaru. Niezależnie od tego można dochodzić odszkodowania i zadośćuczynienia od sprawcy wypadku albo jego ubezpieczyciela."}
    ],
    "nieruchomosci" => [
      {"Jak udowodnić zasiedzenie nieruchomości?",
       "Trzeba wykazać samoistne posiadanie przez wymagany czas. Służą temu zeznania świadków, dowody opłacania podatku od nieruchomości, rachunki za remonty i budowę, ogrodzenie czy zagospodarowanie działki. Wnioskodawcy pomagają domniemania: posiadania samoistnego, jego ciągłości i dobrej wiary."},
      {"Co przerywa bieg zasiedzenia?",
       "Przede wszystkim czynność podjęta przed sądem bezpośrednio w celu odzyskania nieruchomości, na przykład pozew o jej wydanie, oraz uznanie prawa właściciela przez posiadacza. Samo pismo lub wezwanie skierowane do posiadacza biegu zasiedzenia nie przerywa."},
      {"Czy zasiedzenie przechodzi na spadkobierców?",
       "Tak. Spadkobierca może doliczyć do swojego czasu posiadania czas posiadania spadkodawcy, a nabywca — czas posiadania poprzednika."},
      {"Czy można zasiedzieć nieruchomość Skarbu Państwa lub gminy?",
       "Obecnie tak, na ogólnych zasadach, z ograniczeniami dotyczącymi okresu sprzed 1 października 1990 r., kiedy zasiedzenie nieruchomości państwowych było wyłączone."}
    ],
    "prawa-konsumentow" => [
      {"Czy można reklamować towar bez paragonu?",
       "Tak. Paragon nie jest warunkiem reklamacji — wystarczy inny dowód zakupu u danego sprzedawcy, na przykład potwierdzenie płatności kartą, wiadomość e-mail z zamówieniem albo zeznania świadka."},
      {"Czy odstąpienie od umowy można wysłać mailem?",
       "Tak. Oświadczenie o odstąpieniu od umowy zawartej na odległość lub poza lokalem można złożyć w dowolnej formie, także e-mailem; formularz sprzedawcy nie jest obowiązkowy. Do zachowania terminu wystarczy wysłanie oświadczenia przed jego upływem — warto zachować dowód wysyłki."},
      {"Kiedy na odstąpienie od umowy jest 30 dni?",
       "Gdy umowę zawarto poza lokalem przedsiębiorstwa podczas nieumówionej wizyty przedsiębiorcy w miejscu zamieszkania lub pobytu konsumenta albo podczas wycieczki. W pozostałych przypadkach termin wynosi 14 dni."},
      {"Czym różni się odstąpienie od umowy od reklamacji?",
       "Odstąpienie od umowy zawartej na odległość nie wymaga podania przyczyny i dotyczy także towaru bez wad. Reklamację składa się wtedy, gdy towar jest niezgodny z umową — prowadzi ona w pierwszej kolejności do naprawy lub wymiany."},
      {"Kto płaci za odesłanie towaru przy odstąpieniu od umowy?",
       "Co do zasady konsument — ponosi bezpośrednie koszty zwrotu towaru, chyba że sprzedawca zgodził się je pokryć albo nie poinformował o tym obowiązku. Sprzedawca zwraca natomiast cenę i koszt najtańszego oferowanego sposobu dostawy."}
    ],
    "sprawy-spadkowe" => [
      {"Jak odrzucić spadek — w sądzie czy u notariusza?",
       "Oświadczenie o odrzuceniu spadku składa się przed sądem albo przed notariuszem. Opłata sądowa za odebranie oświadczenia wynosi 100 zł; u notariusza płaci się taksę notarialną."},
      {"Czy trzeba odrzucić spadek także w imieniu dziecka?",
       "Zwykle tak. Udział rodzica, który odrzucił spadek, przypada jego dzieciom, więc aby i one nie odziedziczyły długów, spadek odrzuca się również w ich imieniu — w terminie sześciu miesięcy liczonym od dnia, w którym dziecko zostało powołane do spadku."},
      {"Ile trwa sprawa o stwierdzenie nabycia spadku?",
       "Gdy krąg spadkobierców jest jasny, a dokumenty kompletne, sąd może wydać postanowienie na pierwszej rozprawie. Spór o ważność testamentu albo konieczność odszukania spadkobierców wydłuża postępowanie."},
      {"Czy testament napisany odręcznie jest ważny?",
       "Tak, jeżeli spadkodawca napisał go w całości pismem ręcznym, podpisał i opatrzył datą. Brak daty nie powoduje nieważności, o ile nie wywołuje wątpliwości co do zdolności spadkodawcy do sporządzenia testamentu, jego treści albo wzajemnego stosunku kilku testamentów. Testament napisany na komputerze i jedynie podpisany jest nieważny."},
      {"Czy dział spadku jest obowiązkowy?",
       "Nie. Spadkobiercy mogą pozostać współwłaścicielami majątku spadkowego bezterminowo, a żądanie działu spadku nie ulega przedawnieniu. Bez działu każda ważniejsza decyzja dotycząca wspólnego majątku wymaga jednak zgody współspadkobierców."}
    ],
    "prawo-karne" => [
      {"Czy można wycofać zawiadomienie o przestępstwie?",
       "Przy przestępstwach ściganych z urzędu — nie: postępowanie toczy się niezależnie od woli zawiadamiającego. Przy przestępstwach ściganych na wniosek pokrzywdzony może cofnąć wniosek za zgodą prokuratora, a w postępowaniu sądowym za zgodą sądu — do rozpoczęcia przewodu sądowego na pierwszej rozprawie głównej."},
      {"Co daje status oskarżyciela posiłkowego?",
       "Pokrzywdzony staje się stroną postępowania sądowego: może zadawać pytania świadkom i oskarżonemu, składać wnioski dowodowe, zabierać głos na rozprawie i zaskarżyć wyrok apelacją."},
      {"Czy oskarżyciel posiłkowy może mieć adwokata i czy ponosi koszty?",
       "Może ustanowić pełnomocnika, który reprezentuje go w całym postępowaniu. W razie skazania sąd zasądza od oskarżonego na rzecz oskarżyciela posiłkowego poniesione wydatki, w tym koszty ustanowienia pełnomocnika."},
      {"Czy oskarżyciel posiłkowy musi być na rozprawie?",
       "Nie, jego obecność jest prawem, a nie obowiązkiem. Stawić się musi wtedy, gdy sąd wezwie go na przesłuchanie w charakterze świadka."},
      {"Kto może złożyć zawiadomienie o przestępstwie?",
       "Każdy, kto dowiedział się o popełnieniu przestępstwa ściganego z urzędu — nie tylko pokrzywdzony. Przy przestępstwach ściganych na wniosek potrzebny jest wniosek samego pokrzywdzonego."}
    ],
    "zakladanie-spolek" => [
      {"Jak założyć spółkę z o.o. krok po kroku?",
       "Trzeba zawrzeć umowę spółki — u notariusza albo w systemie S24 — wnieść wkłady na pokrycie kapitału zakładowego, powołać zarząd i złożyć wniosek o wpis do KRS. Po rejestracji spółka zgłasza beneficjentów rzeczywistych do CRBR w ciągu 14 dni oraz dane uzupełniające do urzędu skarbowego."},
      {"Czy wspólnik spółki z o.o. płaci ZUS?",
       "Wspólnik spółki wieloosobowej nie podlega ubezpieczeniom z samego tytułu posiadania udziałów. Jedyny wspólnik jednoosobowej spółki z o.o. jest natomiast traktowany jak osoba prowadząca pozarolniczą działalność i opłaca składki."},
      {"Czy spółka z o.o. musi mieć zarząd i radę nadzorczą?",
       "Zarząd jest obowiązkowy i może być jednoosobowy. Radę nadzorczą albo komisję rewizyjną trzeba ustanowić dopiero wtedy, gdy kapitał zakładowy przewyższa 500 000 zł, a wspólników jest więcej niż dwudziestu pięciu."},
      {"Co daje założenie spółki z o.o.?",
       "Przede wszystkim oddzielenie majątku prywatnego od ryzyka działalności: za zobowiązania odpowiada spółka, a nie wspólnicy. Spółka ułatwia też przyjęcie wspólnika lub inwestora oraz sprzedaż albo dziedziczenie firmy, bo przedmiotem obrotu są udziały."}
    ],
    "umowy" => [
      {"Ile może wynosić kara umowna?",
       "Przepisy nie określają górnej granicy. Kara musi być oznaczona kwotą albo sposobem jej wyliczenia, na przykład jako procent wynagrodzenia za każdy dzień. Kara rażąco wygórowana może jednak zostać obniżona przez sąd."},
      {"Czy kara umowna wyłącza odszkodowanie?",
       "Kara umowna należy się w zastrzeżonej wysokości bez względu na wysokość szkody. Odszkodowania przewyższającego karę można żądać tylko wtedy, gdy strony tak postanowiły w umowie (art. 484 § 1 k.c.)."},
      {"Kara umowna za zwłokę czy za opóźnienie — jaka jest różnica?",
       "Zwłoka to opóźnienie, za które dłużnik ponosi odpowiedzialność. Kara zastrzeżona za opóźnienie jest surowsza: należy się także wtedy, gdy termin nie został dotrzymany z przyczyn niezależnych od dłużnika."},
      {"Kiedy przedawnia się kara umowna?",
       "Tak jak roszczenia z umowy, z której wynika: co do zasady po sześciu latach, a w obrocie między przedsiębiorcami po trzech latach. Przy niektórych umowach termin jest krótszy — na przykład dwa lata przy umowie o dzieło."},
      {"Czy umowa o współpracy to umowa B2B?",
       "B2B to potoczne określenie umowy między przedsiębiorcami, najczęściej umowy o świadczenie usług. Jeżeli jednak praca jest w rzeczywistości wykonywana pod kierownictwem oraz w miejscu i czasie wyznaczonym przez zamawiającego, istnieje ryzyko uznania jej za stosunek pracy — bez względu na nazwę umowy."}
    ],
    "egzekucja-wierzytelnosci" => [
      {"Kiedy przedawnia się niezapłacona faktura?",
       "Zależy od rodzaju umowy. Roszczenia ze sprzedaży dokonanej w zakresie działalności przedsiębiorstwa przedawniają się po dwóch latach, a roszczenia z większości umów o świadczenie usług — po trzech latach. Koniec terminu przypada na ostatni dzień roku kalendarzowego."},
      {"Po jakim czasie można oddać fakturę do windykacji?",
       "Już od dnia następującego po terminie płatności — przepisy nie wymagają odczekania ani określonej liczby monitów."},
      {"Ile trwa egzekucja komornicza?",
       "To zależy od majątku dłużnika. Zajęcie rachunku bankowego lub wynagrodzenia następuje stosunkowo szybko, a egzekucja z nieruchomości trwa znacznie dłużej ze względu na opis i oszacowanie oraz licytację."},
      {"Czy egzekucja komornicza przerywa bieg przedawnienia?",
       "Tak. Wniosek o wszczęcie egzekucji przerywa bieg przedawnienia, a termin biegnie na nowo po zakończeniu postępowania egzekucyjnego."},
      {"Ile kosztuje windykacja faktury?",
       "Na koszty składają się opłata sądowa zależna od dochodzonej kwoty — w elektronicznym postępowaniu upominawczym 1,25%, nie mniej niż 30 zł — oraz wynagrodzenie pełnomocnika. W razie wygranej koszty procesu zwraca dłużnik, a wierzycielowi przysługuje dodatkowo rekompensata za koszty odzyskiwania należności."}
    ],
    "restrukturyzacja" => [
      {"Ile trwa restrukturyzacja firmy?",
       "Najszybsze jest postępowanie o zatwierdzenie układu: od ustalenia dnia układowego dłużnik ma cztery miesiące na złożenie wniosku o zatwierdzenie układu. Pozostałe postępowania trwają dłużej, a najdłużej — sanacyjne."},
      {"Ile kosztuje restrukturyzacja firmy?",
       "Opłata sądowa od wniosku restrukturyzacyjnego wynosi 1 000 zł. Głównym kosztem jest wynagrodzenie nadzorcy lub zarządcy; w postępowaniu o zatwierdzenie układu ustala się je w umowie z doradcą restrukturyzacyjnym."},
      {"Kto prowadzi postępowanie restrukturyzacyjne?",
       "Sąd restrukturyzacyjny oraz — zależnie od rodzaju postępowania — nadzorca układu, nadzorca sądowy albo zarządca. Funkcje te pełnią licencjonowani doradcy restrukturyzacyjni."},
      {"Czy jednoosobowa firma może przejść restrukturyzację?",
       "Tak. Postępowanie restrukturyzacyjne jest dostępne także dla osób fizycznych prowadzących działalność gospodarczą."},
      {"Co restrukturyzacja oznacza dla pracowników?",
       "Umowy o pracę trwają nadal. Wierzytelności ze stosunku pracy mogą zostać objęte układem tylko za zgodą pracownika. Ułatwienia w redukcji zatrudnienia przewiduje jedynie postępowanie sanacyjne."}
    ],
    "obsluga-korporacyjna" => [
      {"Czy uchwałę wspólników można podjąć bez odbycia zgromadzenia?",
       "Tak, jeżeli wszyscy wspólnicy wyrażą na piśmie zgodę na postanowienie, które ma być powzięte, albo na głosowanie pisemne. Możliwy jest też udział w zgromadzeniu przy wykorzystaniu środków komunikacji elektronicznej, chyba że umowa spółki stanowi inaczej."},
      {"Kiedy uchwała wspólników wymaga notariusza?",
       "Protokół notarialny jest wymagany między innymi przy zmianie umowy spółki, podwyższeniu kapitału zakładowego w drodze zmiany umowy, rozwiązaniu spółki oraz przy jej połączeniu, podziale i przekształceniu. Zwykłe uchwały, na przykład o zmianie zarządu, mogą mieć formę pisemną."},
      {"Jakie dokumenty są potrzebne do zmiany zarządu w KRS?",
       "Uchwała o odwołaniu i powołaniu członka zarządu, zgoda nowego członka zarządu na powołanie wraz z jego adresem do doręczeń oraz wniosek złożony elektronicznie przez Portal Rejestrów Sądowych."},
      {"Ile trwa wpis zmiany zarządu w KRS?",
       "Przepisy przewidują rozpoznanie wniosku w ciągu siedmiu dni, w praktyce czas zależy od obłożenia sądu i kompletności dokumentów. Nowy zarząd może działać od chwili podjęcia uchwały — nie musi czekać na wpis."},
      {"Ile kosztuje zmiana umowy spółki?",
       "Opłata sądowa za wpis zmiany w KRS wynosi 250 zł, a ogłoszenie w Monitorze Sądowym i Gospodarczym — 100 zł. Do tego dochodzi taksa notarialna za zaprotokołowanie uchwały, a przy podwyższeniu kapitału zakładowego także podatek od czynności cywilnoprawnych."}
    ],
    "nowe-technologie" => [
      {"Czy AI Act obowiązuje w Polsce?",
       "Tak. To rozporządzenie unijne, które stosuje się bezpośrednio we wszystkich państwach członkowskich — nie wymaga przeniesienia do polskiej ustawy. Przepisy krajowe określają jedynie organ nadzoru i procedury."},
      {"Czy korzystanie z AI może naruszać cudze prawa autorskie?",
       "Może. Jeżeli wygenerowany wynik odtwarza rozpoznawalne elementy cudzego utworu, jego rozpowszechnianie narusza prawa twórcy, a odpowiedzialność ponosi ten, kto z wyniku korzysta. Dlatego materiały przeznaczone do publikacji warto weryfikować."},
      {"Co to jest AI Act?",
       "To rozporządzenie Unii Europejskiej 2024/1689, które ustanawia zharmonizowane przepisy dotyczące sztucznej inteligencji. Nakłada obowiązki na dostawców i użytkowników systemów AI, zróżnicowane według poziomu ryzyka."},
      {"Czy AI Act działa wstecz?",
       "Co do zasady nie. Obowiązki stosuje się od dat wskazanych w rozporządzeniu, a dla systemów i modeli wprowadzonych do obrotu wcześniej przewidziano przepisy przejściowe."},
      {"Jakie kary przewiduje AI Act?",
       "Za stosowanie zakazanych praktyk — do 35 mln euro albo 7% całkowitego rocznego światowego obrotu, a za naruszenie większości pozostałych obowiązków — do 15 mln euro albo 3% obrotu. Dla małych i średnich przedsiębiorstw stosuje się niższą z tych wartości."}
    ],
    "sukcesja-firm" => [
      {"Kto może być zarządcą sukcesyjnym?",
       "Osoba fizyczna, która ma pełną zdolność do czynności prawnych i wobec której nie orzeczono zakazu prowadzenia działalności gospodarczej. Nie musi należeć do rodziny przedsiębiorcy. W tym samym czasie funkcję może pełnić tylko jedna osoba."},
      {"Jak ustanowić zarządcę sukcesyjnego za życia?",
       "Przedsiębiorca powołuje zarządcę na piśmie, zarządca wyraża pisemną zgodę, a powołanie zgłasza się do CEIDG. Wpis jest bezpłatny i można go złożyć przez internet."},
      {"Czy zarządca sukcesyjny odpowiada za długi firmy?",
       "Nie odpowiada za zobowiązania przedsiębiorstwa własnym majątkiem — działa w imieniu własnym, ale na rachunek właścicieli przedsiębiorstwa w spadku. Odpowiada natomiast za szkodę wyrządzoną nienależytym wykonywaniem swoich obowiązków."},
      {"Czy fundacja rodzinna może prowadzić działalność gospodarczą?",
       "Tylko w zakresie dozwolonym ustawą: między innymi może wynajmować i dzierżawić mienie, posiadać udziały w spółkach, nabywać i zbywać papiery wartościowe oraz udzielać pożyczek spółkom, w których uczestniczy, i beneficjentom."},
      {"Czy fundacja rodzinna jest osobą prawną?",
       "Tak. Osobowość prawną uzyskuje z chwilą wpisu do rejestru fundacji rodzinnych; wcześniej działa jako fundacja rodzinna w organizacji."}
    ],
    "prawo-medyczne" => [
      {"Kto ma dostęp do dokumentacji medycznej pacjenta?",
       "Pacjent, jego przedstawiciel ustawowy i osoba przez niego upoważniona. Po śmierci pacjenta — osoba upoważniona za życia oraz osoba bliska, o ile pacjent się temu nie sprzeciwił. Ustawa wymienia też uprawnione podmioty i organy, między innymi sądy, prokuraturę i NFZ."},
      {"Czy dokumentacja medyczna może być prowadzona w formie papierowej?",
       "Zasadą jest postać elektroniczna. Postać papierowa jest dopuszczalna, gdy przepis tak stanowi albo gdy warunki organizacyjno-techniczne uniemożliwiają prowadzenie dokumentacji elektronicznie."},
      {"Kiedy zgoda pacjenta nie jest potrzebna?",
       "Gdy pacjent wymaga niezwłocznej pomocy lekarskiej, a ze względu na stan zdrowia lub wiek nie może wyrazić zgody i nie ma możliwości porozumienia się z jego przedstawicielem ustawowym lub opiekunem faktycznym."},
      {"Czy dokumentacja medyczna jest własnością pacjenta?",
       "Nie. Dokumentacja należy do podmiotu, który ją prowadzi i odpowiada za jej przechowywanie. Pacjent ma natomiast prawo dostępu do niej — przez wgląd, kopię, odpis, wyciąg lub wydruk."}
    ],
    "spory-gospodarcze" => [
      {"Co to jest sprawa gospodarcza?",
       "To przede wszystkim sprawa ze stosunków cywilnych między przedsiębiorcami w zakresie prowadzonej przez nich działalności gospodarczej. Ustawa zalicza do nich także między innymi sprawy ze stosunku spółki oraz z umów o roboty budowlane i leasingu."},
      {"Na czym polega prekluzja dowodowa w sprawie gospodarczej?",
       "Powód musi powołać wszystkie twierdzenia i dowody w pozwie, a pozwany — w odpowiedzi na pozew. Późniejsze sąd pomija, chyba że strona wykaże, że ich powołanie nie było możliwe albo potrzeba wynikła później; wtedy ma na to dwa tygodnie."},
      {"Czy sprawa gospodarcza jest sprawą cywilną?",
       "Tak. To sprawa cywilna rozpoznawana w postępowaniu odrębnym, czyli według Kodeksu postępowania cywilnego ze zmianami przewidzianymi dla spraw gospodarczych."},
      {"Który sąd rozpoznaje sprawy gospodarcze?",
       "Wydziały gospodarcze sądów rejonowych, a przy wartości przedmiotu sporu powyżej 100 000 zł — sądów okręgowych. Strony będące przedsiębiorcami mogą w umowie wskazać sąd właściwy miejscowo."}
    ],
    "rodo" => [
      {"Jak wdrożyć RODO w firmie krok po kroku?",
       "Najpierw ustala się, jakie dane, w jakim celu i na jakiej podstawie firma przetwarza. Następnie przygotowuje się klauzule informacyjne, rejestr czynności przetwarzania i umowy powierzenia, ocenia ryzyko i dobiera zabezpieczenia, nadaje upoważnienia i szkoli pracowników, a na koniec wprowadza procedury obsługi żądań i naruszeń."},
      {"Kto odpowiada za RODO w firmie?",
       "Administrator danych, czyli sam przedsiębiorca albo spółka — nie pracownik ani inspektor ochrony danych. Inspektor doradza i monitoruje, ale odpowiedzialność wobec osób i organu nadzorczego ponosi administrator."},
      {"Czy inspektor ochrony danych musi być pracownikiem firmy?",
       "Nie. Inspektor może być członkiem personelu albo wykonywać zadania na podstawie umowy o świadczenie usług (art. 37 ust. 6 RODO)."},
      {"Co musi zawierać umowa powierzenia przetwarzania danych?",
       "Przedmiot, czas trwania, charakter i cel przetwarzania, rodzaj danych i kategorie osób oraz obowiązki stron. Podmiot przetwarzający zobowiązuje się między innymi przetwarzać dane wyłącznie na udokumentowane polecenie administratora, zapewnić poufność i zabezpieczenia, korzystać z dalszych podmiotów tylko za zgodą administratora oraz po zakończeniu umowy usunąć lub zwrócić dane (art. 28 ust. 3 RODO)."}
    ]
  }

  @doc """
  Visible FAQ for a service page (also its `FAQPage` JSON-LD): the topic
  question answered by the service notes, then the extended FAQ of
  `ServiceDetails` or, on a short page, its `@questions`, then the questions
  people search for (`@searched`).
  """
  def faq(service) do
    extra =
      case KralukKurkierewicz.ServiceDetails.get(service.slug) do
        %{faq: faq} -> faq
        _ -> Map.get(@questions, service.slug, [])
      end

    [{Map.get(@faq_questions, service.slug, service.notes_title), Enum.join(service.notes, " ")}] ++
      extra ++ Map.get(@searched, service.slug, [])
  end

  # Date of the last change to the pages without extended content (first
  # published 2026-11-22); bump it only when their text really changes.
  @published ~D[2026-11-23]

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
