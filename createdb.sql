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
    ("products", "прадукты", true, "ежа, крама"),
    ("coffee", "кава", true, ""),
    ("dinner", "абед", true, "абед, ланч, сталоўка"),
    ("cafe", "кафе", true, "рэстаран, кавярня, эспрэса, амерыкана, капучына, макдак, мак, кфц, піцца, піца"),
    ("transport", "грамадскі транспарт", false, "метро, квіткі, квіток, колабайк"),
    ("taxi", "таксі", false, "таксі"),
    ("phone", "телефон", false, "мабілка, мабільны, тэлефон"),
    ("books", "книги", false, "кніга, кнігі"),
    ("internet", "интернет", false, "інэт, байфлай, інтэрнэт"),
    ("subscriptions", "падпіскі", false, "падпіска"),
    ("other", "іншае", true, "");

insert into budget(codename, daily_limit) values ('base', 500);
