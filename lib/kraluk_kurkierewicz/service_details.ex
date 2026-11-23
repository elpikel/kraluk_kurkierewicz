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
    * `:sections` — `{title, blocks}`; the title is phrased as the question a
      Client would type into a search engine; a block is a paragraph string,
      `{:list, items}`, `{:rulings, [{text, link_label, url}]}` or `:calculator`
    * `:documents` — checklist of documents to bring
    * `:faq` — extra `{question, answer}` pairs; optional — a page without it
      takes its questions from `KralukKurkierewicz.Services` (`@questions`)
  """

  @details %{
    "zawyzony-metraz" => %{
      updated: ~D[2026-11-23],
      lead: ["milena-kraluk", "michal-kurkierewicz"],
      sections: [
        {"Jak mierzy się powierzchnię użytkową mieszkania?",
         [
           "Powierzchnię użytkową lokalu ustala się według Polskiej Normy PN-ISO 9836. Na gruncie jej wersji z 1997 r. deweloperzy przyjmowali, że do powierzchni użytkowej można wliczać ścianki działowe „nadające się do demontażu”. Wersja PN-ISO 9836:2015-12 doprecyzowała, że chodzi o ścianki typu przepierzenia, a powierzchni pod stałymi ścianami działowymi nie wlicza się do powierzchni użytkowej.",
           "W praktyce znaczenie ma to, która wersja normy obowiązywała w dniu złożenia wniosku o pozwolenie na budowę, oraz to, jak sposób pomiaru opisano w umowie deweloperskiej. Dlatego analizę zaczynamy od dokumentów, a nie od samego pomiaru."
         ]},
        {"Co sądy mówią o ściankach działowych w metrażu?",
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
        {"Ile można odzyskać od dewelopera? Kalkulator nadpłaty",
         [
           "Nadpłata to różnica między powierzchnią, za którą zapłaciłeś, a powierzchnią użytkową liczoną bez stałych ścian działowych, pomnożona przez cenę metra kwadratowego z umowy. Wpisz swoje dane, aby zobaczyć orientacyjną kwotę.",
           :calculator,
           "Wynik jest szacunkiem. Do kwoty głównej dochodzą odsetki ustawowe za opóźnienie, a o tym, którą powierzchnię sąd uzna za prawidłową, decyduje umowa i pomiar — najlepiej zweryfikowany przez geodetę."
         ]},
        {"Kiedy roszczenie ma szanse powodzenia?",
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
        {"Do kiedy można żądać zwrotu części ceny?",
         [
           "Roszczenie o zwrot nadpłaconej ceny jest roszczeniem majątkowym i ulega przedawnieniu. Konsument dochodzi go co do zasady w ogólnym, sześcioletnim terminie z art. 118 k.c., przy czym koniec terminu przypada na ostatni dzień roku kalendarzowego. Do roszczeń konsumentów, które powstały przed 9 lipca 2018 r. i nie były wtedy przedawnione, stosuje się wcześniejszy, dziesięcioletni termin.",
           "Sporny bywa początek biegu terminu. W sprawach dotyczących niedozwolonych postanowień umownych orzecznictwo wiąże go z chwilą, w której konsument dowiedział się lub powinien był się dowiedzieć o niedozwolonym charakterze postanowienia. Bieg przedawnienia przerywa wniesienie pozwu. Jeżeli mieszkanie zostało kupione kilka lat temu, nie warto odkładać analizy umowy."
         ]},
        {"Jak wygląda sprawa przeciwko deweloperowi?",
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
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Kiedy sąd orzeknie rozwód?",
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
        {"Rozwód z orzekaniem o winie czy bez?",
         [
           "Co do zasady sąd orzeka, czy i który z małżonków ponosi winę rozkładu pożycia. Na zgodne żądanie obojga małżonków sąd zaniecha orzekania o winie — następują wtedy skutki takie, jakby żaden z małżonków nie ponosił winy (art. 57 k.r.o.).",
           "Wybór ma praktyczne konsekwencje. Rozwód bez orzekania o winie jest szybszy i tańszy: zwykle nie wymaga przesłuchiwania świadków, a sąd zwraca połowę opłaty od pozwu. Orzeczenie o winie wymaga udowodnienia przyczyn rozkładu pożycia, ale wpływa na późniejsze alimenty między byłymi małżonkami — małżonek wyłącznie winny może zostać zobowiązany do alimentów na rzecz małżonka niewinnego, jeżeli rozwód pociąga za sobą istotne pogorszenie jego sytuacji materialnej, nawet gdy nie znajduje się on w niedostatku (art. 60 § 2 k.r.o.).",
           "Decyzję o żądaniu orzeczenia o winie warto podjąć po ocenie dowodów i tego, co realnie można dzięki niemu uzyskać. Omawiamy to z Klientem przed złożeniem pozwu."
         ]},
        {"Co sąd rozstrzyga w wyroku rozwodowym?",
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
        {"Gdzie złożyć pozew o rozwód i ile to kosztuje?",
         [
           "Pozew o rozwód wnosi się do sądu okręgowego, w którego okręgu małżonkowie mieli ostatnie wspólne miejsce zamieszkania, jeżeli choć jedno z nich nadal tam mieszka lub ma miejsce zwykłego pobytu. W braku takiej podstawy właściwy jest sąd miejsca zamieszkania strony pozwanej, a gdy i tej podstawy nie ma — sąd miejsca zamieszkania powoda. Małżonkowie mieszkający ostatnio wspólnie w Gdańsku składają więc pozew do Sądu Okręgowego w Gdańsku.",
           "Opłata od pozwu jest stała i wynosi 600 zł. Jeżeli sąd orzeknie rozwód na zgodny wniosek stron bez orzekania o winie, po uprawomocnieniu się wyroku zwraca połowę opłaty. Osoba, której nie stać na poniesienie kosztów, może wnosić o zwolnienie od kosztów sądowych.",
           "Po wniesieniu pozwu sąd doręcza jego odpis drugiemu małżonkowi i wyznacza termin na odpowiedź, a następnie termin rozprawy. Na czas trwania procesu można wnosić o zabezpieczenie — na przykład alimentów na dziecko, miejsca jego pobytu i kontaktów. W sprawie zgodnej rozprawa bywa jedna; w sprawie spornej sąd przesłuchuje świadków i strony, a w sprawach dotyczących dzieci może zlecić opinię zespołu specjalistów sądowych."
         ]},
        {"Kiedy należą się alimenty od byłego małżonka?",
         [
           "Rozwiedziony małżonek, który nie został uznany za wyłącznie winnego rozkładu pożycia i znajduje się w niedostatku, może żądać od drugiego byłego małżonka alimentów w zakresie odpowiadającym jego usprawiedliwionym potrzebom oraz możliwościom zarobkowym i majątkowym zobowiązanego (art. 60 § 1 k.r.o.).",
           "Obowiązek ten wygasa, gdy uprawniony zawrze nowe małżeństwo. Jeżeli zobowiązanym jest małżonek, który nie został uznany za winnego rozkładu pożycia, obowiązek wygasa także z upływem pięciu lat od orzeczenia rozwodu, chyba że sąd ze względu na wyjątkowe okoliczności przedłuży ten termin."
         ]},
        {"Kiedy dzieli się majątek — przy rozwodzie czy po nim?",
         [
           "Wspólność majątkowa ustaje z chwilą uprawomocnienia się wyroku rozwodowego. Sąd może dokonać podziału majątku wspólnego już w wyroku rozwodowym, ale tylko na wniosek jednego z małżonków i tylko wtedy, gdy nie spowoduje to nadmiernej zwłoki w postępowaniu. W praktyce majątek dzieli się najczęściej po rozwodzie — umownie albo w odrębnym postępowaniu przed sądem rejonowym.",
           "Szczególnej uwagi wymaga mieszkanie obciążone kredytem hipotecznym: rozwód nie zwalnia żadnego z małżonków z odpowiedzialności wobec banku. Więcej na ten temat piszemy na stronie o [podziale majątku po rozwodzie](/uslugi/podzial-majatku)."
         ]},
        {"Jak wrócić do nazwiska sprzed małżeństwa?",
         [
           "Małżonek, który wskutek zawarcia małżeństwa zmienił nazwisko, może w ciągu roku od uprawomocnienia się wyroku rozwodowego wrócić do nazwiska noszonego przed zawarciem małżeństwa. Wystarczy oświadczenie złożone przed kierownikiem urzędu stanu cywilnego lub konsulem (art. 59 k.r.o.)."
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
         "W ciągu roku od uprawomocnienia się wyroku rozwodowego, przez oświadczenie złożone przed kierownikiem urzędu stanu cywilnego lub konsulem."}
      ]
    },
    "sprawy-rodzinne" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Co obejmuje władza rodzicielska i komu przysługuje po rozstaniu?",
         [
           "Władza rodzicielska to obowiązek i prawo rodziców do wykonywania pieczy nad osobą i majątkiem dziecka oraz do jego wychowania. Przysługuje co do zasady obojgu rodzicom do uzyskania przez dziecko pełnoletności — także wtedy, gdy rodzice nie mieszkają razem. O istotnych sprawach dziecka, takich jak wybór szkoły, sposób leczenia czy wyjazd na stałe za granicę, rodzice rozstrzygają wspólnie, a w braku porozumienia decyduje sąd opiekuńczy.",
           "Gdy rodzice żyją w rozłączeniu, sąd może pozostawić władzę rodzicielską obojgu — zwłaszcza jeżeli przedstawią pisemne porozumienie o sposobie jej wykonywania i o kontaktach z dzieckiem, zgodne z dobrem dziecka. Jeżeli porozumienia brak, sąd bierze pod uwagę prawo dziecka do wychowania przez oboje rodziców; może też powierzyć wykonywanie władzy jednemu z nich i ograniczyć władzę drugiego do określonych obowiązków i uprawnień."
         ]},
        {"Jak sąd ustala kontakty z dzieckiem?",
         [
           "Kontakty obejmują w szczególności przebywanie z dzieckiem — odwiedziny, spotkania, zabieranie dziecka poza miejsce jego stałego pobytu — bezpośrednie porozumiewanie się, korespondencję oraz rozmowy telefoniczne i przez internet. Rodzice ustalają je wspólnie, a gdy nie potrafią — robi to sąd.",
           "W postanowieniu sąd określa zwykle:",
           {:list,
            [
              "dni i godziny spotkań w ciągu tygodnia i w weekendy,",
              "podział świąt, ferii i wakacji,",
              "miejsce odbioru i odprowadzenia dziecka oraz to, kto je odbiera,",
              "sposób kontaktu na odległość."
            ]},
           "Jeżeli wymaga tego dobro dziecka, sąd może kontakty ograniczyć — na przykład zezwolić na spotkania tylko w obecności drugiego rodzica lub kuratora sądowego — a gdy poważnie zagrażają dobru dziecka, zakazać ich. Prawo do kontaktów mają także dziadkowie i rodzeństwo dziecka."
         ]},
        {"Co zrobić, gdy drugi rodzic utrudnia kontakty?",
         [
           "Orzeczenie lub ugodę o kontaktach wykonuje się w dwóch krokach. Najpierw sąd opiekuńczy — na wniosek rodzica, któremu kontakty są utrudniane — zagraża drugiemu rodzicowi nakazaniem zapłaty oznaczonej sumy pieniężnej za każde naruszenie. Jeżeli mimo to naruszenia się powtarzają, sąd nakazuje zapłatę tej sumy.",
           "Te same przepisy działają w drugą stronę: sąd może zagrozić nakazaniem zapłaty rodzicowi, który sam nie realizuje ustalonych kontaktów. Samo utrudnianie kontaktów nie jest odrębnym przestępstwem, ale powtarzające się naruszenia mogą być podstawą zmiany rozstrzygnięcia o kontaktach, a nawet o władzy rodzicielskiej. Każde naruszenie warto dokumentować: wiadomościami, notatkami z datami i zeznaniami świadków."
         ]},
        {"Na czym polega opieka naprzemienna?",
         [
           "Opieka naprzemienna oznacza, że dziecko mieszka z każdym z rodziców w powtarzających się, porównywalnych okresach — na przykład tydzień u matki i tydzień u ojca. Przepisy nie narzucają jednego modelu ani minimalnego wieku dziecka; sąd ocenia, czy takie rozwiązanie służy konkretnemu dziecku.",
           "W praktyce opieka naprzemienna sprawdza się, gdy rodzice mieszkają blisko siebie, potrafią się porozumiewać w sprawach dziecka i zapewniają mu podobne warunki. Nie wyłącza ona automatycznie alimentów: jeżeli możliwości zarobkowe rodziców wyraźnie się różnią, sąd może je zasądzić. Więcej na ten temat piszemy na stronie o [alimentach](/uslugi/alimenty)."
         ]},
        {"Kiedy sąd ogranicza lub odbiera władzę rodzicielską?",
         [
           "Przepisy przewidują trzy stopnie ingerencji w władzę rodzicielską:",
           {:list,
            [
              "ograniczenie — gdy dobro dziecka jest zagrożone; sąd może między innymi zobowiązać rodziców do określonego postępowania, skierować ich do specjalistów albo poddać wykonywanie władzy nadzorowi kuratora,",
              "zawieszenie — w razie przemijającej przeszkody w wykonywaniu władzy, na przykład długotrwałego pobytu za granicą lub choroby,",
              "pozbawienie — gdy władza nie może być wykonywana z powodu trwałej przeszkody albo gdy rodzice jej nadużywają lub w sposób rażący zaniedbują obowiązki wobec dziecka."
            ]},
           "Pozbawienie władzy rodzicielskiej nie zwalnia z obowiązku alimentacyjnego i nie odbiera samo przez się prawa do kontaktów — o zakazie kontaktów sąd musi orzec osobno. Jeżeli ustanie przyczyna, która była podstawą pozbawienia, sąd może władzę rodzicielską przywrócić."
         ]},
        {"Jak ustalić albo zaprzeczyć ojcostwo?",
         [
           "Ojcostwo dziecka urodzonego poza małżeństwem ustala się przez uznanie — oświadczenie złożone przed kierownikiem urzędu stanu cywilnego — albo w procesie przed sądem. Powództwo o ustalenie ojcostwa może wytoczyć dziecko, matka oraz domniemany ojciec; matka i domniemany ojciec tracą to uprawnienie, gdy dziecko osiągnie pełnoletność. Kluczowym dowodem jest zwykle badanie DNA.",
           "Mąż matki, który ma wątpliwości co do swojego ojcostwa, może wytoczyć powództwo o jego zaprzeczenie w ciągu roku od dnia, w którym dowiedział się, że dziecko od niego nie pochodzi, nie później jednak niż do osiągnięcia przez dziecko pełnoletności. Razem z ustaleniem ojcostwa można dochodzić związanych z nim roszczeń, w tym alimentów."
         ]},
        {"Kto orzeka o dzieciach, gdy rodzice się rozwodzą?",
         [
           "Gdy toczy się sprawa o rozwód lub separację, o władzy rodzicielskiej, kontaktach i alimentach na wspólne małoletnie dziecko rozstrzyga sąd okręgowy w wyroku, a odrębnych postępowań w tych sprawach co do zasady nie można w tym czasie wszcząć. Przebieg takiej sprawy opisujemy na stronie [rozwód — adwokat w Gdańsku](/uslugi/rozwod).",
           "Poza sprawą rozwodową — gdy rodzice nie są małżeństwem, żyją w rozłączeniu albo wyrok już zapadł — sprawy o kontakty i władzę rodzicielską prowadzi sąd rejonowy."
         ]},
        {"Do którego sądu złożyć wniosek i jak przebiega sprawa?",
         [
           "Wniosek o ustalenie kontaktów albo o rozstrzygnięcie w sprawie władzy rodzicielskiej składa się do sądu rejonowego właściwego dla miejsca zamieszkania dziecka. Opłata sądowa wynosi 100 zł. Już we wniosku można żądać zabezpieczenia, czyli tymczasowego uregulowania kontaktów lub miejsca pobytu dziecka na czas trwania postępowania.",
           "Sąd przesłuchuje rodziców, może zlecić wywiad kuratora i opinię zespołu specjalistów sądowych, a dziecko — jeżeli pozwala na to jego rozwój i stopień dojrzałości — wysłuchać poza salą rozpraw. Pomagamy przygotować wniosek i dowody, które pokazują rzeczywistą sytuację opiekuńczą dziecka."
         ]}
      ],
      documents: [
        "odpis aktu urodzenia dziecka",
        "wcześniejsze orzeczenia sądu lub ugody dotyczące dziecka",
        "proponowany harmonogram kontaktów albo projekt porozumienia rodzicielskiego",
        "korespondencja z drugim rodzicem dotycząca dziecka",
        "notatki z datami kontaktów, które się nie odbyły",
        "opinie ze szkoły, przedszkola lub od psychologa",
        "dokumenty dotyczące warunków mieszkaniowych i trybu pracy",
        "dane świadków, którzy znają sytuację dziecka"
      ],
      faq: [
        {"Ile kosztuje sprawa o kontakty z dzieckiem?",
         "Opłata sądowa od wniosku o ustalenie kontaktów wynosi 100 zł. Do kosztów postępowania mogą dojść wydatki na opinię zespołu specjalistów sądowych."},
        {"Czy kontakty co drugi weekend to obowiązujący standard?",
         "Nie. Przepisy nie przewidują żadnego schematu kontaktów. Co drugi weekend i jedno popołudnie w tygodniu to rozwiązanie często spotykane w praktyce, ale sąd może ustalić kontakty szerzej albo węziej — zależnie od wieku dziecka i jego więzi z rodzicem."},
        {"Co grozi za utrudnianie kontaktów z dzieckiem?",
         "Sąd opiekuńczy może zagrozić nakazaniem zapłaty oznaczonej sumy pieniężnej za każde naruszenie, a następnie nakazać jej zapłatę na rzecz rodzica uprawnionego do kontaktów. Powtarzające się utrudnianie kontaktów może też wpłynąć na rozstrzygnięcie o władzy rodzicielskiej."},
        {"Czym różni się ograniczenie władzy rodzicielskiej od jej pozbawienia?",
         "Ograniczenie zawęża uprawnienia rodzica, na przykład przez nadzór kuratora albo pozostawienie mu decyzji tylko w określonych sprawach. Pozbawienie oznacza utratę władzy w całości — sąd orzeka je przy trwałej przeszkodzie, nadużywaniu władzy lub rażącym zaniedbywaniu obowiązków."},
        {"Czy pozbawienie władzy rodzicielskiej zwalnia z alimentów?",
         "Nie. Rodzic pozbawiony władzy rodzicielskiej nadal ma obowiązek alimentacyjny wobec dziecka. Pozbawienie władzy nie odbiera też automatycznie prawa do kontaktów ani nie wpływa na dziedziczenie."},
        {"Czy opieka naprzemienna wymaga zgody obojga rodziców?",
         "Przepisy nie wymagają tego wprost, ale opieka naprzemienna zakłada stałą współpracę rodziców. Przy ostrym konflikcie sąd zwykle uznaje, że takie rozwiązanie nie służy dziecku, i ustala miejsce jego pobytu przy jednym z rodziców."},
        {"Kto może wystąpić o ustalenie ojcostwa i do kiedy?",
         "Dziecko, matka oraz domniemany ojciec. Matka i domniemany ojciec mogą wytoczyć powództwo do osiągnięcia przez dziecko pełnoletności; dziecko nie jest ograniczone terminem."},
        {"Czy ustalone kontakty z dzieckiem można zmienić?",
         "Tak. Sąd opiekuńczy może zmienić rozstrzygnięcie o kontaktach, jeżeli wymaga tego dobro dziecka — na przykład gdy dziecko dorasta, zmienia szkołę albo jedno z rodziców się przeprowadza."}
      ]
    },
    "alimenty" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Ile wynoszą alimenty na dziecko i od czego zależą?",
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
        {"Czy opieka nad dzieckiem wpływa na wysokość alimentów?",
         [
           "Obowiązek alimentacyjny może być wykonywany także przez osobiste starania o utrzymanie i wychowanie dziecka (art. 135 § 2 k.r.o.). Rodzic, który na co dzień zajmuje się dzieckiem — organizuje jego naukę, leczenie i codzienne funkcjonowanie — realizuje w ten sposób część swojego obowiązku. W konsekwencji drugi, mniej zaangażowany rodzic może zostać zobowiązany do pokrywania większej części wydatków.",
           "Przed złożeniem pozwu warto przygotować szczegółowe zestawienie kosztów utrzymania dziecka, obejmujące zarówno wydatki miesięczne, jak i ponoszone okresowo — wyprawkę szkolną, sprzęt sportowy czy wakacje. Wydatki należy oszacować rozsądnie, bez podwójnego liczenia tych samych kosztów, i poprzeć rachunkami."
         ]},
        {"Jak złożyć pozew o alimenty?",
         [
           "Pozew składa się do sądu rejonowego — według wyboru: właściwego dla miejsca zamieszkania pozwanego albo osoby uprawnionej do alimentów. Powodem jest dziecko; małoletniego reprezentuje rodzic, pod którego opieką pozostaje, a pełnoletnie dziecko występuje samodzielnie. Pozew można złożyć także w trakcie trwania małżeństwa, bez wnoszenia sprawy o rozwód.",
           "W pozwie wskazuje się żądaną kwotę, opisuje potrzeby dziecka i sytuację obojga rodziców oraz dołącza dowody. Warto od razu złożyć wniosek o zabezpieczenie alimentów: sąd może wtedy zobowiązać pozwanego do płacenia określonej kwoty już w toku procesu. W sprawach o alimenty do udzielenia zabezpieczenia wystarczy uprawdopodobnienie roszczenia.",
           "Wyrokowi zasądzającemu alimenty sąd z urzędu nadaje rygor natychmiastowej wykonalności, dzięki czemu bieżące świadczenia można egzekwować jeszcze przed uprawomocnieniem się wyroku."
         ]},
        {"Do kiedy płaci się alimenty na dziecko?",
         [
           "Przepisy nie wyznaczają granicy wieku. Rodzice są obowiązani do świadczeń wobec dziecka, które nie jest jeszcze w stanie utrzymać się samodzielnie — ukończenie 18 lat samo więc niczego nie kończy, zwłaszcza gdy dziecko kontynuuje naukę. Po uzyskaniu pełnoletności to dziecko jest uprawnione do odbioru alimentów.",
           "Rodzice mogą uchylić się od alimentów wobec pełnoletniego dziecka, jeżeli świadczenia są dla nich połączone z nadmiernym uszczerbkiem albo dziecko nie dokłada starań, by uzyskać możność samodzielnego utrzymania się (art. 133 § 3 k.r.o.). Obowiązek nie wygasa jednak sam — dopóki obowiązuje wyrok, alimenty trzeba płacić, a zmiana wymaga porozumienia albo orzeczenia sądu."
         ]},
        {"Jak podwyższyć lub obniżyć alimenty?",
         [
           "Zasądzone alimenty nie muszą pozostać niezmienne. Jeżeli po wydaniu wyroku nastąpi istotna zmiana sytuacji, można żądać ich podwyższenia lub obniżenia na podstawie art. 138 Kodeksu rodzinnego i opiekuńczego. Sam upływ czasu nie wystarcza — trzeba wykazać zmianę stosunków, na przykład wzrost potrzeb dziecka związany z wiekiem i nauką albo zmianę możliwości zarobkowych rodzica.",
           "Rodzice mogą też zmienić wysokość alimentów bez procesu — w ugodzie zawartej przed mediatorem i zatwierdzonej przez sąd. Osoba pozwana o podwyższenie alimentów powinna z kolei wykazać własne usprawiedliwione wydatki i to, w jakim zakresie już uczestniczy w utrzymaniu dziecka."
         ]},
        {"Ile kosztuje sprawa o alimenty?",
         [
           "Osoba dochodząca alimentów na dziecko jest zwolniona od kosztów sądowych — także w sprawie o podwyższenie alimentów. Opłatę trzeba natomiast uiścić w sprawie o obniżenie alimentów albo uchylenie obowiązku alimentacyjnego: jej wysokość zależy od wartości przedmiotu sporu, liczonej jako suma świadczeń za rok. Przy wartości do 20 000 zł opłata jest stała i wynosi od 30 zł do 1 000 zł, a powyżej tej kwoty — 5% wartości (art. 13 ustawy o kosztach sądowych w sprawach cywilnych). Przykładowo, przy żądaniu obniżenia alimentów o 200 zł miesięcznie wartość przedmiotu sporu to 2 400 zł, a opłata — 200 zł."
         ]},
        {"Jak wyegzekwować zaległe alimenty?",
         [
           "Jeżeli zobowiązany nie płaci, wyrok lub ugodę z klauzulą wykonalności składa się u komornika. Egzekucja alimentów jest uprzywilejowana: z wynagrodzenia za pracę można potrącić do trzech piątych, a alimenty mają pierwszeństwo przed innymi długami.",
           "Gdy egzekucja okazuje się bezskuteczna, osoba uprawniona może ubiegać się o świadczenia z funduszu alimentacyjnego, o ile spełnia kryterium dochodowe. Uporczywe niepłacenie alimentów jest też przestępstwem: odpowiada za nie ten, kto uchyla się od obowiązku, jeżeli łączna wysokość zaległości stanowi równowartość co najmniej trzech świadczeń okresowych (art. 209 Kodeksu karnego).",
           "Roszczenia o zaległe świadczenia alimentacyjne przedawniają się z upływem trzech lat, dlatego z egzekucją nie warto zwlekać."
         ]},
        {"Kto jeszcze może żądać alimentów?",
         [
           "Obowiązek alimentacyjny obciąża krewnych w linii prostej i rodzeństwo. Gdy rodzic nie jest w stanie łożyć na dziecko albo uzyskanie od niego świadczeń jest niemożliwe lub połączone z nadmiernymi trudnościami, alimentów można dochodzić od dalszych krewnych — w praktyce od dziadków. Rodzic znajdujący się w niedostatku może z kolei żądać alimentów od dorosłego dziecka; zobowiązany może się od nich uchylić, jeżeli żądanie jest sprzeczne z zasadami współżycia społecznego.",
           "Alimenty między małżonkami i byłymi małżonkami opisujemy na stronie o [rozwodzie](/uslugi/rozwod)."
         ]}
      ],
      documents: [
        "odpis aktu urodzenia dziecka",
        "dokumenty dotyczące dochodów i sytuacji finansowej rodzica",
        "zestawienie miesięcznych kosztów utrzymania dziecka",
        "rachunki i faktury dotyczące wydatków na dziecko",
        "potwierdzenia opłat szkolnych i za zajęcia dodatkowe",
        "dokumentacja medyczna, jeżeli dziecko wymaga leczenia",
        "dokumenty dotyczące kosztów mieszkania",
        "wcześniejszy wyrok lub ugoda w sprawie alimentów",
        "informacje o sytuacji zarobkowej drugiego rodzica, jeżeli są dostępne zgodnie z prawem"
      ],
      faq: [
        {"Do kiedy płaci się alimenty na dziecko?",
         "Przepisy nie określają granicy wieku. Obowiązek trwa do czasu, gdy dziecko jest w stanie utrzymać się samodzielnie, więc ukończenie 18 lat samo go nie kończy — na przykład gdy dziecko nadal się uczy."},
        {"Czy trzeba płacić alimenty na pełnoletnie dziecko, które się uczy?",
         "Co do zasady tak. Rodzice mogą uchylić się od alimentów wobec pełnoletniego dziecka tylko wtedy, gdy wiążą się one dla nich z nadmiernym uszczerbkiem albo dziecko nie dokłada starań, by uzyskać samodzielność. Wymaga to porozumienia albo wyroku sądu."},
        {"Komu płacić alimenty na pełnoletnie dziecko?",
         "Po uzyskaniu pełnoletności uprawnionym do odbioru alimentów jest samo dziecko. Świadczenie można przekazywać rodzicowi tylko wtedy, gdy dziecko go do tego upoważni."},
        {"Czy pozew o alimenty jest płatny?",
         "Nie. Osoba dochodząca alimentów jest zwolniona od kosztów sądowych, także przy podwyższeniu alimentów. Opłatę wnosi się w sprawie o obniżenie alimentów lub uchylenie obowiązku alimentacyjnego."},
        {"Co to jest zabezpieczenie alimentów?",
         "To tymczasowe postanowienie sądu, które zobowiązuje pozwanego do płacenia określonej kwoty już w trakcie procesu. Wniosek o zabezpieczenie składa się zwykle razem z pozwem; wystarczy uprawdopodobnić roszczenie."},
        {"Od kiedy należą się alimenty?",
         "Sąd zasądza alimenty co do zasady od dnia wniesienia pozwu. Świadczeń za wcześniejszy okres można dochodzić wyjątkowo — gdy pozostały niezaspokojone potrzeby dziecka z tego czasu albo zaciągnięte na ich pokrycie zobowiązania."},
        {"Czy alimenty się przedawniają?",
         "Samo prawo do alimentów nie ulega przedawnieniu, ale roszczenia o poszczególne zaległe świadczenia przedawniają się z upływem trzech lat (art. 137 § 1 k.r.o.)."},
        {"Czy bezrobotny rodzic musi płacić alimenty?",
         "Tak. Sąd bierze pod uwagę nie faktyczne zarobki, lecz możliwości zarobkowe i majątkowe rodzica — czyli to, ile mógłby zarabiać przy pełnym wykorzystaniu swoich sił, kwalifikacji i doświadczenia."},
        {"Kto płaci alimenty, gdy ojciec nie płaci albo zmarł?",
         "Gdy egzekucja komornicza jest bezskuteczna, świadczenia może wypłacać fundusz alimentacyjny; alimentów można też dochodzić od dalszych krewnych, na przykład dziadków. Obowiązek alimentacyjny wygasa ze śmiercią zobowiązanego i nie przechodzi na spadkobierców — do spadku wchodzą jedynie zaległe raty."},
        {"Co grozi za niepłacenie alimentów?",
         "Egzekucja komornicza, a przy zaległości odpowiadającej co najmniej trzem świadczeniom okresowym — odpowiedzialność karna za niealimentację: grzywna, ograniczenie wolności albo pozbawienie wolności (art. 209 Kodeksu karnego)."},
        {"Czy opieka naprzemienna wyklucza alimenty?",
         "Nie automatycznie. Jeżeli rodzice ponoszą koszty utrzymania dziecka w podobnym zakresie, sąd może alimentów nie zasądzać, ale przy wyraźnej różnicy w możliwościach zarobkowych może je orzec."},
        {"Czy istnieje minimalna kwota alimentów albo procent wynagrodzenia?",
         "Nie. Przepisy nie określają minimalnej ani maksymalnej kwoty alimentów ani ich procentowego udziału w wynagrodzeniu. Decydują usprawiedliwione potrzeby dziecka oraz zarobkowe i majątkowe możliwości rodzica."}
      ]
    },
    "zachowek" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Komu przysługuje zachowek?",
         [
           "Uprawnieni do zachowku są zstępni, małżonek oraz rodzice spadkodawcy — jeżeli byliby powołani do spadku z ustawy (art. 991 § 1 k.c.). W typowej sytuacji są to dzieci i małżonek zmarłego. Rodzice są uprawnieni tylko wtedy, gdy spadkodawca nie pozostawił zstępnych, a wnuki — gdy ich rodzic, będący dzieckiem spadkodawcy, nie dożył otwarcia spadku, odrzucił spadek albo został wydziedziczony.",
           "Zachowek nie przysługuje rodzeństwu spadkodawcy ani dalszym krewnym. Prawa do niego nie mają też osoby wydziedziczone, uznane za niegodne dziedziczenia, te, które odrzuciły spadek lub zrzekły się dziedziczenia, a także małżonek pozostający w separacji."
         ]},
        {"Jak obliczyć zachowek krok po kroku?",
         [
           "Obliczenie zachowku przebiega w kilku krokach:",
           {:list,
            [
              "ustala się czystą wartość spadku, czyli wartość majątku pomniejszoną o długi spadkowe,",
              "dolicza się darowizny i zapisy windykacyjne dokonane przez spadkodawcę,",
              "określa się udział, jaki przypadłby uprawnionemu przy dziedziczeniu ustawowym,",
              "mnoży się ten udział przez jedną drugą albo dwie trzecie,",
              "odejmuje się darowizny i zapisy, które uprawniony sam otrzymał od spadkodawcy."
            ]},
           "Przykład: wdowiec pozostawił dwoje dzieci i w testamencie przekazał cały majątek o wartości 600 000 zł jednemu z nich. Drugie dziecko dziedziczyłoby z ustawy połowę, czyli 300 000 zł — jego zachowek wynosi więc połowę tej kwoty, to jest 150 000 zł.",
           "Wartość przedmiotu darowizny oblicza się według stanu z chwili jej dokonania, a według cen z chwili ustalania zachowku (art. 995 § 1 k.c.). Przy nieruchomościach o wyniku sporu często decyduje więc opinia biegłego rzeczoznawcy."
         ]},
        {"Czy zachowek należy się od darowizny?",
         [
           "Tak. Zachowek chroni nie tylko przed pominięciem w testamencie, ale i przed rozdaniem majątku za życia. Do spadku dolicza się darowizny dokonane przez spadkodawcę — w tym darowizny na rzecz spadkobierców i osób uprawnionych do zachowku, bez względu na to, kiedy zostały dokonane.",
           "Nie dolicza się drobnych darowizn zwyczajowo przyjętych w danych stosunkach ani darowizn dokonanych przed więcej niż dziesięciu laty, licząc wstecz od otwarcia spadku, na rzecz osób, które nie są spadkobiercami ani uprawnionymi do zachowku (art. 994 § 1 k.c.). Co do zasady nie dolicza się też majątku przekazanego na podstawie umowy dożywocia, ponieważ nie jest ona darowizną."
         ]},
        {"Kto płaci zachowek?",
         [
           "W pierwszej kolejności zobowiązany jest spadkobierca — testamentowy albo ustawowy. Jeżeli uprawniony nie może otrzymać od niego należnego zachowku, może żądać brakującej sumy od osoby, na której rzecz uczyniono zapis windykacyjny, a w dalszej kolejności od osoby, która otrzymała od spadkodawcy darowiznę doliczoną do spadku.",
           "Obdarowany odpowiada tylko w granicach wzbogacenia będącego skutkiem darowizny i może zwolnić się od zapłaty przez wydanie jej przedmiotu (art. 1000 k.c.). Spadkobierca, który sam jest uprawniony do zachowku, odpowiada wobec innych tylko do wysokości nadwyżki przekraczającej jego własny zachowek."
         ]},
        {"Kiedy zachowek się nie należy — wydziedziczenie",
         [
           "Spadkodawca może w testamencie pozbawić zachowku zstępnych, małżonka i rodziców, ale tylko z przyczyn wskazanych w ustawie (art. 1008 k.c.) — gdy uprawniony:",
           {:list,
            [
              "wbrew woli spadkodawcy postępuje uporczywie w sposób sprzeczny z zasadami współżycia społecznego,",
              "dopuścił się względem spadkodawcy albo jednej z najbliższych mu osób umyślnego przestępstwa przeciwko życiu, zdrowiu lub wolności albo rażącej obrazy czci,",
              "uporczywie nie dopełnia względem spadkodawcy obowiązków rodzinnych."
            ]},
           "Przyczyna wydziedziczenia musi wynikać z treści testamentu i być prawdziwa. Wydziedziczenie można podważyć w procesie o zachowek — na przykład wykazując, że wskazana przyczyna nie istniała albo że spadkodawca uprawnionemu przebaczył. Zstępni wydziedziczonego zstępnego zachowują prawo do zachowku."
         ]},
        {"Do kiedy można żądać zachowku?",
         [
           "Roszczenie o zachowek przedawnia się z upływem pięciu lat od ogłoszenia testamentu. Roszczenie przeciwko osobie obowiązanej do uzupełnienia zachowku z tytułu otrzymanego zapisu windykacyjnego lub darowizny przedawnia się z upływem pięciu lat od otwarcia spadku, czyli od śmierci spadkodawcy (art. 1007 k.c.).",
           "Bieg przedawnienia przerywa między innymi wniesienie pozwu. Samo wezwanie do zapłaty go nie przerywa, dlatego przy zbliżającym się końcu terminu nie warto poprzestawać na korespondencji."
         ]},
        {"Czy zachowek można obniżyć albo rozłożyć na raty?",
         [
           "Od 22 maja 2023 r. osoba obowiązana do zapłaty zachowku może żądać odroczenia terminu płatności, rozłożenia go na raty, a w wyjątkowych przypadkach — obniżenia, przy uwzględnieniu sytuacji osobistej i majątkowej obu stron (art. 997¹ k.c.). Rozłożenie na raty nie powinno co do zasady przekraczać pięciu lat.",
           "Ma to znaczenie zwłaszcza wtedy, gdy jedynym składnikiem spadku jest mieszkanie, w którym spadkobierca mieszka, a zapłata całej kwoty od razu wymagałaby jego sprzedaży."
         ]},
        {"Czy można uniknąć zapłaty zachowku?",
         [
           "Prawo przewiduje kilka rozwiązań, z których można skorzystać za życia spadkodawcy. Przyszły spadkobierca ustawowy może zawrzeć ze spadkodawcą umowę o zrzeczenie się dziedziczenia — także ograniczoną do samego zachowku; wymaga ona formy aktu notarialnego. Znaczenie ma również sposób przekazania majątku: darowizna jest doliczana do spadku, a umowa dożywocia co do zasady nie.",
           "Żadne z tych rozwiązań nie jest uniwersalne i każde wywołuje dalsze skutki — podatkowe i rodzinne. Planowanie przekazania majątku, w tym firmy, opisujemy szerzej na stronie o [sukcesji firm rodzinnych](/uslugi/sukcesja-firm)."
         ]},
        {"Jak wygląda sprawa o zachowek?",
         [
           {:list,
            [
              "Ustalenie kręgu uprawnionych, składu spadku i darowizn dokonanych przez spadkodawcę.",
              "Wyliczenie należnej kwoty i wezwanie zobowiązanego do zapłaty.",
              "Negocjacje — w tym co do terminu płatności i rat.",
              "Pozew o zapłatę i postępowanie dowodowe, zwykle z opinią biegłego rzeczoznawcy."
            ]},
           "Pozew wnosi się wyłącznie do sądu ostatniego miejsca zwykłego pobytu spadkodawcy: rejonowego, gdy dochodzona kwota nie przekracza 100 000 zł, albo okręgowego. Opłata jest stała i wynosi od 30 zł do 1 000 zł przy roszczeniach do 20 000 zł, a powyżej tej kwoty — 5% dochodzonej sumy."
         ]}
      ],
      documents: [
        "odpis aktu zgonu spadkodawcy",
        "testament oraz protokół jego otwarcia i ogłoszenia",
        "postanowienie o stwierdzeniu nabycia spadku albo akt poświadczenia dziedziczenia",
        "odpisy aktów stanu cywilnego potwierdzające pokrewieństwo",
        "umowy darowizn i akty notarialne dotyczące majątku spadkodawcy",
        "numery ksiąg wieczystych i dokumenty pozwalające wycenić majątek",
        "informacje o długach spadkowych",
        "dokumenty dotyczące darowizn otrzymanych przez uprawnionego"
      ],
      faq: [
        {"Komu przysługuje zachowek po rodzicach?",
         "Dzieciom spadkodawcy oraz jego małżonkowi, a gdy dziecko nie dożyło otwarcia spadku — jego zstępnym, czyli wnukom spadkodawcy. Warunkiem jest to, że dana osoba dziedziczyłaby z ustawy."},
        {"Czy zachowek należy się rodzeństwu i wnukom?",
         "Rodzeństwu spadkodawcy zachowek nie przysługuje. Wnuki są uprawnione tylko wtedy, gdy ich rodzic — dziecko spadkodawcy — nie dożył otwarcia spadku, odrzucił spadek albo został wydziedziczony."},
        {"Czy zachowek należy się od darowizny mieszkania lub domu?",
         "Tak. Darowiznę dolicza się do spadku przy obliczaniu zachowku, a jej wartość ustala się według stanu z chwili darowizny i cen z chwili ustalania zachowku. Wyjątkiem są między innymi darowizny sprzed ponad dziesięciu lat na rzecz osób, które nie są spadkobiercami ani uprawnionymi do zachowku."},
        {"Kto płaci zachowek?",
         "W pierwszej kolejności spadkobierca. Jeżeli nie można uzyskać od niego należnej sumy — osoba, która otrzymała zapis windykacyjny, a następnie osoba obdarowana przez spadkodawcę, w granicach swojego wzbogacenia."},
        {"Kiedy przedawnia się roszczenie o zachowek?",
         "Po pięciu latach od ogłoszenia testamentu, a roszczenie wobec obdarowanego lub zapisobiercy windykacyjnego — po pięciu latach od śmierci spadkodawcy."},
        {"Kiedy zachowek się nie należy?",
         "Między innymi wtedy, gdy uprawniony został skutecznie wydziedziczony, uznany za niegodnego dziedziczenia, odrzucił spadek albo zrzekł się dziedziczenia. Zachowku nie dochodzi też osoba, która otrzymała od spadkodawcy darowizny lub udział w spadku o wartości co najmniej równej należnemu zachowkowi."},
        {"Czy wydziedziczenie można podważyć?",
         "Tak. W procesie o zachowek sąd bada, czy przyczyna wydziedziczenia została wskazana w testamencie, czy rzeczywiście istniała i czy spadkodawca nie przebaczył uprawnionemu. Jeżeli wydziedziczenie okaże się bezskuteczne, zachowek przysługuje."},
        {"Czy można zrzec się zachowku?",
         "Tak. Przyszły spadkobierca ustawowy może zawrzeć ze spadkodawcą umowę o zrzeczenie się dziedziczenia, także ograniczoną do prawa do zachowku. Umowa wymaga formy aktu notarialnego i — jeżeli nie postanowiono inaczej — obejmuje również zstępnych zrzekającego się."},
        {"Czy zachowek można rozłożyć na raty?",
         "Tak. Od 22 maja 2023 r. zobowiązany może żądać odroczenia terminu płatności zachowku, rozłożenia go na raty, a w wyjątkowych przypadkach — jego obniżenia."},
        {"Czy zachowek jest dziedziczny?",
         "Roszczenie o zachowek przechodzi na spadkobiercę osoby uprawnionej tylko wtedy, gdy ten spadkobierca sam należy do osób uprawnionych do zachowku po pierwszym spadkodawcy (art. 1002 k.c.)."},
        {"Do jakiego sądu złożyć pozew o zachowek i ile to kosztuje?",
         "Do sądu ostatniego miejsca zwykłego pobytu spadkodawcy — rejonowego przy roszczeniach do 100 000 zł albo okręgowego powyżej tej kwoty. Opłata od pozwu wynosi od 30 zł do 1 000 zł przy roszczeniach do 20 000 zł, a powyżej — 5% dochodzonej kwoty."}
      ]
    },
    "podzial-majatku" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Podział majątku u notariusza czy w sądzie?",
         [
           "Majątek wspólny można podzielić umownie albo w postępowaniu sądowym. Podział umowny jest szybszy i tańszy, ale wymaga zgody obojga byłych małżonków co do składu majątku i sposobu podziału; jeżeli obejmuje nieruchomość, umowa wymaga formy aktu notarialnego.",
           "Gdy porozumienie nie jest możliwe, o podziale rozstrzyga sąd. Opłata od wniosku o podział majątku wspólnego wynosi 1 000 zł, a jeżeli wniosek zawiera zgodny projekt podziału — 300 zł. Sąd ustala skład i wartość majątku, rozlicza nakłady i wydatki oraz przyznaje poszczególne składniki, zwykle z obowiązkiem spłaty lub dopłaty."
         ]},
        {"Kto spłaca wspólny kredyt po rozwodzie?",
         [
           "Rozwód nie zwalnia automatycznie żadnego z małżonków z obowiązku spłaty wspólnego kredytu. Ustanie wspólności majątkowej nie jest równoznaczne z ustaniem odpowiedzialności za kredyt — dopóki nie dojdzie do skutecznej zmiany zobowiązania wobec banku, oboje byli małżonkowie odpowiadają za jego spłatę solidarnie.",
           "Oznacza to, że bank może żądać spłaty całego wymagalnego zobowiązania od każdego z nich z osobna lub od obojga naraz — także wtedy, gdy w kredytowanym mieszkaniu mieszka tylko jedno z nich. Porozumienie byłych małżonków, zgodnie z którym raty spłaca tylko jedno z nich, nie jest wiążące dla banku."
         ]},
        {"Czy sąd podzieli wspólny kredyt?",
         [
           "Nie. Sąd dzieli majątek wspólny, czyli jego aktywa, ale co do zasady nie dzieli długów wobec banków. Może przyznać mieszkanie jednemu z byłych małżonków i ustalić spłatę należną drugiemu, nie może jednak samym postanowieniem zwolnić jednego z kredytobiorców z odpowiedzialności wobec banku.",
           "Podział mieszkania i podział zobowiązania kredytowego to więc dwie odrębne kwestie. Osoba, która po podziale przestaje być właścicielem mieszkania, formalnie nadal odpowiada za kredyt — dlatego warunki podziału warto ustalać z uwzględnieniem dalszej obsługi kredytu."
         ]},
        {"Jak wycenia się mieszkanie z hipoteką?",
         [
           "Co do zasady sąd ustala wartość rynkową nieruchomości bez pomniejszania jej o wartość obciążenia hipotecznego, chyba że zachodzą szczególnie istotne powody uzasadniające odmienne rozliczenie (uchwała Sądu Najwyższego z 25 lipca 2019 r., III CZP 14/19).",
           "Przykładowo, jeżeli mieszkanie ma wartość rynkową 700 000 zł i jest obciążone hipoteką, punktem wyjścia do rozliczeń jest wartość rynkowa. Nie oznacza to, że spłata należna drugiemu małżonkowi zawsze wyniesie połowę tej kwoty — znaczenie mają także udziały małżonków, pozostałe składniki majątku i roszczenia rozliczeniowe."
         ]},
        {"Jak przejąć kredyt po rozwodzie?",
         [
           "Jeżeli po rozwodzie za kredyt ma odpowiadać tylko jedno z byłych małżonków, konieczna jest zgoda banku — w formie aneksu albo nowej umowy. Bank zbada zdolność kredytową osoby, która ma samodzielnie spłacać zobowiązanie, i przy ocenie negatywnej może odmówić zwolnienia drugiego kredytobiorcy z długu."
         ]},
        {"Czy można odzyskać raty spłacone po rozwodzie?",
         [
           "Choć sąd nie dzieli samego długu, może w ramach podziału majątku rozliczyć raty, które jedno z małżonków spłaciło z własnych środków po rozwodzie. W praktyce może to oznaczać zwrot równowartości połowy uiszczonych rat albo przyznanie większej części majątku wspólnego.",
           "Gdy żadne z byłych małżonków nie jest w stanie samodzielnie spłacać kredytu, do rozważenia pozostaje sprzedaż nieruchomości i podział kwoty pozostałej po spłacie banku, wynajem i przeznaczanie czynszu na raty albo rozmowa z bankiem o restrukturyzacji zadłużenia, na przykład wydłużeniu okresu kredytowania. Gdy mimo to spłata długów przestaje być możliwa, ostatecznym rozwiązaniem bywa [upadłość konsumencka](/uslugi/upadlosc-konsumencka)."
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
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jak krok po kroku przebiega upadłość konsumencka?",
         [
           "Postępowanie rozpoczyna się od złożenia wniosku do sądu. Jeżeli sąd ogłosi upadłość, wyznacza syndyka, który ustala sytuację majątkową dłużnika i zajmuje się majątkiem objętym postępowaniem, w tym jego sprzedażą. Uzyskane środki służą pokryciu kosztów postępowania i spłacie wierzycieli.",
           "Ogłoszenie upadłości nie oznacza jeszcze umorzenia długów. W dalszym etapie sąd rozstrzyga, czy dłużnik powinien dokonywać spłat według planu, czy możliwe jest oddłużenie bez dalszych rat. Ogłoszenie upadłości wpływa też na egzekucję komorniczą: wcześniej wszczęte egzekucje skierowane do majątku objętego upadłością zostają zawieszone, a po uprawomocnieniu się postanowienia — umorzone. Samo złożenie wniosku nie wywołuje tych skutków."
         ]},
        {"Które długi mogą zostać umorzone?",
         [
           "Oddłużenie może objąć między innymi kredyty, pożyczki, niezapłacone rachunki, zobowiązania z wcześniejszej działalności gospodarczej, a także zaległości podatkowe lub składkowe — co do zasady powstałe przed ogłoszeniem upadłości.",
           "Nie wszystkie należności można umorzyć. Wyłączenia dotyczą między innymi alimentów, grzywien orzeczonych przez sąd oraz niektórych zobowiązań odszkodowawczych, w tym obowiązku naprawienia szkody wynikającej z przestępstwa. We wniosku należy ujawnić także długi sporne — umyślne pominięcie zobowiązania może sprawić, że nie zostanie ono umorzone."
         ]},
        {"Co stanie się z mieszkaniem i wynagrodzeniem?",
         [
           "Upadłość konsumencka może oznaczać sprzedaż mieszkania, domu, samochodu i innych wartościowych składników majątku. Zamieszkiwanie w nieruchomości wraz z dziećmi nie zapewnia automatycznie zachowania jej własności.",
           "Przy sprzedaży mieszkania lub domu, w którym dłużnik zamieszkuje, ustawa chroni jego potrzeby mieszkaniowe: z ceny sprzedaży wydziela się kwotę odpowiadającą przeciętnemu czynszowi najmu w tej samej lub sąsiedniej miejscowości za okres od 12 do 24 miesięcy. Dłużnik zachowuje też mienie i środki objęte ustawową ochroną, w tym chronioną część wynagrodzenia."
         ]},
        {"Jak upadłość wpływa na małżonka i rodzinę?",
         [
           "Ogłoszenie upadłości jednego z małżonków powoduje powstanie rozdzielności majątkowej. Jeżeli wcześniej małżonków łączyła wspólność, majątek wspólny co do zasady zostaje objęty postępowaniem, a drugi małżonek powinien zgłosić należność z tytułu swojego udziału. Ustanowienie rozdzielności krótko przed złożeniem wniosku nie zawsze ochroni majątek. O rozliczeniach między małżonkami piszemy na stronie o [podziale majątku](/uslugi/podzial-majatku).",
           "Sama więź rodzinna nie tworzy obowiązku spłacania długów innych członków rodziny. Inaczej jest w przypadku współkredytobiorcy lub poręczyciela: umorzenie zobowiązań jednej osoby nie zwalnia pozostałych osób odpowiedzialnych za ten sam dług."
         ]},
        {"Ile trwa plan spłaty i kiedy sąd umorzy długi bez rat?",
         [
           "Plan spłaty wierzycieli określa, jakie kwoty i przez jaki czas dłużnik ma wpłacać. Sąd uwzględnia możliwości zarobkowe, konieczne koszty utrzymania i potrzeby mieszkaniowe dłużnika oraz osób na jego utrzymaniu. Podstawowy okres planu nie przekracza trzech lat; jeżeli dłużnik umyślnie lub wskutek rażącego niedbalstwa doprowadził do niewypłacalności albo istotnie ją pogłębił — wynosi od trzech do siedmiu lat. Nie ma zasady, że trzeba spłacić określony procent długów.",
           "Umorzenie bez dalszych spłat jest możliwe w szczególności wtedy, gdy sytuacja osobista dłużnika wskazuje, że trwale nie będzie on zdolny do dokonywania nawet częściowych spłat. Jeżeli niezdolność jest przejściowa, sąd może zastosować warunkowe umorzenie zobowiązań z pięcioletnim okresem obowiązków sprawozdawczych."
         ]},
        {"Co może utrudnić oddłużenie?",
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
        {"Jak złożyć wniosek i ile kosztuje upadłość konsumencka?",
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
    },
    "odszkodowania" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Co obejmuje odszkodowanie, a co zadośćuczynienie i renta?",
         [
           "Odszkodowanie naprawia szkodę majątkową: obejmuje straty, które poszkodowany poniósł, oraz korzyści, które mógłby osiągnąć, gdyby szkody mu nie wyrządzono (art. 361 § 2 k.c.). Przy uszkodzeniu ciała lub rozstroju zdrowia są to wszelkie wynikłe z tego koszty (art. 444 § 1 k.c.), w szczególności:",
           {:list,
            [
              "leczenie, leki, rehabilitacja i sprzęt medyczny,",
              "dojazdy do placówek medycznych i koszty opieki osób trzecich,",
              "utracone zarobki za czas niezdolności do pracy,",
              "przygotowanie do innego zawodu, jeżeli poszkodowany stał się inwalidą."
            ]},
           "Na żądanie poszkodowanego zobowiązany powinien wyłożyć z góry sumę potrzebną na koszty leczenia. Zadośćuczynienie (art. 445 § 1 k.c.) jest z kolei pieniężną rekompensatą krzywdy — bólu, cierpienia i ograniczeń w codziennym życiu. Renta (art. 444 § 2 k.c.) przysługuje, gdy poszkodowany utracił całkowicie lub częściowo zdolność do pracy zarobkowej, zwiększyły się jego potrzeby albo zmniejszyły widoki powodzenia na przyszłość."
         ]},
        {"Od czego zależy wysokość zadośćuczynienia?",
         [
           "Przepisy nie zawierają tabel ani stawek zadośćuczynienia — kodeks mówi jedynie o „odpowiedniej sumie”. Sąd ocenia rozmiar krzywdy w konkretnej sprawie, biorąc pod uwagę między innymi rodzaj i trwałość obrażeń, długość i uciążliwość leczenia, wiek poszkodowanego oraz to, jak zdarzenie wpłynęło na jego pracę, życie rodzinne i dotychczasowe aktywności. Procentowy uszczerbek na zdrowiu ustalony przez lekarza jest wskazówką, a nie jedynym miernikiem.",
           "Jeżeli poszkodowany przyczynił się do powstania lub zwiększenia szkody — na przykład jechał bez zapiętych pasów — obowiązek jej naprawienia ulega odpowiedniemu zmniejszeniu (art. 362 k.c.). O stopniu przyczynienia często toczy się spór z ubezpieczycielem, dlatego warto zabezpieczyć dowody dotyczące przebiegu zdarzenia."
         ]},
        {"Jak zgłosić szkodę i ile czeka się na wypłatę?",
         [
           "Poszkodowany może dochodzić roszczenia bezpośrednio od ubezpieczyciela sprawcy (art. 822 § 4 k.c.). W ubezpieczeniach obowiązkowych, w tym OC posiadaczy pojazdów, zakład ubezpieczeń wypłaca odszkodowanie w terminie 30 dni od złożenia zawiadomienia o szkodzie. Jeżeli w tym czasie nie da się wyjaśnić okoliczności koniecznych do ustalenia odpowiedzialności albo wysokości świadczenia, termin wydłuża się do 14 dni od dnia, w którym przy zachowaniu należytej staranności wyjaśnienie było możliwe — nie dłużej jednak niż do 90 dni od zawiadomienia, chyba że rozstrzygnięcie zależy od toczącego się postępowania karnego lub cywilnego. Część bezsporną ubezpieczyciel wypłaca w ciągu 30 dni.",
           "Od decyzji ubezpieczyciela można złożyć reklamację, na którą powinien on odpowiedzieć w ciągu 30 dni, a w szczególnie skomplikowanych przypadkach — 60 dni. Reklamacja nie jest warunkiem wniesienia pozwu. Gdy sprawca nie miał obowiązkowego ubezpieczenia OC albo nie udało się go ustalić, roszczenia zgłasza się do Ubezpieczeniowego Funduszu Gwarancyjnego."
         ]},
        {"Co przysługuje rodzinie po śmierci osoby bliskiej?",
         [
           "Jeżeli wskutek zdarzenia nastąpiła śmierć poszkodowanego, roszczenia przysługują jego bliskim (art. 446 k.c.). Obejmują one zwrot kosztów leczenia i pogrzebu, rentę dla osób, wobec których zmarły miał obowiązek alimentacyjny, stosowne odszkodowanie dla najbliższych członków rodziny, gdy wskutek śmierci znacznie pogorszyła się ich sytuacja życiowa, oraz zadośćuczynienie za doznaną krzywdę."
         ]},
        {"Do kiedy można dochodzić odszkodowania?",
         [
           "Poza terminami opisanymi w skrócie na początku strony znaczenie mają dwie reguły ochronne. W razie szkody na osobie przedawnienie nie może skończyć się wcześniej niż po upływie trzech lat od dnia, w którym poszkodowany dowiedział się o szkodzie i o osobie obowiązanej do jej naprawienia. Roszczenia osoby małoletniej z tytułu szkody na osobie nie przedawniają się wcześniej niż z upływem dwóch lat od uzyskania przez nią pełnoletności (art. 442¹ § 3 i 4 k.c.).",
           "Bieg przedawnienia roszczenia wobec ubezpieczyciela przerywa także zgłoszenie mu roszczenia lub zdarzenia objętego ubezpieczeniem; termin zaczyna biec na nowo od dnia, w którym zgłaszający otrzymał na piśmie oświadczenie ubezpieczyciela o przyznaniu lub odmowie świadczenia (art. 819 § 4 k.c.)."
         ]},
        {"Do którego sądu złożyć pozew i ile to kosztuje?",
         [
           "Sprawy o roszczenia do 100 000 zł rozpoznaje sąd rejonowy, a powyżej tej kwoty — sąd okręgowy. Opłata od pozwu zależy od wartości przedmiotu sporu: do 20 000 zł jest stała i wynosi od 30 zł do 1 000 zł, a powyżej tej kwoty — 5% wartości, nie więcej niż 200 000 zł (art. 13 ustawy o kosztach sądowych w sprawach cywilnych). Osoba, której nie stać na poniesienie kosztów, może wnosić o zwolnienie od nich w całości lub w części.",
           "W sprawach o szkodę na osobie sąd zwykle dopuszcza dowód z opinii biegłego lekarza, co wpływa na czas trwania postępowania. Przed wniesieniem pozwu przedstawiamy ocenę szans, przewidywane koszty i realny zakres roszczeń."
         ]}
      ],
      documents: [
        "dokumentacja medyczna: karty informacyjne, wyniki badań, zaświadczenia lekarskie",
        "notatka policyjna, oświadczenie sprawcy lub inne dokumenty opisujące zdarzenie",
        "decyzje ubezpieczyciela i korespondencja w sprawie szkody",
        "rachunki i faktury za leczenie, leki, rehabilitację i dojazdy",
        "zwolnienia lekarskie i zaświadczenia o zarobkach sprzed zdarzenia",
        "zdjęcia z miejsca zdarzenia i dane świadków",
        "wyrok karny lub informacje o toczącym się postępowaniu karnym",
        "kosztorys lub wycena naprawy przy szkodzie w mieniu"
      ],
      faq: [
        {"Czym różni się odszkodowanie od zadośćuczynienia?",
         "Odszkodowanie naprawia szkodę majątkową — poniesione koszty i utracone korzyści. Zadośćuczynienie jest pieniężną rekompensatą krzywdy, czyli bólu, cierpienia i ograniczeń w codziennym życiu. Obu świadczeń można dochodzić jednocześnie."},
        {"Ile czasu ma ubezpieczyciel na wypłatę odszkodowania z OC?",
         "Co do zasady 30 dni od zawiadomienia o szkodzie. Gdy wyjaśnienie okoliczności w tym czasie nie jest możliwe — 14 dni od dnia, w którym przy zachowaniu należytej staranności stało się to możliwe, nie dłużej jednak niż 90 dni od zawiadomienia, chyba że rozstrzygnięcie zależy od toczącego się postępowania karnego lub cywilnego."},
        {"Czy trzeba przyjąć kwotę zaproponowaną przez ubezpieczyciela?",
         "Nie. Przyjęcie wypłaconej kwoty bezspornej nie zamyka drogi do dochodzenia dalszych roszczeń. Inaczej jest z ugodą, w której poszkodowany zrzeka się dalszych roszczeń — przed jej podpisaniem warto sprawdzić, czy proponowana kwota odpowiada rzeczywistej szkodzie."},
        {"Co zrobić, gdy sprawca wypadku nie miał OC albo uciekł z miejsca zdarzenia?",
         "Roszczenia zgłasza się wtedy do Ubezpieczeniowego Funduszu Gwarancyjnego, za pośrednictwem dowolnego zakładu ubezpieczeń oferującego ubezpieczenia OC."},
        {"Czy przyczynienie się do wypadku wyklucza odszkodowanie?",
         "Nie wyklucza, ale może je obniżyć. Jeżeli poszkodowany przyczynił się do powstania lub zwiększenia szkody, obowiązek jej naprawienia ulega odpowiedniemu zmniejszeniu (art. 362 k.c.)."},
        {"Jakie roszczenia przysługują po śmierci osoby bliskiej?",
         "Zwrot kosztów leczenia i pogrzebu, renta dla osób, wobec których zmarły miał obowiązek alimentacyjny, odszkodowanie za znaczne pogorszenie sytuacji życiowej oraz zadośćuczynienie za krzywdę dla najbliższych członków rodziny (art. 446 k.c.)."}
      ]
    },
    "sprawy-spadkowe" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Kto dziedziczy z testamentu, a kto bez testamentu?",
         [
           "Spadek otwiera się z chwilą śmierci spadkodawcy. Jeżeli zmarły pozostawił ważny testament, dziedziczą osoby w nim wskazane; w braku testamentu — krąg spadkobierców określa ustawa. W pierwszej kolejności dziedziczą dzieci i małżonek spadkodawcy, w częściach równych, przy czym część przypadająca małżonkowi nie może być mniejsza niż jedna czwarta całości spadku (art. 931 § 1 k.c.). Gdy spadkodawca nie miał zstępnych, do spadku powołani są małżonek i rodzice.",
           "Testament można sporządzić własnoręcznie — w całości pismem ręcznym, z podpisem i datą — albo u notariusza. Wątpliwości co do jego ważności, na przykład co do stanu świadomości spadkodawcy, sąd bada w sprawie o stwierdzenie nabycia spadku."
         ]},
        {"Sąd czy notariusz — jak potwierdzić prawa do spadku?",
         [
           "Prawa do spadku można wykazać na dwa sposoby. Pierwszy to postanowienie sądu o stwierdzeniu nabycia spadku: wniosek składa się do sądu spadku, a opłata wynosi 100 zł oraz 5 zł za wpis do Rejestru Spadkowego. Drugi to akt poświadczenia dziedziczenia sporządzany przez notariusza — zwykle szybszy, ale wymagający jednoczesnej obecności i zgody wszystkich osób, które mogą wchodzić w rachubę jako spadkobiercy.",
           "Droga sądowa jest konieczna, gdy spadkobiercy pozostają w sporze, nie da się zebrać wszystkich u notariusza albo podważana jest ważność testamentu. Samo stwierdzenie nabycia spadku nie dzieli jeszcze majątku — ustala jedynie, kto i w jakim ułamku dziedziczy."
         ]},
        {"Jak przyjąć lub odrzucić spadek z długami?",
         [
           "Spadkobierca dziedziczy nie tylko majątek, ale i długi. Oświadczenie o przyjęciu lub odrzuceniu spadku składa się przed sądem lub notariuszem w terminie sześciu miesięcy. Przyjęcie z dobrodziejstwem inwentarza ogranicza odpowiedzialność za długi do wartości ustalonego w wykazie albo spisie inwentarza stanu czynnego spadku (art. 1031 § 2 k.c.).",
           "Spadkobierca, który odrzucił spadek, jest traktowany tak, jakby nie dożył otwarcia spadku — jego udział przypada wówczas jego zstępnym. Dlatego po odrzuceniu zadłużonego spadku przez rodzica trzeba zwykle zadbać o odrzucenie go także w imieniu dzieci. Od 15 listopada 2023 r. w typowej sytuacji tego rodzaju zezwolenie sądu opiekuńczego nie jest wymagane, o ile spełnione są warunki z art. 101 § 4 Kodeksu rodzinnego i opiekuńczego — między innymi zgodne działanie rodziców."
         ]},
        {"Co przysługuje osobie pominiętej w testamencie?",
         [
           "Najbliżsi spadkodawcy — zstępni, małżonek i rodzice — którzy zostali pominięci w testamencie albo przy darowiznach, mogą żądać od spadkobierców zapłaty zachowku. Jest to roszczenie pieniężne, a nie udział w majątku spadkowym, i przedawnia się z upływem pięciu lat.",
           "Wysokość zachowku, doliczanie darowizn, wydziedziczenie i przebieg sprawy opisujemy na osobnej stronie: [zachowek — adwokat w Gdańsku](/uslugi/zachowek)."
         ]},
        {"Co zrobić, gdy testament budzi wątpliwości?",
         [
           "Testament jest nieważny między innymi wtedy, gdy został sporządzony w stanie wyłączającym świadome albo swobodne powzięcie decyzji i wyrażenie woli, pod wpływem błędu albo groźby (art. 945 § 1 k.c.). Na nieważność testamentu z tych przyczyn nie można się powołać po upływie trzech lat od dnia, w którym osoba mająca w tym interes dowiedziała się o przyczynie nieważności, a w każdym razie po upływie dziesięciu lat od otwarcia spadku.",
           "Zarzuty wobec testamentu podnosi się w sprawie o stwierdzenie nabycia spadku. Sąd może wtedy dopuścić dowód z dokumentacji medycznej spadkodawcy, zeznań świadków oraz opinii biegłych — psychiatry albo grafologa. Kto znalazł testament, ma obowiązek złożyć go w sądzie spadku."
         ]},
        {"Jak podzielić spadek między spadkobierców?",
         [
           "Do działu spadku spadkobiercy są współwłaścicielami całego majątku spadkowego w ułamkach. Dział można przeprowadzić umownie — w formie aktu notarialnego, jeżeli w skład spadku wchodzi nieruchomość — albo przed sądem. Opłata od wniosku o dział spadku wynosi 500 zł, a przy zgodnym projekcie działu 300 zł; gdy dział ma być połączony ze zniesieniem współwłasności — odpowiednio 1 000 zł i 600 zł.",
           "Sąd może podzielić majątek fizycznie, przyznać poszczególne składniki jednemu ze spadkobierców z obowiązkiem spłaty pozostałych albo zarządzić sprzedaż. Rozlicza też darowizny otrzymane od spadkodawcy oraz nakłady i spłacone długi spadkowe. Spory o nieruchomości wchodzące w skład spadku opisujemy szerzej na stronie o [sprawach o nieruchomości](/uslugi/nieruchomosci)."
         ]},
        {"Jak wygląda sprawa spadkowa krok po kroku?",
         [
           {:list,
            [
              "Ustalenie kręgu spadkobierców, treści testamentu oraz składu majątku i długów.",
              "Sprawdzenie terminów — przede wszystkim sześciu miesięcy na oświadczenie o przyjęciu lub odrzuceniu spadku.",
              "Stwierdzenie nabycia spadku przed sądem albo przygotowanie do wizyty u notariusza.",
              "Dział spadku — w drodze umowy, ugody albo postępowania sądowego."
            ]},
           "Po analizie dokumentów przedstawiamy możliwe rozwiązania, przewidywany czas trwania postępowania oraz jego koszty."
         ]}
      ],
      documents: [
        "odpis aktu zgonu spadkodawcy",
        "odpisy aktów urodzenia i małżeństwa spadkobierców",
        "testament, jeżeli został sporządzony",
        "numery ksiąg wieczystych i dokumenty dotyczące majątku spadkowego",
        "umowy kredytów, pisma wierzycieli i inne informacje o długach",
        "umowy darowizn dokonanych przez spadkodawcę",
        "wcześniejsze postanowienia sądu lub akt poświadczenia dziedziczenia",
        "informacja o ostatnim miejscu zamieszkania spadkodawcy"
      ],
      faq: [
        {"Ile kosztuje stwierdzenie nabycia spadku w sądzie?",
         "Opłata od wniosku wynosi 100 zł, a za wpis do Rejestru Spadkowego dolicza się 5 zł. U notariusza zamiast opłaty sądowej płaci się taksę notarialną za akt poświadczenia dziedziczenia."},
        {"Jak nie odziedziczyć długów?",
         "Spadek można odrzucić w ciągu sześciu miesięcy od dnia, w którym spadkobierca dowiedział się o tytule swojego powołania. Brak oświadczenia oznacza przyjęcie spadku z dobrodziejstwem inwentarza, czyli odpowiedzialność za długi ograniczoną do wartości stanu czynnego spadku."},
        {"Czym różni się stwierdzenie nabycia spadku od działu spadku?",
         "Stwierdzenie nabycia spadku ustala, kto dziedziczy i w jakim ułamku. Dział spadku rozstrzyga, które konkretne składniki majątku przypadają poszczególnym spadkobiercom i jakie spłaty się im należą."},
        {"Ile wynosi opłata od wniosku o dział spadku?",
         "500 zł, a jeżeli wniosek zawiera zgodny projekt działu spadku — 300 zł. Gdy dział spadku jest połączony ze zniesieniem współwłasności, opłata wynosi 1 000 zł, a przy zgodnym projekcie 600 zł."}
      ]
    },
    "nieruchomosci" => %{
      updated: ~D[2026-11-23],
      lead: ["milena-kraluk", "michal-kurkierewicz"],
      sections: [
        {"Jak znieść współwłasność nieruchomości?",
         [
           "Każdy ze współwłaścicieli może żądać zniesienia współwłasności (art. 210 k.c.), a roszczenie to nie ulega przedawnieniu. Jeżeli współwłaściciele są zgodni, wystarczy umowa w formie aktu notarialnego. W braku porozumienia o sposobie zniesienia współwłasności rozstrzyga sąd, który może:",
           {:list,
            [
              "podzielić nieruchomość fizycznie — na przykład wydzielić odrębne działki lub lokale,",
              "przyznać ją jednemu ze współwłaścicieli z obowiązkiem spłaty pozostałych,",
              "zarządzić sprzedaż i podział uzyskanej kwoty."
            ]},
           "Opłata od wniosku o zniesienie współwłasności wynosi 1 000 zł, a gdy wniosek zawiera zgodny projekt — 300 zł. W tym samym postępowaniu sąd rozlicza nakłady na nieruchomość i pożytki, które pobierał tylko jeden ze współwłaścicieli."
         ]},
        {"Co trzeba wykazać, żeby zasiedzieć nieruchomość?",
         [
           "Zasiedzenie wymaga posiadania samoistnego, czyli władania nieruchomością tak jak właściciel: samodzielnego decydowania o niej, ponoszenia ciężarów, ogrodzenia, zabudowy czy opłacania podatku. Korzystanie z cudzej nieruchomości za zgodą właściciela — na przykład na podstawie użyczenia lub dzierżawy — nie prowadzi do zasiedzenia.",
           "Do własnego czasu posiadania można doliczyć czas posiadania poprzednika, w tym spadkodawcy (art. 176 k.c.). Bieg zasiedzenia przerywa między innymi wytoczenie przez właściciela powództwa o wydanie nieruchomości. Opłata od wniosku o stwierdzenie zasiedzenia nieruchomości wynosi 2 000 zł.",
           "Służebność gruntową można nabyć przez zasiedzenie tylko wtedy, gdy polega ona na korzystaniu z trwałego i widocznego urządzenia (art. 292 k.c.) — na przykład utwardzonej drogi."
         ]},
        {"Jak uzyskać drogę konieczną albo wynagrodzenie za słupy i rury na działce?",
         [
           "Właściciel nieruchomości, która nie ma odpowiedniego dostępu do drogi publicznej, może żądać od właścicieli gruntów sąsiednich ustanowienia za wynagrodzeniem służebności drogi koniecznej (art. 145 k.c.). Sąd wyznacza jej przebieg z uwzględnieniem potrzeb nieruchomości pozbawionej dostępu i z najmniejszym obciążeniem gruntów, przez które droga ma prowadzić.",
           "Jeżeli przez działkę przebiegają linie energetyczne, gazociąg lub wodociąg należące do przedsiębiorcy, właściciel może żądać ustanowienia służebności przesyłu za odpowiednim wynagrodzeniem (art. 305² k.c.). Te sprawy — w tym skutki wyroku Trybunału Konstytucyjnego z 2 grudnia 2025 r. — opisujemy na osobnej stronie: [służebność przesyłu — adwokat w Gdańsku](/uslugi/sluzebnosc-przesylu)."
         ]},
        {"Jak odzyskać nieruchomość i zapłatę za bezumowne korzystanie?",
         [
           "Właściciel może żądać wydania nieruchomości od osoby, która włada nią bez tytułu prawnego (art. 222 § 1 k.c.). Roszczenie o wydanie nieruchomości nie przedawnia się. Obok niego właścicielowi mogą przysługiwać roszczenia uzupełniające: o wynagrodzenie za korzystanie z rzeczy, o zwrot pożytków oraz o naprawienie szkody z powodu jej pogorszenia — ich zakres zależy od dobrej lub złej wiary posiadacza.",
           "Roszczenia te przedawniają się z upływem roku od dnia zwrotu rzeczy (art. 229 k.c.), a niezależnie od tego obowiązują ogólne terminy przedawnienia. Posiadacz może z kolei żądać rozliczenia nakładów poczynionych na nieruchomość."
         ]},
        {"Co zrobić, gdy księga wieczysta nie zgadza się ze stanem prawnym?",
         [
           "Treść księgi wieczystej chroni nabywcę: kto w dobrej wierze odpłatnie nabywa nieruchomość od osoby wpisanej jako właściciel, co do zasady staje się właścicielem, nawet jeżeli wpis był niezgodny z rzeczywistym stanem prawnym (rękojmia wiary publicznej ksiąg wieczystych). Dlatego niezgodności nie warto zostawiać bez reakcji.",
           "Osoba, której prawo nie jest wpisane lub jest wpisane błędnie, może żądać usunięcia niezgodności w drodze powództwa o uzgodnienie treści księgi wieczystej z rzeczywistym stanem prawnym (art. 10 ustawy o księgach wieczystych i hipotece), a na czas procesu — wpisu ostrzeżenia, które wyłącza działanie rękojmi."
         ]},
        {"Jak wygląda analiza sprawy krok po kroku?",
         [
           {:list,
            [
              "Analiza księgi wieczystej, dokumentów własności i dokumentacji geodezyjnej.",
              "Ustalenie stanu faktycznego — kto, od kiedy i w jaki sposób korzysta z nieruchomości.",
              "Próba rozwiązania polubownego: umowa, ugoda albo mediacja.",
              "Wniosek lub pozew i reprezentacja przed sądem, w tym udział w oględzinach i czynnościach biegłych."
            ]},
           "W sprawach działowych czy dotyczących ustanowienia służebności sąd zwykle korzysta z opinii biegłego geodety lub rzeczoznawcy majątkowego, co wpływa na czas i koszty postępowania — omawiamy je przed podjęciem działań."
         ]}
      ],
      documents: [
        "numer księgi wieczystej lub jej odpis",
        "wypis i wyrys z ewidencji gruntów i budynków",
        "akty notarialne, umowy i orzeczenia dotyczące nieruchomości",
        "mapy, szkice i inna dokumentacja geodezyjna",
        "decyzje podatkowe i potwierdzenia zapłaty podatku od nieruchomości",
        "rachunki i faktury dokumentujące nakłady",
        "dane świadków, którzy znają historię korzystania z nieruchomości",
        "korespondencja z drugą stroną sporu"
      ],
      faq: [
        {"Ile kosztuje wniosek o stwierdzenie zasiedzenia nieruchomości?",
         "Opłata sądowa od wniosku wynosi 2 000 zł. Do kosztów postępowania mogą dojść wydatki na opinię biegłego, na przykład geodety."},
        {"Czy współwłaściciel może wymusić sprzedaż lub podział nieruchomości?",
         "Każdy współwłaściciel może żądać zniesienia współwłasności. Jeżeli współwłaściciele nie dojdą do porozumienia, sąd dzieli nieruchomość fizycznie, przyznaje ją jednemu z nich ze spłatą pozostałych albo zarządza sprzedaż."},
        {"Ile wynosi opłata od wniosku o zniesienie współwłasności?",
         "1 000 zł, a jeżeli wniosek zawiera zgodny projekt zniesienia współwłasności — 300 zł."},
        {"Czy można żądać zapłaty za korzystanie z nieruchomości bez umowy?",
         "Tak. Właścicielowi może przysługiwać wynagrodzenie za bezumowne korzystanie z nieruchomości, zależnie od dobrej lub złej wiary posiadacza. Roszczenie to przedawnia się z upływem roku od dnia zwrotu nieruchomości."},
        {"Co zrobić, gdy działka nie ma dostępu do drogi publicznej?",
         "Można żądać od właścicieli gruntów sąsiednich ustanowienia służebności drogi koniecznej za wynagrodzeniem — w umowie albo przed sądem (art. 145 k.c.)."},
        {"Co zrobić, gdy wpis w księdze wieczystej jest nieprawidłowy?",
         "Można wytoczyć powództwo o uzgodnienie treści księgi wieczystej z rzeczywistym stanem prawnym i wnosić o wpis ostrzeżenia, które na czas procesu wyłącza działanie rękojmi wiary publicznej ksiąg wieczystych."}
      ]
    },
    "sprawy-o-zaplate" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Co zrobić, zanim sprawa trafi do sądu?",
         [
           "Pierwszym krokiem jest zwykle wezwanie do zapłaty z wyznaczonym terminem. Nie jest ono formalnym warunkiem wniesienia pozwu, ale w pozwie trzeba podać, czy strony podjęły próbę mediacji lub innego pozasądowego sposobu rozwiązania sporu, a jeżeli nie — wyjaśnić przyczyny (art. 187 § 1 pkt 3 k.p.c.). Wezwanie pozwala też jednoznacznie ustalić datę, od której dłużnik pozostaje w opóźnieniu.",
           "Za czas opóźnienia wierzyciel może żądać odsetek, choćby nie poniósł żadnej szkody (art. 481 § 1 k.c.). Przed wniesieniem pozwu sprawdzamy także, czy roszczenie nie jest przedawnione i jakimi dowodami można je wykazać."
         ]},
        {"Jaka jest opłata sądowa od pozwu o zapłatę?",
         [
           "Opłata od pozwu zależy od wartości przedmiotu sporu (art. 13 ustawy o kosztach sądowych w sprawach cywilnych):",
           {:list,
            [
              "do 500 zł — 30 zł,",
              "ponad 500 zł do 1 500 zł — 100 zł,",
              "ponad 1 500 zł do 4 000 zł — 200 zł,",
              "ponad 4 000 zł do 7 500 zł — 400 zł,",
              "ponad 7 500 zł do 10 000 zł — 500 zł,",
              "ponad 10 000 zł do 15 000 zł — 750 zł,",
              "ponad 15 000 zł do 20 000 zł — 1 000 zł,",
              "ponad 20 000 zł — 5% wartości, nie więcej niż 200 000 zł."
            ]},
           "Strona przegrywająca co do zasady zwraca przeciwnikowi koszty procesu, w tym opłatę od pozwu i koszty zastępstwa procesowego. Osoba, której nie stać na poniesienie kosztów, może wnosić o zwolnienie od nich."
         ]},
        {"Dostałem nakaz zapłaty — co to oznacza?",
         [
           "W wielu sprawach o zapłatę sąd wydaje nakaz zapłaty bez rozprawy, wyłącznie na podstawie twierdzeń i dokumentów powoda. W postępowaniu upominawczym pozwany może wnieść sprzeciw — jest on wolny od opłat, a nakaz traci moc w zaskarżonej części i sprawa trafia na rozprawę.",
           "Nakaz w postępowaniu nakazowym sąd wydaje, gdy roszczenie wynika na przykład z weksla, czeku, dokumentu urzędowego albo z pisemnego uznania długu. Pozwany wnosi wtedy zarzuty, od których pobiera się trzy czwarte opłaty od pozwu, a sam nakaz już z chwilą wydania stanowi tytuł zabezpieczenia.",
           "W obu trybach termin na zaskarżenie nakazu doręczonego w kraju wynosi dwa tygodnie. Sprzeciw lub zarzuty muszą od razu wskazywać, czy nakaz jest zaskarżany w całości, czy w części, oraz zawierać zarzuty i dowody na ich poparcie."
         ]},
        {"Czym jest e-sąd i elektroniczne postępowanie upominawcze?",
         [
           "Roszczeń pieniężnych można dochodzić także przez internet, w elektronicznym postępowaniu upominawczym prowadzonym przez Sąd Rejonowy Lublin-Zachód w Lublinie. Opłata wynosi 1,25% dochodzonej kwoty, nie mniej niż 30 zł, a do pozwu nie dołącza się dowodów — jedynie się je opisuje. W tym trybie można dochodzić roszczeń, które stały się wymagalne w ciągu trzech lat przed wniesieniem pozwu.",
           "Wniesienie sprzeciwu od elektronicznego nakazu zapłaty powoduje umorzenie postępowania w zakresie, w którym nakaz utracił moc. Powód może wtedy wnieść pozew do sądu właściwego według zasad ogólnych; jeżeli zrobi to w ciągu trzech miesięcy, zachowuje skutki wniesienia pierwszego pozwu, w tym przerwanie biegu przedawnienia."
         ]},
        {"Jak bronić się przed żądaniem zapłaty?",
         [
           "Otrzymanie nakazu zapłaty nie przesądza, że roszczenie jest zasadne — sąd wydał go bez wysłuchania pozwanego. Najczęstsze zarzuty to:",
           {:list,
            [
              "przedawnienie roszczenia,",
              "spełnienie świadczenia w całości lub w części,",
              "brak wykazania, że wierzytelność istnieje lub przeszła na powoda — typowe w sprawach z powództwa firm windykacyjnych i funduszy,",
              "niedozwolone postanowienia umowne, na przykład zawyżone opłaty i prowizje w umowie pożyczki."
            ]},
           "W sprawach przeciwko konsumentowi sąd bada przedawnienie z urzędu: po upływie terminu przedawnienia nie można domagać się zaspokojenia roszczenia przysługującego przeciwko konsumentowi (art. 117 § 2¹ k.c.). Jeżeli nakaz zapłaty doręczono na nieaktualny adres, w grę wchodzi zakwestionowanie skuteczności doręczenia albo wniosek o przywrócenie terminu, który składa się w ciągu tygodnia od ustania przyczyny uchybienia."
         ]},
        {"Co dalej po prawomocnym wyroku lub nakazie?",
         [
           "Prawomocne orzeczenie sądu nie gwarantuje jeszcze zapłaty. Jeżeli dłużnik nie płaci dobrowolnie, wierzyciel uzyskuje klauzulę wykonalności i kieruje wniosek do komornika. Etapy egzekucji opisujemy na stronie o [windykacji i egzekucji wierzytelności](/uslugi/egzekucja-wierzytelnosci)."
         ]}
      ],
      documents: [
        "umowa, zamówienie lub inny dokument, z którego wynika roszczenie",
        "faktury, rachunki i potwierdzenia przelewów",
        "wezwania do zapłaty i korespondencja z drugą stroną",
        "nakaz zapłaty lub pozew wraz z kopertą albo informacją o dacie doręczenia",
        "pisma od firmy windykacyjnej lub komornika",
        "pisemne uznanie długu albo ugoda, jeżeli zostały podpisane",
        "dane dłużnika: adres, PESEL lub NIP",
        "dowody wcześniejszych wpłat na poczet długu"
      ],
      faq: [
        {"Ile kosztuje pozew o zapłatę?",
         "Opłata zależy od dochodzonej kwoty: do 20 000 zł jest stała i wynosi od 30 zł do 1 000 zł, a powyżej tej kwoty — 5% wartości przedmiotu sporu, nie więcej niż 200 000 zł. W elektronicznym postępowaniu upominawczym opłata wynosi 1,25%, nie mniej niż 30 zł."},
        {"Czy sprzeciw od nakazu zapłaty jest płatny?",
         "Sprzeciw od nakazu zapłaty wydanego w postępowaniu upominawczym jest wolny od opłat. Od zarzutów od nakazu wydanego w postępowaniu nakazowym pobiera się trzy czwarte opłaty od pozwu."},
        {"Co zrobić, gdy termin na sprzeciw już minął?",
         "Jeżeli termin upłynął bez winy pozwanego, można złożyć wniosek o przywrócenie terminu — w ciągu tygodnia od ustania przyczyny uchybienia, razem ze sprzeciwem. Gdy nakaz doręczono na nieaktualny adres, można też kwestionować skuteczność doręczenia."},
        {"Czy sąd sam uwzględni przedawnienie długu?",
         "W sprawie przeciwko konsumentowi tak — sąd bada przedawnienie z urzędu. W pozostałych sprawach pozwany musi sam podnieść zarzut przedawnienia."},
        {"Czym jest elektroniczne postępowanie upominawcze?",
         "To tryb dochodzenia roszczeń pieniężnych przez internet, prowadzony przez Sąd Rejonowy Lublin-Zachód w Lublinie. Pozew składa się elektronicznie, bez dołączania dowodów, a po wniesieniu sprzeciwu postępowanie jest umarzane."},
        {"Czy trzeba wysłać wezwanie do zapłaty przed pozwem?",
         "Nie jest to formalny warunek, ale w pozwie trzeba podać, czy strony próbowały rozwiązać spór pozasądowo. Wezwanie pozwala też wykazać, od kiedy dłużnik jest w opóźnieniu."}
      ]
    },
    "sluzebnosc-przesylu" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Czym jest służebność przesyłu?",
         [
           "Służebność przesyłu to prawo przedsiębiorcy do korzystania z cudzej nieruchomości w oznaczonym zakresie, zgodnie z przeznaczeniem urządzeń przesyłowych: linii energetycznych, gazociągów, wodociągów, kanalizacji czy sieci ciepłowniczej (art. 305¹ Kodeksu cywilnego). Obejmuje nie tylko samo posadowienie urządzeń, ale też dostęp do nich w celu konserwacji, napraw i usuwania awarii.",
           "Służebność obciąża nieruchomość, a nie konkretnego właściciela — po sprzedaży działki wiąże nabywcę. Przechodzi też na każdego, kto nabędzie przedsiębiorstwo albo same urządzenia. Dlatego jej zakres warto ustalić precyzyjnie: szerokość pasa, przebieg i zasady wstępu na grunt."
         ]},
        {"Kiedy właścicielowi działki należy się wynagrodzenie?",
         [
           "Gdy przedsiębiorca korzysta z nieruchomości bez tytułu prawnego. Właściciel może wtedy żądać:",
           {:list,
            [
              "ustanowienia służebności przesyłu za odpowiednim wynagrodzeniem (art. 305² § 2 k.c.) — to rozliczenie na przyszłość,",
              "wynagrodzenia za bezumowne korzystanie z nieruchomości — za przeszłość, w granicach przedawnienia."
            ]},
           "Wynagrodzenie nie przysługuje, jeżeli przedsiębiorca dysponuje umową, służebnością ustanowioną wcześniej, decyzją administracyjną zezwalającą na założenie i utrzymywanie urządzeń albo prawomocnym orzeczeniem stwierdzającym zasiedzenie. Takie decyzje wydawano także kilkadziesiąt lat temu i wiążą one kolejnych właścicieli, dlatego sprawę zaczyna się od ustalenia, na jakiej podstawie urządzenia znalazły się na działce."
         ]},
        {"Co zmienił wyrok Trybunału Konstytucyjnego P 10/16?",
         [
           "Służebność przesyłu istnieje w Kodeksie cywilnym od 3 sierpnia 2008 r. Sądy przyjmowały jednak, że przedsiębiorstwa mogły wcześniej zasiedzieć służebność gruntową o treści odpowiadającej służebności przesyłu — i na tej podstawie oddalały żądania właścicieli działek, na których urządzenia stały od dziesięcioleci.",
           "Wyrokiem z 2 grudnia 2025 r. Trybunał Konstytucyjny orzekł, że art. 292 w związku z art. 285 § 1 i 2 k.c., rozumiane jako podstawa nabycia takiej służebności przez zasiedzenie przed 3 sierpnia 2008 r., są niezgodne z Konstytucją. Wyrok nie wyłącza zasiedzenia służebności przesyłu, którego bieg rozpoczął się od tej daty — przy dwudziesto- lub trzydziestoletnim terminie zasiedzenia nieuregulowany stan prawny z czasem znów zacznie działać na korzyść przedsiębiorcy."
         ]},
        {"Ile wynosi wynagrodzenie za służebność przesyłu?",
         [
           "Nie ma stawek ustawowych ani ceny za metr. Wynagrodzenie ma odpowiadać temu, w jakim stopniu służebność ogranicza prawo własności; w sporze sądowym ustala je biegły rzeczoznawca majątkowy. Pod uwagę bierze się:",
           {:list,
            [
              "powierzchnię pasa służebności, a nie tylko grunt zajęty przez słup,",
              "rodzaj i parametry urządzeń, na przykład napięcie linii,",
              "przeznaczenie działki i jej wartość rynkową,",
              "ograniczenia w zabudowie i w sposobie korzystania z gruntu,",
              "obniżenie wartości całej nieruchomości."
            ]},
           "Wynagrodzenie jest co do zasady jednorazowe, choć strony mogą umówić się na świadczenia okresowe. Różnice między sprawami są bardzo duże, dlatego przed wezwaniem operatora warto mieć realistyczną wycenę."
         ]},
        {"Jak ustanowić służebność przesyłu — umowa czy sąd?",
         [
           "Służebność można ustanowić umową z przedsiębiorcą; oświadczenie właściciela nieruchomości wymaga formy aktu notarialnego. Wpis do księgi wieczystej nie jest warunkiem powstania służebności, ale porządkuje stan prawny i jest widoczny dla przyszłych nabywców.",
           "Jeżeli przedsiębiorca odmawia zawarcia umowy albo proponuje symboliczną kwotę, właściciel może złożyć wniosek o ustanowienie służebności do sądu rejonowego właściwego dla miejsca położenia nieruchomości. Opłata od wniosku wynosi 100 zł. Sąd określa zakres służebności i wysokość wynagrodzenia na podstawie opinii biegłych. Z takim samym wnioskiem może wystąpić przedsiębiorca, gdy to właściciel odmawia uregulowania stanu prawnego."
         ]},
        {"Za ile lat wstecz można żądać zapłaty?",
         [
           "Wynagrodzenie za bezumowne korzystanie z nieruchomości przedawnia się na zasadach ogólnych — co do zasady po sześciu latach, a w przypadku roszczeń związanych z prowadzeniem działalności gospodarczej po trzech latach (art. 118 k.c.). Zapłaty można więc dochodzić za ostatnie lata, a nie za cały czas istnienia urządzeń.",
           "Bieg przedawnienia przerywa wniesienie pozwu, a nie samo wezwanie do zapłaty. Z każdym rokiem zwłoki przepada wynagrodzenie za kolejny rok. Opłata od pozwu o wynagrodzenie za bezumowne korzystanie zależy od wartości przedmiotu sporu, czyli od dochodzonej kwoty."
         ]},
        {"Co zrobić, gdy sprawa została już prawomocnie przegrana?",
         [
           "Kodeks postępowania cywilnego wyklucza wystąpienie z wnioskiem po upływie 10 lat od uprawomocnienia się wyroku.",
           "Wyrok Trybunału nie został ogłoszony w Dzienniku Ustaw, co rodzi wątpliwości co do jego skutków i biegu terminu na wniesienie skargi. W dniu 18 listopada 2026 r. Sąd Najwyższy wydał uchwałę, w której przesądził, że wyrok TK obowiązuje od momentu jego wydania, a skargę można rozpoznać przed publikacją wyroku w Dzienniku Ustaw (III CZP 41/26). Jest to istotna kwestia przy badaniu podstaw zasadności skargi, dlatego analizę warto zlecić niezwłocznie."
         ]},
        {"Jak prowadzimy sprawę o służebność przesyłu?",
         [
           {:list,
            [
              "Analiza księgi wieczystej, dokumentów nabycia działki i mapy z przebiegiem urządzeń.",
              "Wystąpienie do operatora o wskazanie tytułu prawnego do korzystania z nieruchomości.",
              "Wstępna wycena wynagrodzenia i wezwanie do zawarcia umowy oraz zapłaty.",
              "Wniosek do sądu o ustanowienie służebności i pozew o wynagrodzenie za bezumowne korzystanie."
            ]},
           "Po analizie dokumentów mówimy wprost, czy roszczenie ma szanse powodzenia, jakiej kwoty można się spodziewać i z jakimi kosztami — w tym opinii biegłego — należy się liczyć."
         ]}
      ],
      documents: [
        "numer księgi wieczystej nieruchomości",
        "akt notarialny lub inny dokument nabycia działki",
        "mapa albo szkic z przebiegiem linii i lokalizacją słupów",
        "wypis z rejestru gruntów oraz plan miejscowy lub decyzja o warunkach zabudowy",
        "pisma i decyzje administracyjne dotyczące urządzeń, także sprzed lat",
        "korespondencja z operatorem sieci",
        "zdjęcia urządzeń i terenu",
        "wcześniejsze orzeczenia sądu w sprawie służebności lub zasiedzenia"
      ],
      faq: [
        {"Ile można dostać za służebność przesyłu?",
         "Nie ma stawek ani ceny za metr. Wynagrodzenie zależy od powierzchni pasa służebności, rodzaju urządzeń, przeznaczenia działki i tego, jak bardzo ograniczają one zabudowę; w sądzie ustala je biegły rzeczoznawca."},
        {"Czy wynagrodzenie za służebność przesyłu jest jednorazowe czy okresowe?",
         "Co do zasady jednorazowe. Strony mogą jednak umówić się na wynagrodzenie płatne okresowo."},
        {"Czy służebność przesyłu można zasiedzieć?",
         "Tak, jeżeli przedsiębiorca korzysta z trwałego i widocznego urządzenia przez dwadzieścia lat w dobrej wierze albo trzydzieści lat w złej wierze. Trybunał Konstytucyjny zakwestionował natomiast zasiedzenie służebności o takiej treści przed 3 sierpnia 2008 r."},
        {"Jak sprawdzić, czy na działce jest służebność przesyłu?",
         "W dziale III księgi wieczystej. Brak wpisu nie oznacza jednak, że przedsiębiorca nie ma tytułu prawnego — może nim być umowa albo dawna decyzja administracyjna, dlatego warto zwrócić się z pytaniem do operatora sieci."},
        {"Czy służebność przesyłu musi być wpisana do księgi wieczystej?",
         "Nie. Służebność powstaje na podstawie umowy albo orzeczenia sądu, a wpis jedynie ją ujawnia. Wpis jest jednak zalecany, bo porządkuje stan prawny nieruchomości."},
        {"Czy ustanowienie służebności przesyłu wymaga aktu notarialnego?",
         "Oświadczenie właściciela nieruchomości o ustanowieniu służebności wymaga formy aktu notarialnego. Aktu nie potrzeba, gdy służebność ustanawia sąd."},
        {"Czy służebność przesyłu przechodzi na nowego właściciela działki?",
         "Tak. Służebność obciąża nieruchomość, więc wiąże każdego kolejnego właściciela. Dlatego przed zakupem działki warto sprawdzić jej zakres."},
        {"Do kiedy można żądać wynagrodzenia za słupy na działce?",
         "Wynagrodzenia za bezumowne korzystanie można dochodzić za okres nieobjęty przedawnieniem — co do zasady sześć lat wstecz. Z żądaniem ustanowienia służebności nie warto zwlekać, ponieważ od 3 sierpnia 2008 r. biegnie termin jej zasiedzenia."},
        {"Czy można postawić słup na działce bez zgody właściciela?",
         "Przedsiębiorca potrzebuje tytułu prawnego: umowy, służebności albo decyzji administracyjnej ograniczającej sposób korzystania z nieruchomości. Urządzenia posadowione bez takiego tytułu uprawniają właściciela do żądania wynagrodzenia."},
        {"Czy za gazociąg lub wodociąg na działce też należy się wynagrodzenie?",
         "Tak. Służebność przesyłu dotyczy wszystkich urządzeń służących do doprowadzania lub odprowadzania płynów, pary, gazu i energii elektrycznej, o ile należą do przedsiębiorcy."},
        {"Ile kosztuje sprawa sądowa o służebność przesyłu?",
         "Opłata od wniosku o ustanowienie służebności przesyłu wynosi 100 zł. Opłata od pozwu o wynagrodzenie za bezumowne korzystanie z nieruchomości zależy od wartości przedmiotu sporu. Do kosztów postępowania dochodzą wydatki na opinię biegłego."},
        {"Kto płaci za ustanowienie służebności przesyłu?",
         "Wynagrodzenie płaci przedsiębiorca, na którego rzecz służebność jest ustanawiana. Podział kosztów notarialnych ustalają strony w umowie, a o kosztach postępowania sądowego rozstrzyga sąd."},
        {"Czy służebność przesyłu obniża wartość nieruchomości?",
         "Może ją obniżać, zwłaszcza gdy urządzenia ograniczają możliwość zabudowy. Obniżenie wartości nieruchomości uwzględnia się przy ustalaniu wynagrodzenia."}
      ]
    },
    "prawa-konsumentow" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Reklamacja czy gwarancja — z czego skorzystać?",
         [
           "Konsument ma do dyspozycji dwie niezależne podstawy. Pierwsza to ustawowa odpowiedzialność sprzedawcy za brak zgodności towaru z umową — obejmuje braki, które istniały w chwili dostarczenia towaru i ujawniły się w ciągu dwóch lat. Druga to gwarancja: dobrowolne zobowiązanie, najczęściej producenta, którego zakres i czas trwania wynikają z dokumentu gwarancyjnego.",
           "Wybór należy do konsumenta, a skorzystanie z gwarancji nie odbiera uprawnień wobec sprzedawcy. Reklamacja kierowana do sprzedawcy bywa korzystniejsza, bo jej zasady określa ustawa, a nie warunki ustalone przez gwaranta."
         ]},
        {"Jak złożyć reklamację, żeby była skuteczna?",
         [
           "Reklamację składa się sprzedawcy, a nie producentowi. Przepisy nie narzucają formy, ale najbezpieczniej zrobić to na piśmie albo e-mailem, tak aby mieć dowód daty i treści zgłoszenia. W reklamacji warto wskazać:",
           {:list,
            [
              "co zostało kupione, kiedy i za jaką cenę,",
              "na czym polega brak zgodności towaru z umową i kiedy się ujawnił,",
              "czego konsument żąda — naprawy albo wymiany,",
              "termin na odpowiedź i sposób kontaktu."
            ]},
           "Sprzedawca ma 14 dni na odpowiedź, a jej brak oznacza uznanie reklamacji. Naprawa lub wymiana powinna nastąpić w rozsądnym czasie i bez nadmiernych niedogodności dla konsumenta; koszty z nią związane, w tym koszty transportu, ponosi sprzedawca."
         ]},
        {"Jak odstąpić od umowy zawartej przez internet i kto płaci za zwrot?",
         [
           "Termin 14 dni liczy się przy sprzedaży od objęcia towaru w posiadanie. Wystarczy wysłać sprzedawcy oświadczenie o odstąpieniu przed upływem terminu, a towar odesłać w ciągu kolejnych 14 dni. Sprzedawca zwraca wszystkie otrzymane płatności, w tym koszt najtańszego oferowanego sposobu dostawy, przy czym może wstrzymać się ze zwrotem do chwili otrzymania towaru albo dowodu jego odesłania.",
           "Bezpośrednie koszty odesłania towaru ponosi co do zasady konsument, chyba że sprzedawca zgodził się je pokryć albo nie poinformował o tym obowiązku. Jeżeli przedsiębiorca w ogóle nie poinformował o prawie odstąpienia, termin wydłuża się o dwanaście miesięcy. Prawo odstąpienia nie przysługuje między innymi przy towarach wyprodukowanych według specyfikacji konsumenta i szybko się psujących."
         ]},
        {"Co zrobić, gdy przedsiębiorca odmawia?",
         [
           "Pierwszym krokiem jest pisemne wezwanie z wyznaczonym terminem. Bezpłatnej pomocy udziela miejski lub powiatowy rzecznik konsumentów, a spór można też próbować zakończyć w mediacji prowadzonej przez Inspekcję Handlową.",
           "Gdy to nie pomaga, pozostaje pozew. Konsument może go wnieść do sądu właściwego dla swojego miejsca zamieszkania, a sprawy o roszczenia do 20 000 zł sąd rozpoznaje w postępowaniu uproszczonym. Przed wniesieniem pozwu oceniamy, czy roszczenie da się wykazać i czy koszty procesu pozostają w rozsądnej proporcji do jego wartości."
         ]}
      ],
      documents: [
        "paragon, faktura albo potwierdzenie płatności",
        "umowa, regulamin sklepu lub potwierdzenie zamówienia",
        "pismo reklamacyjne i odpowiedź przedsiębiorcy",
        "korespondencja ze sprzedawcą lub usługodawcą",
        "zdjęcia lub nagrania pokazujące wadę",
        "dokument gwarancyjny, jeżeli został wydany",
        "opinia rzeczoznawcy lub serwisu, jeżeli była sporządzona"
      ]
    },
    "prawo-karne" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Kim jest pokrzywdzony i jakie ma prawa w śledztwie?",
         [
           "Pokrzywdzonym jest osoba fizyczna lub prawna, której dobro prawne zostało bezpośrednio naruszone lub zagrożone przez przestępstwo. W postępowaniu przygotowawczym — śledztwie lub dochodzeniu — pokrzywdzony jest stroną. Oznacza to, że może:",
           {:list,
            [
              "składać wnioski o przeprowadzenie dowodów, na przykład o przesłuchanie świadka lub zabezpieczenie nagrań,",
              "brać udział w czynnościach, których nie da się powtórzyć na rozprawie,",
              "przeglądać akta za zgodą prowadzącego postępowanie,",
              "zaskarżać postanowienia o odmowie wszczęcia i o umorzeniu postępowania,",
              "działać przez pełnomocnika."
            ]},
           "Pokrzywdzony jest też zwykle najważniejszym świadkiem, dlatego do pierwszego przesłuchania warto się przygotować — uporządkować daty, dokumenty i listę osób, które coś widziały."
         ]},
        {"Co dzieje się po złożeniu zawiadomienia o przestępstwie?",
         [
           "Policja lub prokurator wydaje postanowienie o wszczęciu postępowania albo o odmowie jego wszczęcia. Jeżeli w ciągu sześciu tygodni od złożenia zawiadomienia pokrzywdzony nie zostanie o tym powiadomiony, może wnieść zażalenie do prokuratora nadrzędnego.",
           "Postępowanie kończy się skierowaniem aktu oskarżenia do sądu albo umorzeniem. Na postanowienie o umorzeniu i o odmowie wszczęcia przysługuje zażalenie do sądu, wnoszone w terminie siedmiu dni od doręczenia. Dobrze uzasadnione zażalenie wskazuje konkretne dowody, których nie przeprowadzono."
         ]},
        {"Co zrobić, gdy prokurator ponownie umorzy sprawę?",
         [
           "Jeżeli sąd uchylił pierwsze postanowienie o umorzeniu lub odmowie wszczęcia, a prokurator wydał je ponownie i utrzymał je w mocy prokurator nadrzędny, pokrzywdzony może sam wnieść do sądu akt oskarżenia — tak zwany subsydiarny akt oskarżenia.",
           "Ma na to miesiąc od doręczenia zawiadomienia o postanowieniu prokuratora nadrzędnego. Taki akt oskarżenia musi sporządzić i podpisać adwokat lub radca prawny. To rozwiązanie wyjątkowe, ale pozwala doprowadzić sprawę przed sąd wbrew stanowisku prokuratury."
         ]},
        {"Jak uzyskać naprawienie szkody od sprawcy?",
         [
           "W procesie karnym pokrzywdzony może złożyć wniosek o orzeczenie obowiązku naprawienia szkody lub zadośćuczynienia za doznaną krzywdę. W razie skazania sąd, uwzględniając wniosek, orzeka ten obowiązek w całości albo w części, a gdy jego orzeczenie jest znacznie utrudnione — może zasądzić nawiązkę.",
           "Porozumienie ze sprawcą można też wypracować w mediacji. Jeżeli wyrok karny nie pokrył całej szkody, pozostałej części dochodzi się w procesie cywilnym — piszemy o tym na stronie o [odszkodowaniach i zadośćuczynieniach](/uslugi/odszkodowania). Prawomocny wyrok skazujący wiąże sąd cywilny co do tego, że przestępstwo zostało popełnione."
         ]}
      ],
      documents: [
        "dokumentacja medyczna i zaświadczenie lekarskie o obrażeniach",
        "wiadomości, nagrania, zdjęcia i inne dowody zdarzenia",
        "dane świadków",
        "pisma i postanowienia otrzymane z policji lub prokuratury",
        "rachunki i faktury dokumentujące poniesioną szkodę",
        "kopie wcześniejszych zawiadomień i protokołów przesłuchań"
      ]
    },
    "obsluga-przedsiebiorcow" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Co obejmuje stała obsługa prawna firmy?",
         [
           "Zakres obsługi ustala się w umowie i dopasowuje do profilu działalności. Najczęściej obejmuje on:",
           {:list,
            [
              "bieżące konsultacje — telefoniczne, mailowe i na spotkaniach,",
              "przygotowanie i sprawdzanie umów z kontrahentami oraz udział w negocjacjach,",
              "opinie prawne przed ważnymi decyzjami i transakcjami,",
              "regulaminy, wzorce umów i dokumenty wewnętrzne,",
              "wezwania do zapłaty i odzyskiwanie należności,",
              "reprezentację w sporach sądowych i przed urzędami."
            ]},
           "Stała współpraca oznacza, że prawnik zna firmę, jej kontrahentów i wcześniejsze ustalenia — nie trzeba za każdym razem tłumaczyć kontekstu od początku."
         ]},
        {"Stała obsługa czy pojedyncze zlecenia — co wybrać?",
         [
           "Pojedyncze zlecenie wystarcza, gdy potrzeba prawna pojawia się rzadko: firma podpisuje jedną większą umowę w roku albo ma jeden spór. Stała obsługa jest uzasadniona, gdy pytania prawne pojawiają się regularnie — przy zawieraniu wielu umów, pracy na wzorcach kontrahentów, częstych opóźnieniach w płatnościach albo szybkim wzroście firmy.",
           "Przy stałej współpracy wiele problemów udaje się wychwycić, zanim powstaną: w projekcie umowy, w regulaminie lub w sposobie dokumentowania ustaleń z klientem. To zwykle tańsze niż późniejszy proces."
         ]},
        {"Jak rozlicza się obsługę prawną firmy?",
         [
           "W praktyce stosuje się trzy modele: miesięczny ryczałt obejmujący ustaloną liczbę godzin lub zakres spraw, rozliczenie według stawki godzinowej za faktycznie wykonaną pracę oraz wynagrodzenie ustalone z góry za konkretny projekt, na przykład przygotowanie kompletu wzorców umów.",
           "Model i zakres proponujemy po rozmowie o potrzebach firmy. Prowadzenie spraw sądowych bywa rozliczane odrębnie od bieżącej obsługi — warto to jednoznacznie zapisać w umowie."
         ]},
        {"Kiedy firma powinna skonsultować się z prawnikiem?",
         [
           {:list,
            [
              "przed podpisaniem umowy o istotnej wartości albo zawieranej na długi okres,",
              "gdy kontrahent przesyła własny wzorzec umowy lub ogólne warunki,",
              "gdy faktura nie została zapłacona mimo upływu terminu,",
              "po otrzymaniu wezwania do zapłaty, pozwu albo nakazu zapłaty,",
              "przy zmianie wspólników, zarządu lub formy prawnej działalności,",
              "przy wdrażaniu nowych narzędzi przetwarzających dane klientów."
            ]},
           "W wielu z tych sytuacji biegną terminy — na przykład dwa tygodnie na zaskarżenie nakazu zapłaty — dlatego dokumenty warto przekazać od razu po ich otrzymaniu."
         ]}
      ],
      documents: [
        "umowa spółki albo wpis w CEIDG",
        "najczęściej stosowane wzory umów i regulaminy",
        "ogólne warunki umów otrzymywane od kluczowych kontrahentów",
        "lista bieżących sporów i niezapłaconych należności",
        "korespondencja w sprawach wymagających pilnej reakcji"
      ]
    },
    "zakladanie-spolek" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jaką formę prawną wybrać?",
         [
           "Wybór zależy przede wszystkim od tego, kto ma odpowiadać za zobowiązania firmy i jak mają zapadać decyzje:",
           {:list,
            [
              "spółka cywilna — umowa między przedsiębiorcami, bez wpisu do KRS; wspólnicy odpowiadają solidarnie całym majątkiem,",
              "spółka jawna — spółka osobowa wpisywana do KRS; wspólnicy odpowiadają za jej zobowiązania subsydiarnie,",
              "spółka komandytowa — komplementariusz odpowiada bez ograniczeń, komandytariusz do wysokości sumy komandytowej,",
              "spółka z o.o. — wspólnicy nie odpowiadają za zobowiązania spółki; najczęstszy wybór dla małych i średnich firm,",
              "prosta spółka akcyjna — elastyczna struktura i kapitał akcyjny od 1 zł, często wybierana przez start-upy,",
              "spółka akcyjna — dla dużych przedsięwzięć, z kapitałem zakładowym co najmniej 100 000 zł."
            ]},
           "Znaczenie mają także podatki, koszty księgowości i plany pozyskania inwestora, dlatego decyzję warto skonsultować również z doradcą podatkowym."
         ]},
        {"S24 czy umowa u notariusza?",
         [
           "Rejestracja w systemie S24 jest szybsza i tańsza: umowę zawiera się przez internet na wzorcu, a podpisuje podpisem kwalifikowanym albo profilem zaufanym. Wzorzec dopuszcza jednak tylko wybrane warianty postanowień, a kapitał zakładowy można pokryć wyłącznie wkładami pieniężnymi, które trzeba wnieść najpóźniej w ciągu siedmiu dni od wpisu spółki.",
           "Umowa w formie aktu notarialnego pozwala swobodnie ukształtować zasady działania spółki i wnieść wkład niepieniężny, na przykład nieruchomość lub przedsiębiorstwo. Przy kilku wspólnikach o różnych rolach to zwykle lepsze rozwiązanie."
         ]},
        {"Co powinna regulować umowa spółki?",
         [
           "Poza elementami obowiązkowymi — firmą, siedzibą, przedmiotem działalności i kapitałem zakładowym — o przyszłości spółki decydują postanowienia dodatkowe:",
           {:list,
            [
              "zasady zbywania udziałów: zgoda spółki, prawo pierwszeństwa pozostałych wspólników,",
              "sposób reprezentacji i sprawy wymagające uchwały wspólników,",
              "większości głosów potrzebne do kluczowych decyzji,",
              "dopłaty i zasady podziału zysku,",
              "wstąpienie spadkobierców zmarłego wspólnika,",
              "rozwiązanie impasu decyzyjnego i wyjście wspólnika ze spółki."
            ]},
           "Tych kwestii nie reguluje wzorzec S24, a w razie konfliktu ich zmiana wymaga zgody wspólników, o którą bywa trudno."
         ]},
        {"Jakie obowiązki ma spółka po rejestracji?",
         [
           "Po wpisie do KRS spółka otrzymuje NIP i REGON automatycznie, ale pozostają do wykonania kolejne kroki: zgłoszenie beneficjentów rzeczywistych do CRBR w ciągu 14 dni, złożenie w urzędzie skarbowym danych uzupełniających, założenie rachunku bankowego, uzyskanie adresu do doręczeń elektronicznych oraz — w razie potrzeby — rejestracja do VAT.",
           "Spółka z o.o. prowadzi pełną księgowość, księgę udziałów i księgę protokołów, a co roku zatwierdza sprawozdanie finansowe. Bieżące formalności opisujemy na stronie o [obsłudze korporacyjnej](/uslugi/obsluga-korporacyjna)."
         ]}
      ],
      documents: [
        "dane wspólników i członków zarządu, w tym numery PESEL",
        "proponowana firma spółki i adres siedziby",
        "przedmiot działalności według PKD",
        "wysokość kapitału zakładowego i podział udziałów",
        "ustalenia wspólników co do reprezentacji i podejmowania decyzji",
        "opis wkładów niepieniężnych, jeżeli mają zostać wniesione"
      ]
    },
    "umowy" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Co powinna zawierać dobra umowa?",
         [
           {:list,
            [
              "dokładne oznaczenie stron i osób uprawnionych do ich reprezentacji,",
              "precyzyjny opis przedmiotu umowy — co, w jakim standardzie i w jakim terminie ma zostać wykonane,",
              "wynagrodzenie, terminy płatności i skutki opóźnienia,",
              "zasady odbioru i zgłaszania wad,",
              "odpowiedzialność stron, jej ograniczenia i kary umowne,",
              "warunki wypowiedzenia i odstąpienia od umowy,",
              "poufność, prawa autorskie i ochrona danych, jeżeli mają znaczenie,",
              "sposób rozstrzygania sporów i sąd właściwy."
            ]},
           "Wzór z internetu rzadko odpowiada na pytania, które pojawią się w konkretnej transakcji — a właśnie one decydują o wyniku ewentualnego sporu."
         ]},
        {"Jakie błędy w umowach najczęściej prowadzą do sporów?",
         [
           {:list,
            [
              "podpisanie umowy przez osobę, która nie mogła reprezentować kontrahenta,",
              "nieprecyzyjny opis zakresu prac, który każda ze stron rozumie inaczej,",
              "brak procedury odbioru i terminu na zgłoszenie zastrzeżeń,",
              "kary umowne zastrzeżone tylko dla jednej strony albo bez górnego limitu,",
              "ustalenia zmieniające umowę zawierane ustnie lub w wiadomościach, mimo zastrzeżenia formy pisemnej,",
              "brak postanowień o przeniesieniu praw autorskich do zamówionych materiałów."
            ]},
           "Większość z tych błędów da się usunąć jednym akapitem — pod warunkiem, że zostaną zauważone przed podpisaniem."
         ]},
        {"Jak wygląda sprawdzenie umowy przez adwokata?",
         [
           "Zaczynamy od rozmowy o celu transakcji: co jest dla Klienta najważniejsze, na czym mu zależy i z czego może zrezygnować. Następnie analizujemy projekt, oznaczamy postanowienia ryzykowne i proponujemy konkretne zmiany w treści — nie tylko ogólne uwagi.",
           "Na życzenie przygotowujemy stanowisko do negocjacji albo uczestniczymy w rozmowach z kontrahentem. Efektem jest umowa, w której Klient wie, jakie ryzyka przyjął świadomie, a które udało się wyeliminować."
         ]},
        {"Kiedy postanowienie umowy jest nieważne albo nie wiąże?",
         [
           "Nieważna jest czynność sprzeczna z ustawą albo z zasadami współżycia społecznego oraz czynność dokonana bez zachowania formy zastrzeżonej pod rygorem nieważności — na przykład sprzedaż nieruchomości bez aktu notarialnego. Umowa zawarta przez osobę bez umocowania wymaga potwierdzenia przez tego, w czyim imieniu została zawarta.",
           "W umowach z konsumentami nie wiążą postanowienia nieuzgodnione indywidualnie, które kształtują prawa konsumenta sprzecznie z dobrymi obyczajami i rażąco naruszają jego interesy. Tę ochronę stosuje się także do osoby fizycznej prowadzącej działalność gospodarczą, gdy umowa jest wprawdzie związana z jej firmą, ale nie ma dla niej charakteru zawodowego. Spory o takie postanowienia opisujemy na stronie o [ochronie praw konsumentów](/uslugi/prawa-konsumentow)."
         ]}
      ],
      documents: [
        "projekt umowy wraz z załącznikami",
        "ogólne warunki umów lub regulamin kontrahenta",
        "korespondencja, w której strony uzgadniały warunki",
        "dane stron z KRS albo CEIDG",
        "wcześniejsze umowy zawarte z tym samym kontrahentem",
        "opis celu transakcji i warunków najważniejszych dla Klienta"
      ]
    },
    "egzekucja-wierzytelnosci" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jak krok po kroku odzyskać należność od kontrahenta?",
         [
           {:list,
            [
              "Wezwanie do zapłaty — z terminem, numerem rachunku i wyliczeniem odsetek oraz rekompensaty.",
              "Pozew — w miarę możliwości w postępowaniu upominawczym, nakazowym albo elektronicznym, tak aby szybko uzyskać nakaz zapłaty.",
              "Klauzula wykonalności — po uprawomocnieniu się nakazu lub wyroku.",
              "Wniosek do komornika — ze wskazaniem znanych składników majątku dłużnika.",
              "Dalsze działania, gdy egzekucja jest bezskuteczna — poszukiwanie majątku i odpowiedzialność osób trzecich."
            ]},
           "Na każdym etapie można zawrzeć ugodę. Warto wtedy uzyskać pisemne uznanie długu: ułatwia ono późniejszy proces i przerywa bieg przedawnienia."
         ]},
        {"Jak sprawdzić kontrahenta i jego majątek?",
         [
           "Podstawowe informacje są jawne i bezpłatne. W KRS i CEIDG widać formę prawną, reprezentację i status firmy. Krajowy Rejestr Zadłużonych ujawnia postępowania upadłościowe i restrukturyzacyjne oraz egzekucje umorzone jako bezskuteczne. W elektronicznych księgach wieczystych można sprawdzić stan prawny nieruchomości, jeżeli znany jest numer księgi.",
           "Po wszczęciu egzekucji majątku poszukuje komornik — między innymi przez zapytania do banków, urzędu skarbowego i ZUS. Gdy to nie wystarcza, wierzyciel może żądać, aby dłużnik złożył przed sądem wykaz majątku pod rygorem odpowiedzialności karnej."
         ]},
        {"Co komornik może zająć?",
         [
           "Egzekucję można prowadzić jednocześnie z kilku składników majątku dłużnika: rachunków bankowych, wierzytelności przysługujących mu od jego własnych kontrahentów, ruchomości, nieruchomości oraz udziałów w spółkach. W egzekucji przeciwko firmie najszybsze efekty daje zwykle zajęcie rachunku i wierzytelności, a egzekucja z nieruchomości trwa najdłużej.",
           "Im dokładniej wierzyciel wskaże majątek we wniosku, tym sprawniej działa komornik — dlatego informacje o odbiorcach i rachunkach dłużnika warto gromadzić już w trakcie współpracy."
         ]},
        {"Co zrobić, gdy spółka-dłużnik nie ma majątku?",
         [
           "Jeżeli egzekucja przeciwko spółce z o.o. okaże się bezskuteczna, za jej zobowiązania odpowiadają solidarnie członkowie zarządu (art. 299 Kodeksu spółek handlowych). Mogą się od tej odpowiedzialności uwolnić, wykazując między innymi, że we właściwym czasie zgłoszono wniosek o ogłoszenie upadłości albo otwarto postępowanie restrukturyzacyjne.",
           "Gdy dłużnik wyzbył się majątku, przenosząc go na osoby trzecie, wierzyciel może żądać uznania takiej czynności za bezskuteczną wobec siebie — w ciągu pięciu lat od jej dokonania. Za długi spółki jawnej i komandytowej odpowiadają też jej wspólnicy, na zasadach właściwych dla danej spółki."
         ]}
      ],
      documents: [
        "faktury oraz potwierdzenia dostawy lub wykonania usługi",
        "umowa, zamówienie i ogólne warunki współpracy",
        "wezwania do zapłaty i korespondencja z dłużnikiem",
        "potwierdzenie salda albo uznanie długu, jeżeli zostało podpisane",
        "dane dłużnika: NIP, numer KRS, adresy",
        "znane informacje o majątku, rachunkach i odbiorcach dłużnika",
        "tytuł wykonawczy, jeżeli został już uzyskany"
      ]
    },
    "restrukturyzacja" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jakie są rodzaje postępowań restrukturyzacyjnych?",
         [
           {:list,
            [
              "postępowanie o zatwierdzenie układu — prowadzone w większości poza sądem, z nadzorcą układu wybranym przez dłużnika; sąd jedynie zatwierdza przyjęty układ,",
              "przyspieszone postępowanie układowe — gdy suma wierzytelności spornych nie przekracza 15% wierzytelności uprawniających do głosowania,",
              "postępowanie układowe — gdy wierzytelności sporne przekraczają 15%,",
              "postępowanie sanacyjne — z najszerszą ochroną przed egzekucją i możliwością głębokich zmian w przedsiębiorstwie; zarząd majątkiem przejmuje co do zasady zarządca."
            ]},
           "Wybór zależy od skali zadłużenia, liczby wierzycieli, toczących się egzekucji i tego, czy firma potrzebuje jedynie porozumienia co do spłat, czy także reorganizacji działalności."
         ]},
        {"Jak przebiega postępowanie o zatwierdzenie układu?",
         [
           "Dłużnik zawiera umowę z doradcą restrukturyzacyjnym, który obejmuje funkcję nadzorcy układu, i ustala dzień układowy. Po obwieszczeniu o jego ustaleniu w Krajowym Rejestrze Zadłużonych firma korzysta z ochrony: egzekucje wierzytelności objętych układem ulegają zawieszeniu, a kontrahenci nie mogą wypowiedzieć kluczowych umów.",
           "Ochrona trwa najwyżej cztery miesiące — w tym czasie trzeba zebrać głosy wierzycieli i złożyć do sądu wniosek o zatwierdzenie układu. Z obwieszczenia można skorzystać raz na dziesięć lat, dlatego propozycje układowe warto przygotować przed jego dokonaniem."
         ]},
        {"Które długi obejmuje układ?",
         [
           "Układ obejmuje co do zasady wierzytelności powstałe przed dniem układowym albo przed dniem otwarcia postępowania. Poza układem pozostają między innymi wierzytelności alimentacyjne. Wierzytelności ze stosunku pracy oraz zabezpieczone na majątku dłużnika hipoteką lub zastawem — w części znajdującej pokrycie w przedmiocie zabezpieczenia — układ obejmuje co do zasady tylko za zgodą wierzyciela.",
           "Należności wobec ZUS z tytułu składek mogą być w układzie jedynie rozłożone na raty lub odroczone, a część finansowana przez ubezpieczonego w ogóle nie jest nim objęta. Ma to duże znaczenie przy ocenie, czy układ rzeczywiście przywróci firmie płynność."
         ]},
        {"Co można zaproponować wierzycielom?",
         [
           "Propozycje układowe mogą przewidywać odroczenie terminu płatności, rozłożenie spłaty na raty, zmniejszenie wysokości zobowiązań oraz zamianę wierzytelności na udziały lub akcje. Wierzycieli można podzielić na grupy o różnych warunkach, na przykład według wysokości wierzytelności.",
           "Wierzyciele akceptują układ, gdy daje im więcej niż upadłość dłużnika — dlatego propozycje muszą być wiarygodne i oparte na realnej prognozie przychodów. Jeżeli restrukturyzacja nie rokuje powodzenia, trzeba ocenić obowiązek złożenia wniosku o ogłoszenie upadłości."
         ]}
      ],
      documents: [
        "sprawozdania finansowe i bieżące dane księgowe",
        "spis wierzycieli z kwotami, terminami płatności i zabezpieczeniami",
        "spis majątku firmy",
        "lista toczących się egzekucji i sporów sądowych",
        "umowy kredytu, leasingu i najmu oraz kluczowe kontrakty",
        "prognoza przychodów i kosztów na najbliższe miesiące"
      ]
    },
    "obsluga-korporacyjna" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jakie obowiązki ma spółka z o.o. w ciągu roku?",
         [
           {:list,
            [
              "sporządzenie sprawozdania finansowego — w ciągu trzech miesięcy od dnia bilansowego,",
              "zwyczajne zgromadzenie wspólników i zatwierdzenie sprawozdania — w ciągu sześciu miesięcy od dnia bilansowego,",
              "złożenie sprawozdania i uchwał do repozytorium dokumentów finansowych — w ciągu 15 dni od zatwierdzenia,",
              "zgłaszanie zmian do KRS — w ciągu siedmiu dni od zdarzenia,",
              "aktualizacja danych w Centralnym Rejestrze Beneficjentów Rzeczywistych — w ciągu 14 dni od zmiany,",
              "prowadzenie księgi udziałów i księgi protokołów."
            ]},
           "Uchybienie tym obowiązkom może skutkować postępowaniem przymuszającym sądu rejestrowego, grzywnami, a w skrajnych przypadkach — rozwiązaniem spółki bez przeprowadzania likwidacji."
         ]},
        {"Jak prawidłowo zwołać zgromadzenie wspólników?",
         [
           "Zgromadzenie zwołuje zarząd. Zaproszenia wysyła się listami poleconymi lub przesyłkami kurierskimi co najmniej dwa tygodnie przed terminem, a wspólnikowi, który wyraził na to pisemną zgodę — pocztą elektroniczną. W zaproszeniu podaje się dzień, godzinę, miejsce i szczegółowy porządek obrad.",
           "Uchwały można powziąć także bez formalnego zwołania, jeżeli reprezentowany jest cały kapitał zakładowy i nikt z obecnych nie zgłosił sprzeciwu. Błędy przy zwoływaniu zgromadzenia są jedną z najczęstszych podstaw zaskarżania uchwał, dlatego warto zachować dowody wysyłki zaproszeń."
         ]},
        {"Jak zmienić zarząd i złożyć rezygnację?",
         [
           "Członków zarządu powołuje i odwołuje uchwała wspólników, chyba że umowa spółki stanowi inaczej. Zmiana jest skuteczna z chwilą podjęcia uchwały, a wpis do KRS jedynie ją ujawnia — nowy zarząd może działać od razu.",
           "Członek zarządu składa rezygnację spółce, którą reprezentuje inny członek zarządu albo prokurent. Jeżeli w wyniku rezygnacji żaden mandat w zarządzie nie byłby obsadzony, rezygnację składa się wspólnikom, zwołując jednocześnie zgromadzenie wspólników — staje się ona skuteczna z dniem następującym po dniu, na który je zwołano."
         ]},
        {"Za co odpowiadają członkowie zarządu?",
         [
           "Członkowie zarządu odpowiadają wobec spółki za szkodę wyrządzoną niedołożeniem należytej staranności. Wobec wierzycieli spółki z o.o. odpowiadają solidarnie własnym majątkiem, gdy egzekucja przeciwko spółce okaże się bezskuteczna, a za zaległości podatkowe spółki — na zasadach określonych w Ordynacji podatkowej.",
           "Odpowiedzialność wiąże się także z niezłożeniem w terminie wniosku o ogłoszenie upadłości oraz z niesporządzeniem i niezłożeniem sprawozdania finansowego. Rzetelna dokumentacja decyzji zarządu jest najlepszą ochroną w razie późniejszych zarzutów. Spory, które z tego wynikają, opisujemy na stronie o [sporach gospodarczych](/uslugi/spory-gospodarcze)."
         ]}
      ],
      documents: [
        "aktualny tekst jednolity umowy spółki",
        "odpis z KRS",
        "księga udziałów i lista wspólników",
        "uchwały i protokoły zgromadzeń z ostatnich lat",
        "ostatnie sprawozdania finansowe",
        "dane członków organów wraz z adresami do doręczeń"
      ]
    },
    "nowe-technologie" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jak AI Act dzieli systemy sztucznej inteligencji?",
         [
           "Rozporządzenie opiera się na ocenie ryzyka i wyróżnia cztery poziomy:",
           {:list,
            [
              "praktyki zakazane — na przykład systemy manipulujące zachowaniem ludzi lub prowadzące scoring społeczny,",
              "systemy wysokiego ryzyka — między innymi używane w rekrutacji i ocenie pracowników, edukacji, ocenie zdolności kredytowej czy infrastrukturze krytycznej,",
              "systemy objęte obowiązkami przejrzystości — na przykład chatboty i narzędzia generujące treści,",
              "systemy minimalnego ryzyka, dla których rozporządzenie nie przewiduje szczególnych obowiązków."
            ]},
           "Zakres obowiązków zależy też od roli firmy: inne spoczywają na dostawcy, który wprowadza system do obrotu, a inne na podmiocie stosującym, czyli firmie korzystającej z gotowego narzędzia."
         ]},
        {"Jakie obowiązki ma firma, która tylko korzysta z AI?",
         [
           "Od 2 lutego 2025 r. każda firma korzystająca z systemów AI powinna zadbać, aby osoby, które je obsługują, miały odpowiedni poziom kompetencji w tym zakresie. Z systemów należy korzystać zgodnie z instrukcją dostawcy, a przy systemach wysokiego ryzyka zapewnić nadzór człowieka nad ich działaniem.",
           "Jeżeli firma udostępnia klientom chatbota albo publikuje treści wygenerowane lub zmanipulowane przez AI, musi liczyć się z obowiązkami informacyjnymi. Niezależnie od AI Act obowiązują przepisy o ochronie danych osobowych, prawie autorskim i tajemnicy przedsiębiorstwa."
         ]},
        {"Co powinna zawierać polityka korzystania z AI w firmie?",
         [
           {:list,
            [
              "listę narzędzi dopuszczonych do użytku służbowego,",
              "zakaz wprowadzania danych osobowych i informacji poufnych do narzędzi, które nie zostały do tego zatwierdzone,",
              "obowiązek weryfikowania wyników przez człowieka przed ich wykorzystaniem,",
              "zasady oznaczania treści wygenerowanych przez AI,",
              "reguły dotyczące praw autorskich i materiałów klientów,",
              "wskazanie osoby odpowiedzialnej oraz plan szkoleń."
            ]},
           "Polityka powinna być krótka i dopasowana do tego, jak firma rzeczywiście pracuje — dokument, którego nikt nie stosuje, nie ograniczy ryzyka."
         ]},
        {"Na co zwrócić uwagę w umowie z dostawcą AI lub oprogramowania?",
         [
           "Najwięcej sporów dotyczy danych i odpowiedzialności. W umowie warto ustalić, kto ma prawa do danych wejściowych i do wyników, czy dostawca może używać danych Klienta do trenowania modeli, gdzie dane są przechowywane i jak zostaną zwrócone lub usunięte po zakończeniu współpracy.",
           "Równie ważne są parametry dostępności i czas reakcji na awarie (SLA), limity odpowiedzialności dostawcy, zasady korzystania z podwykonawców oraz warunki wyjścia z umowy i przeniesienia danych do innego dostawcy. Jeżeli dostawca przetwarza dane osobowe, potrzebna jest także umowa powierzenia."
         ]}
      ],
      documents: [
        "opis narzędzi AI i procesów, w których są lub mają być używane",
        "regulaminy i umowy z dostawcami narzędzi",
        "informacja o rodzajach danych wprowadzanych do systemów",
        "obowiązujące polityki bezpieczeństwa i ochrony danych",
        "umowy z klientami zawierające klauzule poufności",
        "projekt umowy wdrożeniowej lub licencyjnej, jeżeli jest negocjowana"
      ]
    },
    "sukcesja-firm" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Od czego zacząć planowanie sukcesji?",
         [
           "Od uporządkowania faktów: w jakiej formie prawnej działa firma, które składniki majątku są firmowe, a które prywatne, jaki ustrój majątkowy łączy właściciela z małżonkiem i kto należy do kręgu spadkobierców ustawowych. Dopiero na tym tle można odpowiedzieć na najważniejsze pytanie — kto i na jakich zasadach ma przejąć prowadzenie firmy.",
           "Plan sukcesji powinien obejmować także sytuację nagłą: śmierć albo długotrwałą chorobę właściciela. Dlatego niezależnie od rozwiązań docelowych warto od razu zadbać o pełnomocnictwa i — w jednoosobowej działalności — o zarządcę sukcesyjnego."
         ]},
        {"Co może zarządca sukcesyjny?",
         [
           "Zarządca sukcesyjny prowadzi przedsiębiorstwo w spadku: wykonuje umowy, zawiera nowe, zatrudnia pracowników, rozlicza podatki i reprezentuje firmę przed sądami i urzędami. Czynności zwykłego zarządu podejmuje samodzielnie, a czynności przekraczające ten zakres — za zgodą wszystkich właścicieli przedsiębiorstwa w spadku albo za zezwoleniem sądu.",
           "Zarząd sukcesyjny jest rozwiązaniem przejściowym. Daje spadkobiercom czas na decyzję, czy firmę kontynuować, przekształcić, sprzedać, czy zamknąć."
         ]},
        {"Spółka, fundacja rodzinna czy testament — co wybrać?",
         [
           {:list,
            [
              "przekształcenie jednoosobowej działalności w spółkę z o.o. — firma przestaje zależeć od życia właściciela, a dziedziczeniu podlegają udziały; umowa spółki może określić zasady wstąpienia spadkobierców,",
              "fundacja rodzinna — majątek przechodzi na fundację, która zarządza nim i wypłaca świadczenia beneficjentom według statutu,",
              "testament z zapisem windykacyjnym — sporządzany u notariusza, pozwala przekazać przedsiębiorstwo konkretnej osobie z chwilą otwarcia spadku."
            ]},
           "Rozwiązania te można łączyć. Każde ma skutki podatkowe, które warto przeanalizować z doradcą podatkowym, zanim zapadną decyzje."
         ]},
        {"Jak działa fundacja rodzinna?",
         [
           "Fundację ustanawia fundator, który wnosi majątek i w statucie określa cele fundacji, beneficjentów oraz zasady przyznawania świadczeń. Organami fundacji są zarząd i zgromadzenie beneficjentów; radę nadzorczą trzeba powołać, gdy beneficjentów jest więcej niż dwudziestu pięciu.",
           "Fundacja rodzinna odpowiada solidarnie z fundatorem za jego zobowiązania powstałe przed jej ustanowieniem, w tym alimentacyjne — nie jest więc sposobem na ucieczkę przed wierzycielami. Wpływa też na roszczenia o [zachowek](/uslugi/zachowek), co trzeba uwzględnić w planie."
         ]}
      ],
      documents: [
        "wpis w CEIDG albo odpis z KRS i umowa spółki",
        "zestawienie majątku firmowego i prywatnego",
        "umowa majątkowa małżeńska, jeżeli została zawarta",
        "dotychczasowe testamenty",
        "lista kluczowych umów, koncesji i zezwoleń",
        "informacje o członkach rodziny i planowanych następcach"
      ]
    },
    "prawo-medyczne" => %{
      updated: ~D[2026-11-23],
      lead: "milena-kraluk",
      sections: [
        {"Jak zarejestrować gabinet lub podmiot leczniczy?",
         [
           "Działalność leczniczą można prowadzić jako praktykę zawodową albo jako podmiot leczniczy. Praktyki lekarskie rejestruje okręgowa rada lekarska, a podmioty lecznicze — wojewoda; wniosek składa się elektronicznie w Rejestrze Podmiotów Wykonujących Działalność Leczniczą. Organ dokonuje wpisu w terminie 30 dni.",
           "Przed złożeniem wniosku trzeba spełnić wymagania ustawowe: dysponować pomieszczeniami i wyposażeniem odpowiadającymi przepisom, zawrzeć umowę ubezpieczenia odpowiedzialności cywilnej, a w przypadku podmiotu leczniczego — ustalić regulamin organizacyjny."
         ]},
        {"Co musi zawierać regulamin organizacyjny?",
         [
           "Regulamin organizacyjny określa między innymi cele i zadania podmiotu, jego strukturę, rodzaj działalności leczniczej i zakres udzielanych świadczeń, miejsce ich udzielania oraz przebieg procesu udzielania świadczeń. Musi też wskazywać wysokość opłat — za udostępnienie dokumentacji medycznej i za świadczenia udzielane odpłatnie.",
           "Informacje o opłatach podaje się do wiadomości pacjentów. Nieaktualny albo skopiowany z innej placówki regulamin jest częstym zarzutem w toku kontroli."
         ]},
        {"Jak prawidłowo odebrać zgodę pacjenta?",
         [
           "Zgoda jest skuteczna tylko wtedy, gdy poprzedza ją przystępna informacja o stanie zdrowia, rozpoznaniu, proponowanych i możliwych metodach, dających się przewidzieć następstwach ich zastosowania albo zaniechania oraz o rokowaniu. Zgoda musi dotyczyć konkretnej czynności — ogólna formuła podpisana przy rejestracji nie wystarcza.",
           "Za pacjenta małoletniego zgodę wyraża przedstawiciel ustawowy, a gdy pacjent ukończył 16 lat — potrzebna jest także jego własna zgoda. W razie sporu to placówka musi wykazać, że pacjent został poinformowany, dlatego formularze powinny być dopasowane do zabiegu i uzupełniane indywidualną adnotacją."
         ]},
        {"Co zrobić, gdy pacjent zgłasza skargę lub roszczenie?",
         [
           {:list,
            [
              "zabezpieczyć kompletną dokumentację medyczną — bez jakichkolwiek późniejszych zmian,",
              "zgłosić zdarzenie ubezpieczycielowi OC w terminie wynikającym z umowy,",
              "udzielić pacjentowi rzeczowej odpowiedzi na piśmie,",
              "ustalić, czy sprawą zajmuje się Rzecznik Praw Pacjenta albo rzecznik odpowiedzialności zawodowej."
            ]},
           "Pacjent może dochodzić odszkodowania i zadośćuczynienia przed sądem cywilnym, a niezależnie od tego może toczyć się postępowanie w przedmiocie odpowiedzialności zawodowej. Wczesna analiza dokumentacji pozwala ocenić, czy roszczenie jest zasadne, i wybrać między ugodą a obroną w procesie."
         ]}
      ],
      documents: [
        "wpis do rejestru podmiotów wykonujących działalność leczniczą",
        "regulamin organizacyjny",
        "stosowane wzory zgód i formularzy dla pacjentów",
        "umowy z personelem medycznym i podwykonawcami",
        "polisa ubezpieczenia OC",
        "dokumentacja medyczna dotycząca zgłoszonego roszczenia",
        "korespondencja z pacjentem, ubezpieczycielem lub Rzecznikiem Praw Pacjenta"
      ]
    },
    "spory-gospodarcze" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Jak przygotować się do sporu z kontrahentem?",
         [
           "W sprawie gospodarczej dowody trzeba przedstawić od razu, dlatego przygotowanie zaczyna się przed wysłaniem pierwszego pisma. Gromadzimy umowę z aneksami, zamówienia, protokoły odbioru, faktury i korespondencję, a następnie sprawdzamy termin przedawnienia i wysokość roszczenia wraz z odsetkami.",
           "Kolejnym krokiem jest wezwanie do zapłaty lub do wykonania umowy i ocena odpowiedzi drugiej strony. Już na tym etapie przedstawiamy Klientowi realne szanse, przewidywany czas trwania postępowania i koszty — tak, aby decyzja o procesie była decyzją biznesową."
         ]},
        {"Jak przebiega sprawa gospodarcza w sądzie?",
         [
           {:list,
            [
              "pozew z kompletem twierdzeń i dowodów,",
              "nakaz zapłaty — jeżeli są do tego podstawy — albo doręczenie pozwu drugiej stronie,",
              "odpowiedź na pozew w terminie wyznaczonym przez sąd, nie krótszym niż dwa tygodnie,",
              "postępowanie dowodowe, w którym pierwszeństwo mają dokumenty,",
              "wyrok i ewentualna apelacja."
            ]},
           "Postępowanie gospodarcze ma własne ograniczenia: niedopuszczalne jest powództwo wzajemne, a zmiana żądania jest możliwa tylko w wąskim zakresie. Wyrok sądu pierwszej instancji zasądzający świadczenie pieniężne stanowi tytuł zabezpieczenia, co pozwala zabezpieczyć roszczenie jeszcze przed prawomocnym zakończeniem sprawy."
         ]},
        {"Mediacja, arbitraż czy sąd?",
         [
           "Mediacja pozwala zakończyć spór szybciej i zachować relację handlową; ugoda zatwierdzona przez sąd ma moc ugody sądowej i może być podstawą egzekucji. Sąd polubowny rozstrzyga sprawę tylko wtedy, gdy strony zapisały to w umowie — postępowanie bywa szybsze i poufne, ale kosztowniejsze.",
           "Proces przed sądem państwowym pozostaje podstawową drogą, gdy druga strona nie chce rozmawiać albo gra na zwłokę. O tym, którą drogę wybrać, często przesądza treść umowy, dlatego klauzule o rozstrzyganiu sporów warto przemyśleć już przy jej zawieraniu."
         ]},
        {"Kto ponosi koszty procesu?",
         [
           "Obowiązuje zasada odpowiedzialności za wynik sprawy: strona przegrywająca zwraca przeciwnikowi niezbędne koszty procesu, w tym opłatę od pozwu, wydatki na biegłych i koszty zastępstwa procesowego w wysokości wynikającej z przepisów. Przy częściowym uwzględnieniu żądań koszty rozdziela się stosunkowo.",
           "Wysokość roszczenia trzeba więc szacować ostrożnie — zawyżone żądanie oznacza wyższą opłatę i ryzyko zwrotu kosztów drugiej stronie. Przy zawarciu ugody sąd zwraca część uiszczonej opłaty."
         ]}
      ],
      documents: [
        "umowa wraz z aneksami i załącznikami",
        "zamówienia, protokoły odbioru i faktury",
        "korespondencja z kontrahentem, w tym wiadomości e-mail",
        "wezwania do zapłaty i odpowiedzi na nie",
        "dokumenty potwierdzające wysokość szkody lub naliczonych kar umownych",
        "dane osób, które uczestniczyły w wykonywaniu umowy"
      ]
    },
    "rodo" => %{
      updated: ~D[2026-11-23],
      lead: "michal-kurkierewicz",
      sections: [
        {"Co obejmuje audyt RODO?",
         [
           {:list,
            [
              "ustalenie, jakie dane osobowe firma przetwarza, w jakich celach i systemach,",
              "sprawdzenie podstaw prawnych przetwarzania i okresów przechowywania danych,",
              "ocenę klauzul informacyjnych, zgód i formularzy,",
              "przegląd umów z podmiotami, którym firma powierza dane,",
              "ocenę zabezpieczeń organizacyjnych i technicznych,",
              "raport z listą niezgodności i planem działań."
            ]},
           "Audyt pokazuje stan faktyczny — często okazuje się, że dokumenty istnieją, ale nie odpowiadają temu, jak firma rzeczywiście pracuje z danymi."
         ]},
        {"Jakie dokumenty RODO powinna mieć firma?",
         [
           "Zakres dokumentacji zależy od skali i ryzyka przetwarzania, ale w większości firm potrzebne są: rejestr czynności przetwarzania, klauzule informacyjne dla klientów, pracowników i kandydatów, upoważnienia do przetwarzania danych, umowy powierzenia z dostawcami oraz procedury realizacji praw osób i postępowania w razie naruszenia.",
           "Każde naruszenie ochrony danych trzeba udokumentować — także wtedy, gdy nie podlega zgłoszeniu do organu nadzorczego. Jeżeli planowane przetwarzanie może powodować wysokie ryzyko dla praw i wolności osób, konieczna jest wcześniejsza ocena skutków dla ochrony danych."
         ]},
        {"Co zrobić po wycieku danych?",
         [
           {:list,
            [
              "Ograniczyć skutki zdarzenia — zablokować dostęp, zmienić hasła, odzyskać dane.",
              "Ustalić, jakich danych i ilu osób dotyczy naruszenie.",
              "Ocenić ryzyko dla osób, których dane dotyczą.",
              "Zgłosić naruszenie Prezesowi UODO w ciągu 72 godzin, chyba że ryzyko jest mało prawdopodobne.",
              "Zawiadomić osoby, których dane dotyczą, jeżeli ryzyko jest wysokie.",
              "Opisać zdarzenie i podjęte działania w rejestrze naruszeń."
            ]},
           "Termin biegnie od stwierdzenia naruszenia, a nie od zakończenia jego wyjaśniania — zgłoszenie można uzupełniać. Pomagamy ocenić ryzyko i przygotować zgłoszenie oraz zawiadomienia."
         ]},
        {"Gdzie firmy najczęściej popełniają błędy?",
         [
           "Monitoring wizyjny pracowników jest dopuszczalny tylko w celach wskazanych w Kodeksie pracy, wymaga wcześniejszego poinformowania zatrudnionych, a nagrania przechowuje się co do zasady nie dłużej niż trzy miesiące. W rekrutacji wolno żądać wyłącznie danych określonych w przepisach, a zachowanie CV na przyszłe nabory wymaga zgody kandydata.",
           "Wysyłanie informacji handlowych pocztą elektroniczną lub telefonicznie wymaga uprzedniej zgody odbiorcy. Częstym błędem jest też brak umów powierzenia z biurem rachunkowym, dostawcą hostingu czy firmą informatyczną. Osoba, której prawa naruszono, może żądać odszkodowania przed sądem — niezależnie od kary administracyjnej."
         ]}
      ],
      documents: [
        "lista procesów i systemów, w których przetwarzane są dane osobowe",
        "istniejąca dokumentacja ochrony danych",
        "umowy z dostawcami usług IT, księgowych i hostingowych",
        "wzory formularzy, zgód i klauzul informacyjnych",
        "regulamin pracy i zasady monitoringu",
        "opis incydentu, jeżeli doszło do naruszenia ochrony danych"
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
