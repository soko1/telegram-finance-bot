create table budget(
    codename varchar(255) primary key,
    daily_limit integer
);

create table category(
    codename varchar(255) primary key,
    name varchar(255),
    is_base_expense boolean,
    aliases text
);

create table expense(
    id integer primary key,
    amount integer,
    created datetime,
    category_codename integer,
    raw_text text,
    FOREIGN KEY(category_codename) REFERENCES category(codename)
);

insert into category (codename, name, is_base_expense, aliases)
values
    ("food", "Ежа", true, "ежа, крама, офіс, у офіс, смачнае, смачнюшкі, салодзенькае, салодкасці, салодкае, садавіна, садавінка, гародніна, замарозка, еўраопт, еўраапт, едастаўка, суседзі, зарына, зарынка, дабраном, дабрагом, крамушка, рублеўскі, рублёўскі, рубель, рубль, гарбата"),
    ("communal", "Камуналка, сувязь", false, "мабілка, мабільны, тэлефон, тэл, байфлай, byfly, electricity, электра, электрычнасць, камуналка, камун, камунал, communal, жыроўка, лайф, life, інэт, інтэрнэт"),
    ("pets", "Каця і інш.", false, "корм, напаўняльнік, кацячы, котцы, коціцьке, кату, напаўн, ветэрынар"),
    ("cosmetics", "Гігіена, касметыка, прыгажосць", false, "ватныя дыскі, Міла, туал, туалетная, шампунь, мыла, крэм, душ, душу, пазногцяў, для рук, для ног, скраб, памада, туш, для вачэй, для броваў, фрызура, стрыжка, цырульня, цырнульнік, касметыка"),
    ("outfit", "Вопратка і аксэсуары", false, "сэканд, секонд, сэк, модамакс, хэпіхэнд, джынсы, шалік, абутак, кросы, кроссы, красоўкі, боты, акуляры, каліласка, калі ласка, адзенне, вопратка, шмоткі, шмот, штаны, майка, майткі, трусы, шкарпэткі, бялізна, байка, шапка, капялюш, капелюш, куртка, масцерка, wildberries, lamoda, h&m, pull&bear, zara"),
    ("tech", "Тэхніка, электроніка, роварнае", false, "модуль, вайфай, wifi, wi-fi, вай-фай, запцацка, запацацкі, тэхніка, ровар, тармазы, драгонбайк, дрэганбайк, байк, айбайк, ланцуг, провад, перахаднік, tech, technics, computer"),
    ("household", "Гаспадарчае, мэбля, інтэр'ер", false, "фатэль, дыван, дыванок, канапа, стол, крэсла, крэслы, зэдлік, сядушка, падушка, ікеа, ікея, ikea, jysk, юск, жыск, йуск, скрыня, household, interior, home"),
    ("transport", "Транспарт", false, "transport, метро, квіткі, квіток, колабайк, трал, тралік, metro, марш, маршрутка, аўтобус, электрацыя, электрон, электрычка, таксі, taxi, таксоўка"),   
    ("health", "Медыцына, здароўе", false, "лекар, лекарка, сантэ, гінеколаг, стаматолаг, зубы, зубкі, Дэн, здымак, УГД, УЗІ, УЗИ, мазок, агляд, прыём, прыем, therapy, псіхатэрапія, тэрапія"),
    ("active", "Спорт, актыўны адпачынак", false, "sport, outing, hike, hiking, паход, бенз, на прыроду, пікнік, фітнэс, абанемент, ёга, йога, йогаплэйс, yoga, yoga place, yogaplace, fitness, total body, freestyle, фрыстайл, тотал бодзі, трэніроўка, gym, аквапарк, басік, басейн, лазня, Іслач, Неман, возера, рэчка, экспедыцыя, вылазка"),
    ("presents", "Падарункі, госці, бацькі", false, "бацькі, да бацькоў, маці, бабулі, бабуля, Любімава, Чыжоўка, Чыжоўцы, Чыжоўку, малінаўка, малінаўку, малінаўцы, госці, падарунак, падарункі, новы год, свята, дзень народзінаў, тату, бацьку"),
    ("cafe", "Кафэ і г.д.", true, "cafe, bar, pub, бар, паб, кактэйль, піва, beer, cocktail, drink, dinner, supper, breakfast, lunch, brunch, бранч, рэстаран, кавярня, эспрэса, амерыкана, капучына, макдак, мак, кфц, піцца, піца, лісіца, додо, бургер, бургер, бургеры, бургерлаб, хінкалі, хінкальня, фалафель, суп, омнамо, омномном, шаверма, шавуха, шава, мф, манкі, манкіфуд, зерно, зерне, соўл, абед, ланч, сталоўка, кілфіш, кіл фіш, бітлджус, абед, вячэра, сняданак"),
    ("culture", "Культура, адукацыя і г.д.", false, "кніга, кнігі, book, books, выстава, exhibition, лекцыя, курс, вэбінар"),
    ("hobby", "Хобі, кава і г.д.", false, "hobby, хобі, хоббі, маркі, паштоўка, паштоўкі, кава, дэвайс, посткросінг, postcrossing, card, кофебел, кавабел, кветкі, гаршчок, гаршкі, зямля, угнаенне, керамзіт, падкормка"),
    ("travel", "Вандроўкі", false, "travel, авія, самалёт, цягнік, Масква, гатэль, хостэл, букінг, booking, viza, embassy, віза, візы, анкета, амбасада"), 
    ("other", "Іншае", false, "падпіска"),
    ("charity", "Дабрачыннасць і КФ", false, "краўд, краўдфандынг, дапамога, ахвяраванне, фонд, сяброўства, унёсак"),
    ("work", "Працоўныя выдаткі", false, "арэнда, падаткі, падатак, камандзіроўка, ліцэнзія, license, taxes, rent, work"),

insert into budget(codename, daily_limit) values ('base', 500);
