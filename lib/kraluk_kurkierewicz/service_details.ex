defmodule KralukKurkierewicz.ServiceDetails do
  @moduledoc """
  Long-form content for the most important service pages (`/uslugi/<slug>`).

  A service listed here gets extra sections, a document checklist, more FAQ
  entries and a "who handles these cases" box on top of the base data in
  `KralukKurkierewicz.Services`. The text is based on the firm's own blog posts —
  keep both in sync when the law or the posts change.

  Each entry:

    * `:updated` — date of the last real content change (sitemap `lastmod`);
      bump it only when this page's text changes
    * `:lead` — `KralukKurkierewicz.Team` slug of the partner handling these cases,
      or a list of slugs when both do (see `leads/1`)
    * `:sections` — `{title, blocks}`; a block is a paragraph string,
      `{:list, items}`, `{:rulings, [{text, link_label, url}]}` or `:calculator`
    * `:documents` — checklist of documents to bring
    * `:faq` — extra `{question, answer}` pairs
  """

  @details %{
    "zawyzony-metraz" => %{
      updated: ~D[2026-11-22],
      lead: ["milena-kraluk", "michal-kurkierewicz"],
      sections: [
        {"Jak mierzy się powierzchnię użytkową mieszkania",
         [
           "Powierzchnię użytkową lokalu ustala się według Polskiej Normy PN-ISO 9836. Na gruncie jej wersji z 1997 r. deweloperzy przyjmowali, że do powierzchni użytkowej można wliczać ścianki działowe „nadające się do demontażu”. Wersja PN-ISO 9836:2015-12 doprecyzowała, że chodzi o ścianki typu przepierzenia, a powierzchni pod stałymi ścianami działowymi nie wlicza się do powierzchni użytkowej.",
           "W praktyce znaczenie ma to, która wersja normy obowiązywała w dniu złożenia wniosku o pozwolenie na budowę, oraz to, jak sposób pomiaru opisano w umowie deweloperskiej. Dlatego analizę zaczynamy od dokumentów, a nie od samego pomiaru."
         ]},
        {"Co mówią sądy",
         [
           "Pełne teksty dwóch wyroków korzystnych dla nabywców opublikowano na oficjalnych stronach sądów:",
           {:rulings,
            [
              {"Wyrok Sądu Okręgowego Warszawa-Praga w Warszawie z 24 kwietnia 2024 r., sygn. akt IV Ca 1735/23. Sąd uznał, że powierzchni zajętej przez murowane ściany wewnętrzne, których nie da się zdemontować i ponownie zamontować, nie można wliczać do powierzchni użytkowej lokalu. Postanowienie umowy pozwalające doliczać powierzchnię pod ściankami działowymi ocenił jako niedozwolone i zasądził od dewelopera 21 779,34 zł.",
               "Treść wyroku w Portalu Orzeczeń Sądów Powszechnych",
               "https://orzeczenia.ms.gov.pl/details/$N/154510000002003_IV_Ca_001735_2023_Uz_2024-06-05_001"},
              {"Wyrok Sądu Okręgowego w Warszawie z 8 maja 2026 r., sygn. akt V Ca 1440/25. Sąd oddalił apelację dewelopera od wyroku zasądzającego na rzecz trojga nabywców zwrot części ceny — od ok. 11 tys. do ok. 24 tys. zł. Podkreślił, że samo zaakceptowanie przez konsumenta warunków umowy nie oznacza akceptacji ich niedozwolonego charakteru.",
               "Treść wyroku w BIP Sądu Okręgowego w Warszawie",
               "https://bip.warszawa.so.gov.pl/attachments/download/22355"}
            ]},
           "Orzecznictwo nie jest jednolite — zdarzają się też wyroki oddalające powództwa nabywców. Wynik zależy od treści umowy, rodzaju ścian i zastosowanej wersji normy, dlatego każdą sprawę oceniamy indywidualnie."
         ]},
        {"Ile można odzyskać — kalkulator nadpłaty",
         [
           "Nadpłata to różnica między powierzchnią, za którą zapłaciłeś, a powierzchnią użytkową liczoną bez stałych ścian działowych, pomnożona przez cenę metra kwadratowego z umowy. Wpisz swoje dane, aby zobaczyć orientacyjną kwotę.",
           :calculator,
           "Wynik jest szacunkiem. Do kwoty głównej dochodzą odsetki ustawowe za opóźnienie, a o tym, którą powierzchnię sąd uzna za prawidłową, decyduje umowa i pomiar — najlepiej zweryfikowany przez geodetę."
         ]},
        {"Kiedy roszczenie ma szanse powodzenia",
         [
           "Podstawą roszczenia jest najczęściej zarzut, że postanowienie umowy określające sposób liczenia powierzchni jest niedozwolone (art. 385¹ § 1 k.c.) i nie wiąże nabywcy. Nadpłaconej części ceny można wówczas dochodzić jako świadczenia nienależnego (art. 405 w zw. z art. 410 § 2 k.c.). Sądy przyznają rację kupującym przede wszystkim wtedy, gdy:",
           {:list,
            [
              "ściany działowe są murowane lub w inny sposób stałe — nie są lekkimi przepierzeniami,",
              "umowa odsyła do normy PN-ISO 9836, a jednocześnie pozwala doliczać powierzchnię pod ściankami,",
              "umowa nie informowała w jasny sposób o metodzie pomiaru,",
              "nabywca jest konsumentem, a postanowienie nie było z nim indywidualnie uzgodnione."
            ]}
         ]},
        {"Przedawnienie roszczenia o zwrot części ceny",
         [
           "Roszczenie o zwrot nadpłaconej ceny jest roszczeniem majątkowym i ulega przedawnieniu. Konsument dochodzi go co do zasady w ogólnym, sześcioletnim terminie z art. 118 k.c., przy czym koniec terminu przypada na ostatni dzień roku kalendarzowego. Do roszczeń konsumentów, które powstały przed 9 lipca 2018 r. i nie były wtedy przedawnione, stosuje się wcześniejszy, dziesięcioletni termin.",
           "Sporny bywa początek biegu terminu. W sprawach dotyczących niedozwolonych postanowień umownych orzecznictwo wiąże go z chwilą, w której konsument dowiedział się lub powinien był się dowiedzieć o niedozwolonym charakterze postanowienia. Bieg przedawnienia przerywa wniesienie pozwu. Jeżeli mieszkanie zostało kupione kilka lat temu, nie warto odkładać analizy umowy."
         ]},
        {"Jak prowadzimy sprawę",
         [
           {:list,
            [
              "Analiza dokumentów — umowa, prospekt, rzut lokalu, wersja normy i sposób pomiaru.",
              "Weryfikacja powierzchni — w razie potrzeby pomiar wykonany przez geodetę.",
              "Wezwanie dewelopera do zapłaty i negocjacje.",
              "Pozew o zapłatę i reprezentacja przed sądem, jeżeli deweloper odmawia zwrotu."
            ]},
           "Po analizie dokumentów mówimy wprost, czy roszczenie ma szanse powodzenia i z jakimi kosztami należy się liczyć."
         ]}
      ],
      documents: [
        "umowa deweloperska (lub przedwstępna) wraz z załącznikami",
        "umowa przeniesienia własności lokalu (akt notarialny)",
        "prospekt informacyjny i rzut lokalu",
        "protokół odbioru i pomiar powykonawczy powierzchni",
        "potwierdzenia zapłaty ceny i ewentualne rozliczenie różnicy powierzchni",
        "informacja o dacie wniosku o pozwolenie na budowę (zwykle w umowie lub prospekcie)",
        "korespondencja z deweloperem dotycząca metrażu"
      ],
      faq: [
        {"Czy ścianki działowe wlicza się do powierzchni użytkowej mieszkania?",
         "Zależy od rodzaju ścian i wersji normy PN-ISO 9836. Wersja z 2015 r. doprecyzowała, że do powierzchni użytkowej można wliczać jedynie ścianki typu przepierzenia, a powierzchni pod stałymi ścianami działowymi się nie wlicza. Znaczenie ma też to, która wersja normy obowiązywała w dniu złożenia wniosku o pozwolenie na budowę."},
        {"Ile można odzyskać od dewelopera?",
         "Różnicę powierzchni pomnożoną przez cenę metra kwadratowego z umowy, powiększoną o odsetki. W sprawach, których wyroki opublikowano, sądy zasądzały od ok. 11 tys. do ok. 24 tys. zł na jednego nabywcę. Kwotę w swojej sprawie możesz oszacować w kalkulatorze na tej stronie."},
        {"Kiedy przedawnia się roszczenie o zwrot części ceny?",
         "Co do zasady po sześciu latach, z końcem roku kalendarzowego. Do roszczeń konsumentów powstałych przed 9 lipca 2018 r. i wówczas nieprzedawnionych stosuje się termin dziesięcioletni. Początek biegu terminu bywa sporny, dlatego warto sprawdzić go w konkretnej sprawie."},
        {"Jakie dokumenty są potrzebne do oceny sprawy?",
         "Przede wszystkim umowa deweloperska i umowa przeniesienia własności, prospekt informacyjny, rzut lokalu oraz pomiar powykonawczy. Przydatne są także potwierdzenia zapłaty ceny i korespondencja z deweloperem."},
        {"Czy podpisanie umowy i protokołu odbioru zamyka drogę do roszczenia?",
         "Niekoniecznie. Sąd Okręgowy w Warszawie w wyroku z 8 maja 2026 r. (V Ca 1440/25) podkreślił, że samo zaakceptowanie przez konsumenta warunków umowy nie oznacza akceptacji ich niedozwolonego charakteru."}
      ]
    },
    "rozwod" => %{
      updated: ~D[2026-11-22],
      lead: "milena-kraluk",
      sections: [
        {"Kiedy sąd orzeknie rozwód",
         [
           "Warunkiem rozwodu jest zupełny i trwały rozkład pożycia (art. 56 § 1 k.r.o.). Zupełny oznacza ustanie więzi uczuciowej, fizycznej i gospodarczej między małżonkami, a trwały — że nie można oczekiwać powrotu do wspólnego życia. Przepisy nie wymagają określonego okresu rozłąki; sąd ocenia okoliczności konkretnego małżeństwa.",
           "Mimo rozkładu pożycia sąd nie orzeknie rozwodu w trzech sytuacjach:",
           {:list,
            [
              "gdyby wskutek rozwodu miało ucierpieć dobro wspólnych małoletnich dzieci,",
              "gdyby orzeczenie rozwodu było z innych względów sprzeczne z zasadami współżycia społecznego,",
              "gdy rozwodu żąda małżonek wyłącznie winny rozkładu pożycia — chyba że drugi małżonek wyrazi zgodę na rozwód albo jego odmowa jest sprzeczna z zasadami współżycia społecznego."
            ]}
         ]},
        {"Rozwód z orzekaniem o winie czy bez",
         [
           "Co do zasady sąd orzeka, czy i który z małżonków ponosi winę rozkładu pożycia. Na zgodne żądanie obojga małżonków sąd zaniecha orzekania o winie — następują wtedy skutki takie, jakby żaden z małżonków nie ponosił winy (art. 57 k.r.o.).",
           "Wybór ma praktyczne konsekwencje. Rozwód bez orzekania o winie jest szybszy i tańszy: zwykle nie wymaga przesłuchiwania świadków, a sąd zwraca połowę opłaty od pozwu. Orzeczenie o winie wymaga udowodnienia przyczyn rozkładu pożycia, ale wpływa na późniejsze alimenty między byłymi małżonkami — małżonek wyłącznie winny może zostać zobowiązany do alimentów na rzecz małżonka niewinnego, jeżeli rozwód pociąga za sobą istotne pogorszenie jego sytuacji materialnej, nawet gdy nie znajduje się on w niedostatku (art. 60 § 2 k.r.o.).",
           "Decyzję o żądaniu orzeczenia o winie warto podjąć po ocenie dowodów i tego, co realnie można dzięki niemu uzyskać. Omawiamy to z Klientem przed złożeniem pozwu."
         ]},
        {"Co sąd rozstrzyga w wyroku rozwodowym",
         [
           "Wyrok rozwodowy to nie tylko rozwiązanie małżeństwa. Zgodnie z art. 58 k.r.o. sąd rozstrzyga w nim również o:",
           {:list,
            [
              "władzy rodzicielskiej nad wspólnym małoletnim dzieckiem,",
              "kontaktach rodziców z dzieckiem — na zgodny wniosek stron sąd nie orzeka o kontaktach,",
              "alimentach na dziecko, czyli o tym, w jakiej wysokości każdy z małżonków ponosi koszty jego utrzymania i wychowania,",
              "sposobie korzystania ze wspólnego mieszkania na czas wspólnego zamieszkiwania rozwiedzionych małżonków."
            ]},
           "Sąd uwzględnia pisemne porozumienie małżonków o sposobie wykonywania władzy rodzicielskiej i utrzymywaniu kontaktów z dzieckiem po rozwodzie, jeżeli jest ono zgodne z dobrem dziecka. Dobrze przygotowane porozumienie rodzicielskie skraca sprawę i ogranicza liczbę kwestii spornych."
         ]},
        {"Pozew o rozwód — sąd, opłata i przebieg sprawy",
         [
           "Pozew o rozwód wnosi się do sądu okręgowego, w którego okręgu małżonkowie mieli ostatnie wspólne miejsce zamieszkania, jeżeli choć jedno z nich nadal tam mieszka lub ma miejsce zwykłego pobytu. W braku takiej podstawy właściwy jest sąd miejsca zamieszkania strony pozwanej, a gdy i tej podstawy nie ma — sąd miejsca zamieszkania powoda. Małżonkowie mieszkający ostatnio wspólnie w Gdańsku składają więc pozew do Sądu Okręgowego w Gdańsku.",
           "Opłata od pozwu jest stała i wynosi 600 zł. Jeżeli sąd orzeknie rozwód na zgodny wniosek stron bez orzekania o winie, po uprawomocnieniu się wyroku zwraca połowę opłaty. Osoba, której nie stać na poniesienie kosztów, może wnosić o zwolnienie od kosztów sądowych.",
           "Po wniesieniu pozwu sąd doręcza jego odpis drugiemu małżonkowi i wyznacza termin na odpowiedź, a następnie termin rozprawy. Na czas trwania procesu można wnosić o zabezpieczenie — na przykład alimentów na dziecko, miejsca jego pobytu i kontaktów. W sprawie zgodnej rozprawa bywa jedna; w sprawie spornej sąd przesłuchuje świadków i strony, a w sprawach dotyczących dzieci może zlecić opinię zespołu specjalistów sądowych."
         ]},
        {"Alimenty między byłymi małżonkami",
         [
           "Rozwiedziony małżonek, który nie został uznany za wyłącznie winnego rozkładu pożycia i znajduje się w niedostatku, może żądać od drugiego byłego małżonka alimentów w zakresie odpowiadającym jego usprawiedliwionym potrzebom oraz możliwościom zarobkowym i majątkowym zobowiązanego (art. 60 § 1 k.r.o.).",
           "Obowiązek ten wygasa, gdy uprawniony zawrze nowe małżeństwo. Jeżeli zobowiązanym jest małżonek, który nie został uznany za winnego rozkładu pożycia, obowiązek wygasa także z upływem pięciu lat od orzeczenia rozwodu, chyba że sąd ze względu na wyjątkowe okoliczności przedłuży ten termin."
         ]},
        {"Podział majątku a rozwód",
         [
           "Wspólność majątkowa ustaje z chwilą uprawomocnienia się wyroku rozwodowego. Sąd może dokonać podziału majątku wspólnego już w wyroku rozwodowym, ale tylko na wniosek jednego z małżonków i tylko wtedy, gdy nie spowoduje to nadmiernej zwłoki w postępowaniu. W praktyce majątek dzieli się najczęściej po rozwodzie — umownie albo w odrębnym postępowaniu przed sądem rejonowym.",
           "Szczególnej uwagi wymaga mieszkanie obciążone kredytem hipotecznym: rozwód nie zwalnia żadnego z małżonków z odpowiedzialności wobec banku. Więcej na ten temat piszemy na stronie o podziale majątku."
         ]},
        {"Nazwisko po rozwodzie",
         [
           "Małżonek, który wskutek zawarcia małżeństwa zmienił nazwisko, może w ciągu trzech miesięcy od uprawomocnienia się wyroku rozwodowego wrócić do nazwiska noszonego przed zawarciem małżeństwa. Wystarczy oświadczenie złożone przed kierownikiem urzędu stanu cywilnego lub konsulem (art. 59 k.r.o.)."
         ]}
      ],
      documents: [
        "odpis aktu małżeństwa",
        "odpisy aktów urodzenia wspólnych małoletnich dzieci",
        "dokumenty dotyczące dochodów obojga małżonków, np. zaświadczenia o zarobkach lub zeznania podatkowe",
        "zestawienie miesięcznych kosztów utrzymania dzieci wraz z rachunkami",
        "projekt porozumienia rodzicielskiego, jeżeli małżonkowie są zgodni",
        "dowody dotyczące przyczyn rozkładu pożycia, jeżeli sąd ma orzekać o winie",
        "dokumenty dotyczące wspólnego mieszkania, np. umowa najmu lub odpis z księgi wieczystej",
        "umowa majątkowa małżeńska (intercyza), jeżeli została zawarta"
      ],
      faq: [
        {"Który sąd rozpoznaje sprawę o rozwód w Gdańsku?",
         "Sąd Okręgowy w Gdańsku — jeżeli małżonkowie mieli w jego okręgu ostatnie wspólne miejsce zamieszkania, a choć jedno z nich nadal tam mieszka. W innym wypadku właściwy jest sąd okręgowy miejsca zamieszkania pozwanego, a w braku tej podstawy — powoda."},
        {"Czy można wziąć rozwód na pierwszej rozprawie?",
         "Tak, jest to możliwe, gdy małżonkowie zgodnie wnoszą o rozwód bez orzekania o winie i są zgodni co do władzy rodzicielskiej, kontaktów i alimentów. O przebiegu sprawy decyduje jednak sąd."},
        {"Czym różni się rozwód z orzekaniem o winie od rozwodu bez orzekania o winie?",
         "Przy rozwodzie bez orzekania o winie sąd nie bada przyczyn rozkładu pożycia, sprawa trwa krócej, a połowa opłaty od pozwu jest zwracana. Orzeczenie o winie wymaga postępowania dowodowego i wpływa na alimenty między byłymi małżonkami: małżonek wyłącznie winny nie może ich żądać, a sam może zostać do nich zobowiązany."},
        {"Czy sąd może odmówić rozwodu?",
         "Tak. Sąd nie orzeknie rozwodu, jeżeli miałoby na tym ucierpieć dobro wspólnych małoletnich dzieci, gdy rozwód byłby sprzeczny z zasadami współżycia społecznego albo gdy żąda go małżonek wyłącznie winny, a drugi małżonek zasadnie odmawia zgody."},
        {"Czy przy rozwodzie sąd podzieli majątek?",
         "Tylko na wniosek jednego z małżonków i tylko wtedy, gdy podział nie spowoduje nadmiernej zwłoki w postępowaniu. Najczęściej majątek dzieli się po rozwodzie, umownie albo przed sądem rejonowym."},
        {"W jakim terminie po rozwodzie można wrócić do poprzedniego nazwiska?",
         "W ciągu trzech miesięcy od uprawomocnienia się wyroku rozwodowego, przez oświadczenie złożone przed kierownikiem urzędu stanu cywilnego lub konsulem."}
      ]
    },
    "sprawy-rodzinne" => %{
      updated: ~D[2026-11-22],
      lead: "milena-kraluk",
      sections: [
        {"Rozwód — co rozstrzyga sąd",
         [
           "Sąd orzeka rozwód, gdy między małżonkami nastąpił zupełny i trwały rozkład pożycia. Co do zasady rozstrzyga też, czy i który z małżonków ponosi winę rozkładu pożycia — może od tego odstąpić na zgodne żądanie obojga małżonków. Wybór między rozwodem z orzekaniem o winie a bez orzekania o winie wpływa na czas trwania sprawy, zakres postępowania dowodowego i późniejsze roszczenia alimentacyjne między małżonkami.",
           "W wyroku rozwodowym sąd rozstrzyga również o władzy rodzicielskiej nad wspólnym małoletnim dzieckiem, kontaktach rodziców z dzieckiem, alimentach na dziecko oraz o sposobie korzystania ze wspólnego mieszkania. Dlatego do sprawy warto przygotować się kompleksowo, a nie tylko w zakresie samego rozwiązania małżeństwa."
         ]},
        {"Od czego zależy wysokość alimentów na dziecko",
         [
           "W polskim prawie nie obowiązuje jedna tabela ani minimalna czy maksymalna kwota alimentów. Zgodnie z art. 135 § 1 Kodeksu rodzinnego i opiekuńczego wysokość świadczenia zależy od usprawiedliwionych potrzeb dziecka oraz zarobkowych i majątkowych możliwości zobowiązanego. Nie istnieje też zasada, że alimenty stanowią określony procent wynagrodzenia rodzica — dzieci powinny natomiast mieć zapewnioną co najmniej równą stopę życiową co rodzice.",
           "Sąd ocenia, jakie wydatki są uzasadnione ze względu na wiek, stan zdrowia, edukację i indywidualne potrzeby dziecka. Do typowych kosztów należą:",
           {:list,
            [
              "wyżywienie, ubrania, obuwie i środki higieniczne,",
              "udział w kosztach mieszkania i mediów,",
              "wydatki szkolne i edukacyjne, w tym korepetycje i zajęcia dodatkowe,",
              "leczenie, leki i rehabilitacja,",
              "transport, czas wolny, rozwijanie zainteresowań i wypoczynek."
            ]},
           "Znaczenie ma nie tylko aktualne wynagrodzenie rodzica, ale realna możliwość uzyskiwania dochodów — sąd może uwzględnić kwalifikacje zawodowe, doświadczenie, stan zdrowia i sytuację na rynku pracy. Niskie wynagrodzenie lub brak pracy nie zawsze uzasadniają więc niższe alimenty."
         ]},
        {"Osobista opieka nad dzieckiem a alimenty",
         [
           "Obowiązek alimentacyjny może być wykonywany także przez osobiste starania o utrzymanie i wychowanie dziecka (art. 135 § 2 k.r.o.). Rodzic, który na co dzień zajmuje się dzieckiem — organizuje jego naukę, leczenie i codzienne funkcjonowanie — realizuje w ten sposób część swojego obowiązku. W konsekwencji drugi, mniej zaangażowany rodzic może zostać zobowiązany do pokrywania większej części wydatków.",
           "Przed złożeniem pozwu warto przygotować szczegółowe zestawienie kosztów utrzymania dziecka, obejmujące zarówno wydatki miesięczne, jak i ponoszone okresowo — wyprawkę szkolną, sprzęt sportowy czy wakacje. Wydatki należy oszacować rozsądnie, bez podwójnego liczenia tych samych kosztów, i poprzeć rachunkami."
         ]},
        {"Zmiana wysokości alimentów",
         [
           "Zasądzone alimenty nie muszą pozostać niezmienne. Jeżeli po wydaniu wyroku nastąpi istotna zmiana sytuacji, można żądać ich podwyższenia lub obniżenia na podstawie art. 138 Kodeksu rodzinnego i opiekuńczego. Sam upływ czasu nie wystarcza — trzeba wykazać zmianę stosunków, na przykład wzrost potrzeb dziecka albo zmianę możliwości zarobkowych rodzica."
         ]},
        {"Koszty sądowe w sprawach rodzinnych",
         [
           "Osoba dochodząca alimentów na dziecko jest zwolniona od kosztów sądowych — także w sprawie o podwyższenie alimentów. Opłatę trzeba natomiast uiścić w sprawie o obniżenie alimentów albo uchylenie obowiązku alimentacyjnego: wynosi ona 5% wartości przedmiotu sporu, liczonej jako suma świadczeń za rok. Przykładowo, przy żądaniu obniżenia alimentów o 200 zł miesięcznie wartość przedmiotu sporu to 2 400 zł, a opłata — 120 zł.",
           "Opłata stała od pozwu o rozwód wynosi 600 zł. Odrębnie ustalane jest wynagrodzenie adwokata — jego orientacyjne przedziały podajemy w cenniku."
         ]},
        {"Władza rodzicielska i kontakty z dzieckiem",
         [
           "W sprawach dotyczących dzieci sąd kieruje się przede wszystkim dobrem dziecka. Rodzice mogą przedstawić sądowi pisemne porozumienie o sposobie wykonywania władzy rodzicielskiej i utrzymywaniu kontaktów z dzieckiem po rozwodzie. Gdy porozumienie nie jest możliwe, o władzy rodzicielskiej, miejscu pobytu dziecka i kontaktach rozstrzyga sąd.",
           "Pomagamy przygotować takie porozumienie, a w sprawach spornych — wnioski i dowody, które pokazują rzeczywistą sytuację opiekuńczą dziecka."
         ]}
      ],
      documents: [
        "odpis aktu małżeństwa i odpisy aktów urodzenia dzieci",
        "dokumenty dotyczące dochodów i sytuacji finansowej rodzica",
        "zestawienie miesięcznych kosztów utrzymania dziecka",
        "rachunki i faktury dotyczące wydatków na dziecko",
        "potwierdzenia opłat szkolnych i za zajęcia dodatkowe",
        "dokumentacja medyczna, jeżeli dziecko wymaga leczenia",
        "dokumenty dotyczące kosztów mieszkania",
        "informacje o sytuacji zarobkowej drugiego rodzica, jeżeli są dostępne zgodnie z prawem"
      ],
      faq: [
        {"Czy istnieje minimalna kwota alimentów na dziecko?",
         "Nie. Przepisy nie określają minimalnej ani maksymalnej kwoty alimentów. Wysokość świadczenia zależy od usprawiedliwionych potrzeb dziecka oraz zarobkowych i majątkowych możliwości rodzica."},
        {"Czy alimenty to określony procent wynagrodzenia?",
         "Nie ma takiej zasady. Sąd bierze pod uwagę potrzeby dziecka i możliwości zarobkowe rodzica, a także to, że dziecko powinno mieć zapewnioną co najmniej równą stopę życiową co rodzice."},
        {"Czy można zmienić wysokość zasądzonych alimentów?",
         "Tak. W razie istotnej zmiany sytuacji można żądać podwyższenia lub obniżenia alimentów na podstawie art. 138 Kodeksu rodzinnego i opiekuńczego. Sam upływ czasu nie wystarcza — trzeba wykazać zmianę stosunków."},
        {"Ile wynosi opłata sądowa w sprawie o alimenty i o rozwód?",
         "Osoba dochodząca alimentów na dziecko jest zwolniona od kosztów sądowych, także przy podwyższeniu alimentów. W sprawie o obniżenie alimentów opłata wynosi 5% wartości przedmiotu sporu, liczonej jako suma świadczeń za rok. Opłata od pozwu o rozwód wynosi 600 zł."},
        {"Czy sąd zawsze orzeka o winie przy rozwodzie?",
         "Co do zasady tak, ale na zgodne żądanie obojga małżonków sąd zaniecha orzekania o winie."},
        {"Jakie dokumenty przygotować do sprawy o alimenty?",
         "Odpis aktu urodzenia dziecka, dokumenty o dochodach, zestawienie miesięcznych kosztów utrzymania dziecka wraz z rachunkami, potwierdzenia opłat szkolnych, dokumentację medyczną oraz dokumenty dotyczące kosztów mieszkania."}
      ]
    },
    "podzial-majatku" => %{
      updated: ~D[2026-11-22],
      lead: "milena-kraluk",
      sections: [
        {"Podział umowny czy sądowy",
         [
           "Majątek wspólny można podzielić umownie albo w postępowaniu sądowym. Podział umowny jest szybszy i tańszy, ale wymaga zgody obojga byłych małżonków co do składu majątku i sposobu podziału; jeżeli obejmuje nieruchomość, umowa wymaga formy aktu notarialnego.",
           "Gdy porozumienie nie jest możliwe, o podziale rozstrzyga sąd. Opłata od wniosku o podział majątku wspólnego wynosi 1 000 zł, a jeżeli wniosek zawiera zgodny projekt podziału — 300 zł. Sąd ustala skład i wartość majątku, rozlicza nakłady i wydatki oraz przyznaje poszczególne składniki, zwykle z obowiązkiem spłaty lub dopłaty."
         ]},
        {"Kto spłaca kredyt hipoteczny po rozwodzie",
         [
           "Rozwód nie zwalnia automatycznie żadnego z małżonków z obowiązku spłaty wspólnego kredytu. Ustanie wspólności majątkowej nie jest równoznaczne z ustaniem odpowiedzialności za kredyt — dopóki nie dojdzie do skutecznej zmiany zobowiązania wobec banku, oboje byli małżonkowie odpowiadają za jego spłatę solidarnie.",
           "Oznacza to, że bank może żądać spłaty całego wymagalnego zobowiązania od każdego z nich z osobna lub od obojga naraz — także wtedy, gdy w kredytowanym mieszkaniu mieszka tylko jedno z nich. Porozumienie byłych małżonków, zgodnie z którym raty spłaca tylko jedno z nich, nie jest wiążące dla banku."
         ]},
        {"Czy sąd podzieli wspólny kredyt",
         [
           "Nie. Sąd dzieli majątek wspólny, czyli jego aktywa, ale co do zasady nie dzieli długów wobec banków. Może przyznać mieszkanie jednemu z byłych małżonków i ustalić spłatę należną drugiemu, nie może jednak samym postanowieniem zwolnić jednego z kredytobiorców z odpowiedzialności wobec banku.",
           "Podział mieszkania i podział zobowiązania kredytowego to więc dwie odrębne kwestie. Osoba, która po podziale przestaje być właścicielem mieszkania, formalnie nadal odpowiada za kredyt — dlatego warunki podziału warto ustalać z uwzględnieniem dalszej obsługi kredytu."
         ]},
        {"Wycena mieszkania obciążonego hipoteką",
         [
           "Co do zasady sąd ustala wartość rynkową nieruchomości bez pomniejszania jej o wartość obciążenia hipotecznego, chyba że zachodzą szczególnie istotne powody uzasadniające odmienne rozliczenie (uchwała Sądu Najwyższego z 25 lipca 2019 r., III CZP 14/19).",
           "Przykładowo, jeżeli mieszkanie ma wartość rynkową 700 000 zł i jest obciążone hipoteką, punktem wyjścia do rozliczeń jest wartość rynkowa. Nie oznacza to, że spłata należna drugiemu małżonkowi zawsze wyniesie połowę tej kwoty — znaczenie mają także udziały małżonków, pozostałe składniki majątku i roszczenia rozliczeniowe."
         ]},
        {"Przejęcie kredytu przez jednego z małżonków",
         [
           "Jeżeli po rozwodzie za kredyt ma odpowiadać tylko jedno z byłych małżonków, konieczna jest zgoda banku — w formie aneksu albo nowej umowy. Bank zbada zdolność kredytową osoby, która ma samodzielnie spłacać zobowiązanie, i przy ocenie negatywnej może odmówić zwolnienia drugiego kredytobiorcy z długu."
         ]},
        {"Zwrot rat spłaconych po rozwodzie",
         [
           "Choć sąd nie dzieli samego długu, może w ramach podziału majątku rozliczyć raty, które jedno z małżonków spłaciło z własnych środków po rozwodzie. W praktyce może to oznaczać zwrot równowartości połowy uiszczonych rat albo przyznanie większej części majątku wspólnego.",
           "Gdy żadne z byłych małżonków nie jest w stanie samodzielnie spłacać kredytu, do rozważenia pozostaje sprzedaż nieruchomości i podział kwoty pozostałej po spłacie banku, wynajem i przeznaczanie czynszu na raty albo rozmowa z bankiem o restrukturyzacji zadłużenia, na przykład wydłużeniu okresu kredytowania."
         ]}
      ],
      documents: [
        "prawomocny wyrok rozwodowy lub inny dokument potwierdzający ustanie wspólności",
        "odpisy z ksiąg wieczystych i akty notarialne dotyczące nieruchomości",
        "umowa kredytu wraz z aneksami i aktualnym saldem zadłużenia",
        "historia spłat kredytu i potwierdzenia przelewów rat",
        "dokumenty dotyczące pozostałych składników majątku (pojazdy, rachunki, udziały)",
        "dowody nakładów z majątku osobistego, np. umowy darowizny lub dokumenty spadkowe"
      ],
      faq: [
        {"Kto spłaca kredyt hipoteczny po rozwodzie?",
         "Oboje byli małżonkowie. Rozwód nie zwalnia z obowiązku spłaty wspólnego kredytu — dopóki nie dojdzie do zmiany umowy z bankiem, odpowiadają za niego solidarnie, niezależnie od tego, kto mieszka w kredytowanym mieszkaniu."},
        {"Czy hipoteka obniża wartość mieszkania przy podziale majątku?",
         "Co do zasady nie. Sąd ustala wartość rynkową nieruchomości bez pomniejszania jej o obciążenie hipoteczne, chyba że zachodzą szczególnie istotne powody uzasadniające odmienne rozliczenie (uchwała SN z 25 lipca 2019 r., III CZP 14/19)."},
        {"Czy do przejęcia kredytu przez jednego małżonka potrzebna jest zgoda banku?",
         "Tak. Bank jako wierzyciel musi zgodzić się na zmianę dłużnika, co wymaga aneksu albo nowej umowy. Po ocenie zdolności kredytowej bank może odmówić zwolnienia drugiego kredytobiorcy z długu."},
        {"Czy można żądać zwrotu rat kredytu spłaconych po rozwodzie?",
         "Tak. W ramach podziału majątku sąd może rozliczyć raty, które jedno z małżonków spłaciło z własnych środków po rozwodzie. Warto zgromadzić potwierdzenia przelewów, historię spłat i dokumenty bankowe."},
        {"Ile wynosi opłata sądowa od wniosku o podział majątku?",
         "1 000 zł, a jeżeli wniosek zawiera zgodny projekt podziału majątku — 300 zł."}
      ]
    },
    "upadlosc-konsumencka" => %{
      updated: ~D[2026-11-22],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jak przebiega postępowanie",
         [
           "Postępowanie rozpoczyna się od złożenia wniosku do sądu. Jeżeli sąd ogłosi upadłość, wyznacza syndyka, który ustala sytuację majątkową dłużnika i zajmuje się majątkiem objętym postępowaniem, w tym jego sprzedażą. Uzyskane środki służą pokryciu kosztów postępowania i spłacie wierzycieli.",
           "Ogłoszenie upadłości nie oznacza jeszcze umorzenia długów. W dalszym etapie sąd rozstrzyga, czy dłużnik powinien dokonywać spłat według planu, czy możliwe jest oddłużenie bez dalszych rat. Ogłoszenie upadłości wpływa też na egzekucję komorniczą: wcześniej wszczęte egzekucje skierowane do majątku objętego upadłością zostają zawieszone, a po uprawomocnieniu się postanowienia — umorzone. Samo złożenie wniosku nie wywołuje tych skutków."
         ]},
        {"Które długi mogą zostać umorzone",
         [
           "Oddłużenie może objąć między innymi kredyty, pożyczki, niezapłacone rachunki, zobowiązania z wcześniejszej działalności gospodarczej, a także zaległości podatkowe lub składkowe — co do zasady powstałe przed ogłoszeniem upadłości.",
           "Nie wszystkie należności można umorzyć. Wyłączenia dotyczą między innymi alimentów, grzywien orzeczonych przez sąd oraz niektórych zobowiązań odszkodowawczych, w tym obowiązku naprawienia szkody wynikającej z przestępstwa. We wniosku należy ujawnić także długi sporne — umyślne pominięcie zobowiązania może sprawić, że nie zostanie ono umorzone."
         ]},
        {"Co stanie się z mieszkaniem i dochodami",
         [
           "Upadłość konsumencka może oznaczać sprzedaż mieszkania, domu, samochodu i innych wartościowych składników majątku. Zamieszkiwanie w nieruchomości wraz z dziećmi nie zapewnia automatycznie zachowania jej własności.",
           "Przy sprzedaży mieszkania lub domu, w którym dłużnik zamieszkuje, ustawa chroni jego potrzeby mieszkaniowe: z ceny sprzedaży wydziela się kwotę odpowiadającą przeciętnemu czynszowi najmu w tej samej lub sąsiedniej miejscowości za okres od 12 do 24 miesięcy. Dłużnik zachowuje też mienie i środki objęte ustawową ochroną, w tym chronioną część wynagrodzenia."
         ]},
        {"Jak upadłość wpływa na rodzinę",
         [
           "Ogłoszenie upadłości jednego z małżonków powoduje powstanie rozdzielności majątkowej. Jeżeli wcześniej małżonków łączyła wspólność, majątek wspólny co do zasady zostaje objęty postępowaniem, a drugi małżonek powinien zgłosić należność z tytułu swojego udziału. Ustanowienie rozdzielności krótko przed złożeniem wniosku nie zawsze ochroni majątek.",
           "Sama więź rodzinna nie tworzy obowiązku spłacania długów innych członków rodziny. Inaczej jest w przypadku współkredytobiorcy lub poręczyciela: umorzenie zobowiązań jednej osoby nie zwalnia pozostałych osób odpowiedzialnych za ten sam dług."
         ]},
        {"Plan spłaty i umorzenie bez dalszych rat",
         [
           "Plan spłaty wierzycieli określa, jakie kwoty i przez jaki czas dłużnik ma wpłacać. Sąd uwzględnia możliwości zarobkowe, konieczne koszty utrzymania i potrzeby mieszkaniowe dłużnika oraz osób na jego utrzymaniu. Podstawowy okres planu nie przekracza trzech lat; jeżeli dłużnik umyślnie lub wskutek rażącego niedbalstwa doprowadził do niewypłacalności albo istotnie ją pogłębił — wynosi od trzech do siedmiu lat. Nie ma zasady, że trzeba spłacić określony procent długów.",
           "Umorzenie bez dalszych spłat jest możliwe w szczególności wtedy, gdy sytuacja osobista dłużnika wskazuje, że trwale nie będzie on zdolny do dokonywania nawet częściowych spłat. Jeżeli niezdolność jest przejściowa, sąd może zastosować warunkowe umorzenie zobowiązań z pięcioletnim okresem obowiązków sprawozdawczych."
         ]},
        {"Co może utrudnić oddłużenie",
         [
           {:list,
            [
              "celowe doprowadzenie do niewypłacalności lub jej istotne pogłębienie,",
              "wcześniejsze postępowanie upadłościowe z umorzeniem zobowiązań w ciągu dziesięciu lat przed złożeniem wniosku,",
              "darowizny, sprzedaż majątku i rozliczenia z bliskimi dokonane przed złożeniem wniosku — mogą zostać zakwestionowane,",
              "nierzetelne ujawnienie majątku i zobowiązań lub brak współpracy z syndykiem,",
              "niewykonywanie planu spłaty i brak corocznych sprawozdań."
            ]},
           "Przepisy przewidują w części tych sytuacji wyjątki uzasadnione względami słuszności lub humanitarnymi, dlatego każdą z nich trzeba ocenić przed złożeniem wniosku."
         ]},
        {"Wniosek, koszty i czas postępowania",
         [
           "Wniosek powinien wyjaśniać, jak doszło do niewypłacalności i dlaczego dłużnik nie jest w stanie regulować zobowiązań — sama lista długów nie wystarcza. Składa się go do sądu upadłościowego właściwego co do zasady według miejsca zwykłego pobytu dłużnika, elektronicznie przez Krajowy Rejestr Zadłużonych albo na formularzu papierowym.",
           "Opłata sądowa od wniosku wynosi 30 zł. Do kosztów postępowania należą także wynagrodzenie syndyka i wydatki związane ze sprzedażą majątku; przy braku środków są one tymczasowo finansowane przez Skarb Państwa. Czasu potrzebnego do oddłużenia nie da się zagwarantować z góry — zależy od kompletności dokumentów, liczby wierzycieli i potrzeby sprzedaży majątku."
         ]}
      ],
      documents: [
        "umowy kredytowe i pożyczkowe",
        "wezwania do zapłaty oraz pisma sądowe i komornicze",
        "lista wszystkich wierzycieli, także tych, których roszczenia są sporne",
        "informacje o majątku, dochodach i kosztach utrzymania",
        "dokumenty dotyczące darowizn, sprzedaży majątku i innych czynności z ostatnich lat",
        "dokumentacja medyczna lub potwierdzająca opiekę nad bliskimi, jeżeli wpływa na sytuację finansową"
      ],
      faq: [
        {"Czy ogłoszenie upadłości wstrzymuje egzekucję komorniczą?",
         "Tak. Wcześniej wszczęte egzekucje skierowane do majątku objętego upadłością zostają zawieszone, a po uprawomocnieniu się postanowienia o ogłoszeniu upadłości — umorzone. Samo złożenie wniosku nie wywołuje tych skutków."},
        {"Których długów nie można umorzyć w upadłości konsumenckiej?",
         "Między innymi alimentów, grzywien orzeczonych przez sąd oraz niektórych zobowiązań odszkodowawczych, w tym obowiązku naprawienia szkody wynikającej z przestępstwa stwierdzonego prawomocnym orzeczeniem."},
        {"Czy w upadłości konsumenckiej stracę mieszkanie?",
         "Upadłość może oznaczać sprzedaż mieszkania lub domu. Ustawa chroni jednak potrzeby mieszkaniowe: z ceny sprzedaży wydziela się kwotę odpowiadającą przeciętnemu czynszowi najmu za okres od 12 do 24 miesięcy."},
        {"Jak długo trwa plan spłaty wierzycieli?",
         "Podstawowy okres planu spłaty nie przekracza trzech lat. Jeżeli dłużnik umyślnie lub wskutek rażącego niedbalstwa doprowadził do niewypłacalności albo istotnie ją pogłębił, plan trwa od trzech do siedmiu lat."},
        {"Czy można uzyskać umorzenie długów bez planu spłaty?",
         "Tak, w szczególności gdy sytuacja osobista dłużnika wskazuje, że trwale nie będzie on zdolny do dokonywania nawet częściowych spłat. Przy przejściowej niezdolności sąd może zastosować warunkowe umorzenie zobowiązań."},
        {"Ile wynosi opłata od wniosku o upadłość konsumencką?",
         "Opłata sądowa wynosi 30 zł. Nie jest to pełny koszt postępowania — dochodzą m.in. wynagrodzenie syndyka i wydatki związane ze sprzedażą majątku."}
      ]
    }
  }

  @doc "Extended content for a service slug, or `nil` for a short page."
  def get(slug), do: Map.get(@details, slug)

  @doc "`KralukKurkierewicz.Team` slugs of the partners handling a service (`[]` for a short page)."
  def leads(slug) do
    case get(slug) do
      nil -> []
      %{lead: lead} -> List.wrap(lead)
    end
  end

  @doc "Slugs of the service pages that have extended content."
  def slugs, do: Map.keys(@details)
end
