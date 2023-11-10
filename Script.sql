create type role_type as enum ('admin', 'staff', 'customer');
create type size_type as enum ('small', 'medium', 'large');
create type status_type as enum ('on-progress', 'delivered', 'canceled', 'ready-to-pick');

create table if not exists "users"(
"id" serial primary key,
"fullName" varchar (255) not null,
"email" varchar (50) unique not null,
"phoneNumber" varchar (15) not null,
"address" varchar (255) not null,
"picture" varchar (255),
"role" "role_type" default 'customer',
"password" varchar (255) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "products"(
"id" serial primary key,
"name" varchar (255) not null,
"price" int not null,
"image" varchar (255),
"description" text,
"discount" float,
"isRecommended" bool,
"qty" int not null,
"isActive" bool not null default true,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productSize"(
"id" serial primary key,
"size" "size_type" default null,
"additionalPrice" int not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productVariant"(
"id" serial primary key,
"name" varchar (15) not null,
"additionalPrice" int not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "tags"(
"id" serial primary key,
"name" varchar (30) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "categories"(
"id" serial primary key,
"name" varchar (50) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "promo"(
"id" serial primary key,
"name" varchar (50) not null,
"code" varchar (50) not null,
"description" text,
"percentage" decimal not null,
"isExpired" bool,
"maximumPromo" int not null,
"minimumAmount" int not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productCategories"(
"id" serial primary key,
"productId" int not null,
foreign key ("productId") references "products"(id),
"categoriesId" int not null,
foreign key ("categoriesId") references "categories"(id),
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productTags"(
"id" serial primary key,
"productId" int not null,
foreign key ("productId") references "products"(id),
"tagsId" int not null,
foreign key ("tagsId") references "tags"(id),
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productRatings"(
"id" serial primary key,
"productId" int not null,
foreign key ("productId") references "products"(id),
"rate" int,
"reviewMessege" text,
"usersId" int not null,
foreign key ("usersId") references "users"(id),
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "orders"(
"id" serial primary key,
"usersId" int not null,
foreign key ("usersId") references "users"(id),
"orderNumber" varchar (80),
"promoId" int,
foreign key ("promoId") references "promo"(id),
"total" int not null,
"taxAmount" int not null,
"status" "status_type" default null,
"deliveryAddress" varchar (255) not null,
"fullName" varchar (255) not null,
"email" varchar (50) unique not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "orderDetails"(
"id" serial primary key,
"ordersId" int not null,
foreign key ("ordersId") references "orders"(id),
"productId" int not null,
foreign key ("productId") references "products"(id),
"productSizeId" int not null,
foreign key ("productSizeId") references "productSize"(id),
"productVariantId" int not null,
foreign key ("productVariantId") references "productVariant"(id),
"qty" int not null,
"subTotal" int not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "message"(
"id" serial primary key,
);

INSERT INTO "users" ("id", "fullName", "email", "phoneNumber", "address", "picture", "role", "password", "createdAt", "updatedAt")
VALUES
    (4, 'John Doe', 'johndoe@example.com', '1234567890', '123 Main St', 'john.jpg', 'customer', 'password1', '2023-11-08 17:32:17.309', NULL),
    (5, 'Jane Smith', 'janesmith@example.com', '9876543210', '456 Elm St', 'jane.jpg', 'customer', 'password2', '2023-11-08 17:32:17.309', NULL),
    (6, 'Alice Johnson', 'alice@example.com', '5551234567', '789 Oak St', 'alice.jpg', 'customer', 'password3', '2023-11-08 17:32:17.309', NULL),
    (7, 'Bob Brown', 'bob@example.com', '1112223333', '101 Pine St', 'bob.jpg', 'customer', 'password4', '2023-11-08 17:32:17.309', NULL),
    (8, 'Eva Wilson', 'eva@example.com', '4445556666', '202 Cedar St', 'eva.jpg', 'customer', 'password5', '2023-11-08 17:32:17.309', NULL),
    (9, 'Mike Davis', 'mike@example.com', '9998887777', '303 Walnut St', 'mike.jpg', 'customer', 'password6', '2023-11-08 17:32:17.309', NULL),
    (10, 'Sara White', 'sara@example.com', '3332221111', '505 Maple St', 'sara.jpg', 'customer', 'password7', '2023-11-08 17:32:17.309', NULL),
    (11, 'Tom Clark', 'tom@example.com', '7778889999', '707 Birch St', 'tom.jpg', 'customer', 'password8', '2023-11-08 17:32:17.309', NULL),
    (12, 'Emily Lee', 'emily@example.com', '2223334444', '909 Redwood St', 'emily.jpg', 'customer', 'password9', '2023-11-08 17:32:17.309', NULL),
    (13, 'Chris Hall', 'chris@example.com', '6665554444', '1212 Pineapple St', 'chris.jpg', 'customer', 'password10', '2023-11-08 17:32:17.309', NULL);
    
INSERT INTO "promo" ("id", "name", "code", "description", "percentage", "isExpired", "maximumPromo", "minimumAmount", "createdAt", "updatedAt")
VALUES
    (1, 'Promo 1', 'PROMO123', 'Diskon 10%', 0.10, TRUE, 50000, 100000, '2023-11-08 17:32:17.309', NULL),
    (2, 'Promo 2', 'SALE20', 'Potongan 20%', 0.20, TRUE, 30000, 50000, '2023-11-08 17:32:17.309', NULL),
    (3, 'Promo 3', 'SAVEBIG', 'Potongan 30%', 0.30, TRUE, 40000, 75000, '2023-11-08 17:32:17.309', NULL),
    (4, 'Promo 4', 'DISCOUNT40', 'Diskon 40%', 0.40, TRUE, 60000, 80000, '2023-11-08 17:32:17.309', NULL),
    (5, 'Promo 5', 'GET50OFF', 'Diskon 50%', 0.50, TRUE, 70000, 120000, '2023-11-08 17:32:17.309', NULL),
    (6, 'Promo 6', 'SPECIAL15', 'Potongan 15%', 0.15, TRUE, 45000, 90000, '2023-11-08 17:32:17.309', NULL),
    (7, 'Promo 7', 'HALFOFF', 'Diskon 50%', 0.50, TRUE, 75000, 150000, '2023-11-08 17:32:17.309', NULL),
    (8, 'Promo 8', 'SAVE25NOW', 'Potongan 25%', 0.25, TRUE, 35000, 60000, '2023-11-08 17:32:17.309', NULL),
    (9, 'Promo 9', 'FREESHIP', 'Gratis Ongkir 15%', 0.15, TRUE, 100000, 200000, '2023-11-08 17:32:17.309', NULL),
    (10, 'Promo 10', 'BIGSAVINGS', 'Diskon Besar', 0.75, TRUE, 80000, 250000, '2023-11-08 17:32:17.309', NULL),
    (11, 'Promo 11', 'SAVEMORE', 'Potongan 10%', 0.10, TRUE, 20000, 40000, '2023-11-08 17:32:17.309', NULL),
    (12, 'Promo 12', 'DISCOUNT20', 'Diskon 20%', 0.20, TRUE, 25000, 30000, '2023-11-08 17:32:17.309', NULL),
    (13, 'Promo 13', 'EXTRA5OFF', 'Ekstra 5%', 0.05, TRUE, 10000, 15000, '2023-11-08 17:32:17.309', NULL),
    (14, 'Promo 14', 'SUPER50', 'Potongan 50%', 0.50, TRUE, 70000, 100000, '2023-11-08 17:32:17.309', NULL),
    (15, 'Promo 15', 'WEEKEND10', 'Diskon 10%', 0.10, TRUE, 30000, 50000, '2023-11-08 17:32:17.309', NULL),
    (16, 'Promo 16', 'HOLIDAY15', 'Potongan 15%', 0.15, TRUE, 40000, 60000, '2023-11-08 17:32:17.309', NULL),
    (17, 'Promo 17', 'FLASHSALE30', 'Diskon Cepat 30%', 0.30, TRUE, 50000, 75000, '2023-11-08 17:32:17.309', NULL),
    (18, 'Promo 18', 'SAVEONLINE', 'Potongan 25%', 0.25, TRUE, 35000, 55000, '2023-11-08 17:32:17.309', NULL),
    (19, 'Promo 19', 'DISCOUNT15', 'Diskon 15%', 0.15, TRUE, 25000, 45000, '2023-11-08 17:32:17.309', NULL),
    (20, 'Promo 20', 'SAVETODAY', 'Potongan 20%', 0.20, TRUE, 30000, 50000, '2023-11-08 17:32:17.309', NULL);
    
   
INSERT INTO "products" ("id", "name", "price", "image", "description", "discount", "isRecommended", "qty", "isActive", "createdAt", "updatedAt")
VALUES
    (1, 'Cappuccino', 15000, 'cappuccino.jpg', 'Cappuccino is a coffee drink that is made with espresso and steamed milk.', 5000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (2, 'Latte', 16000, 'latte.jpg', 'Latte is a coffee drink made with espresso and a large amount of steamed milk.', 6000, TRUE, 120, TRUE, '2023-11-08 17:32:17.309', NULL),
    (3, 'Espresso', 12000, 'espresso.jpg', 'Espresso is a concentrated coffee drink made by forcing a small amount of nearly boiling water through finely-ground coffee beans.', 4000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (4, 'Mocha', 17000, 'mocha.jpg', 'Mocha is a coffee drink made with espresso, hot milk, and chocolate.', 7000, TRUE, 90, TRUE, '2023-11-08 17:32:17.309', NULL),
    (5, 'Macchiato', 14000, 'macchiato.jpg', 'Macchiato is a coffee drink made with espresso "stained" or "marked" with a small amount of frothy milk.', 3000, TRUE, 70, TRUE, '2023-11-08 17:32:17.309', NULL),
    (6, 'Americano', 13000, 'americano.jpg', 'Americano is a coffee drink made with espresso and hot water.', 2000, TRUE, 60, TRUE, '2023-11-08 17:32:17.309', NULL),
    (7, 'Iced Coffee', 14000, 'iced_coffee.jpg', 'Iced coffee is a chilled coffee drink served with ice.', 4000, TRUE, 110, TRUE, '2023-11-08 17:32:17.309', NULL),
    (8, 'Caramel Macchiato', 18000, 'caramel_macchiato.jpg', 'Caramel macchiato is a coffee drink made with espresso, caramel syrup, steamed milk, and foam.', 8000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (9, 'Café au Lait', 15000, 'cafe_au_lait.jpg', 'Café au lait is a coffee drink made with equal parts of brewed coffee and hot milk.', 4000, TRUE, 90, TRUE, '2023-11-08 17:32:17.309', NULL),
    (10, 'Espresso Con Panna', 17000, 'espresso_con_panna.jpg', 'Espresso con panna is a coffee drink made with a shot of espresso and a dollop of whipped cream.', 7000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (11, 'Irish Coffee', 20000, 'irish_coffee.jpg', 'Irish coffee is a cocktail consisting of hot coffee, Irish whiskey, and sugar, stirred, and topped with cream.', 10000, TRUE, 120, TRUE, '2023-11-08 17:32:17.309', NULL),
    (12, 'Café Miel', 16000, 'cafe_miel.jpg', 'Café miel is a coffee drink made with espresso, steamed milk, honey, and cinnamon.', 6000, TRUE, 110, TRUE, '2023-11-08 17:32:17.309', NULL),
    (13, 'Flat White', 17000, 'flat_white.jpg', 'Flat white is a coffee drink made with espresso and steamed milk, similar to a latte but with a higher coffee-to-milk ratio.', 7000, TRUE, 120, TRUE, '2023-11-08 17:32:17.309', NULL),
    (14, 'Cortado', 14000, 'cortado.jpg', 'Cortado is a coffee drink made with espresso and a small amount of warm milk to reduce the acidity.', 4000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (15, 'Affogato', 18000, 'affogato.jpg', 'Affogato is a coffee dessert made by pouring a shot of hot espresso over a scoop of vanilla ice cream.', 8000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (16, 'Turkish Coffee', 15000, 'turkish_coffee.jpg', 'Turkish coffee is a method of preparing very finely ground coffee unfiltered with sugar and cardamom.', 5000, TRUE, 90, TRUE, '2023-11-08 17:32:17.309', NULL),
    (17, 'Vienna Coffee', 16000, 'vienna_coffee.jpg', 'Vienna coffee is a coffee drink made with black coffee and whipped cream.', 6000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (18, 'Café Bombon', 18000, 'cafe_bombon.jpg', 'Café bombon is a coffee drink made with espresso and sweet condensed milk.', 8000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (19, 'Cuban Coffee', 13000, 'cuban_coffee.jpg', 'Cuban coffee is a coffee drink made with very sweet coffee and strong espresso.', 3000, TRUE, 70, TRUE, '2023-11-08 17:32:17.309', NULL),
    (20, 'Coffee Milk', 14000, 'coffee_milk.jpg', 'Coffee milk is a sweet coffee drink made with sweetened coffee syrup and milk.', 4000, TRUE, 60, TRUE, '2023-11-08 17:32:17.309', NULL),
    (21, 'Café Crema', 16000, 'cafe_crema.jpg', 'Café crema is a coffee drink made with espresso and hot water, similar to an Americano but with more cream.', 6000, TRUE, 120, TRUE, '2023-11-08 17:32:17.309', NULL),
    (22, 'Café con Leche', 15000, 'cafe_con_leche.jpg', 'Café con leche is a coffee drink made with equal parts of brewed coffee and hot milk.', 5000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (23, 'Red Eye', 14000, 'red_eye.jpg', 'Red eye is a coffee drink made with brewed coffee and a shot of espresso.', 4000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (24, 'Café Tobio', 16000, 'cafe_tobio.jpg', 'Café tobio is a coffee drink made with espresso and dark chocolate.', 6000, TRUE, 110, TRUE, '2023-11-08 17:32:17.309', NULL),
    (25, 'Kopi Tubruk', 15000, 'kopi_tubruk.jpg', 'Kopi tubruk is a traditional Javanese coffee made by dissolving a lump of Javanese coffee grounds and sugar in hot water.', 5000, TRUE, 90, TRUE, '2023-11-08 17:32:17.309', NULL),
    (26, 'Kopi Tarik', 14000, 'kopi_tarik.jpg', 'Kopi tarik is a Malaysian coffee made by pulling the coffee repeatedly to create a frothy top.', 4000, TRUE, 70, TRUE, '2023-11-08 17:32:17.309', NULL),
    (27, 'Kopi Joss', 16000, 'kopi_joss.jpg', 'Kopi joss is a unique Indonesian coffee made by adding a piece of red-hot charcoal to the coffee.', 6000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (28, 'Kopi Tubruk Madura', 15000, 'kopi_tubruk_madura.jpg', 'Kopi tubruk Madura is a variation of kopi tubruk with a strong flavor and rich taste.', 5000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (29, 'Kopi Susu', 17000, 'kopi_susu.jpg', 'Kopi susu is an Indonesian coffee made with a combination of strong coffee and sweet condensed milk.', 7000, TRUE, 90, TRUE, '2023-11-08 17:32:17.309', NULL),
    (30, 'Bali Coffee', 16000, 'bali_coffee.jpg', 'Bali coffee is a traditional Balinese coffee made from coffee beans grown on the island of Bali.', 6000, TRUE, 70, TRUE, '2023-11-08 17:32:17.309', NULL),
    (31, 'Aceh Coffee', 14000, 'aceh_coffee.jpg', 'Aceh coffee is a coffee from the Aceh region of Indonesia, known for its bold and earthy flavor.', 4000, TRUE, 120, TRUE, '2023-11-08 17:32:17.309', NULL),
    (32, 'Sumatra Coffee', 15000, 'sumatra_coffee.jpg', 'Sumatra coffee is a coffee from the island of Sumatra, known for its full-bodied and herbal taste.', 5000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (33, 'Java Coffee', 16000, 'java_coffee.jpg', 'Java coffee is a coffee from the island of Java, known for its mild and clean flavor.', 6000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (34, 'Sulawesi Coffee', 17000, 'sulawesi_coffee.jpg', 'Sulawesi coffee is a coffee from the island of Sulawesi, known for its fruity and nutty taste.', 7000, TRUE, 70, TRUE, '2023-11-08 17:32:17.309', NULL),
    (35, 'Luwak Coffee', 25000, 'luwak_coffee.jpg', 'Luwak coffee is made from coffee beans that have been eaten and then excreted by civet cats.', 15000, TRUE, 80, TRUE, '2023-11-08 17:32:17.309', NULL),
    (36, 'Honey Process Coffee', 18000, 'honey_process_coffee.jpg', 'Honey process coffee is a method of processing coffee beans that involves leaving some or all of the fruit pulp on the beans while they dry.', 8000, TRUE, 110, TRUE, '2023-11-08 17:32:17.309', NULL),
    (37, 'Milkshake', 22000, 'milkshake.jpg', 'Minuman susu segar', 8000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (38, 'Iced Tea', 12000, 'icedtea.jpg', 'Teh dingin', 4000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (39, 'Hot Chocolate', 20000, 'hotchocolate.jpg', 'Minuman cokelat panas', 7000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (40, 'Fruit Smoothie', 24000, 'fruitsmoothie.jpg', 'Smoothie buah segar', 9000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (41, 'Green Tea Latte', 18000, 'greentealatte.jpg', 'Matcha latte', 6000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (42, 'Iced Coffee', 15000, 'icedcoffee.jpg', 'Kopi dingin', 5000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (43, 'Black Tea', 12000, 'blacktea.jpg', 'Teh hitam', 4000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (44, 'Chai Latte', 19000, 'chailatte.jpg', 'Minuman rempah dengan susu', 7000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (45, 'Cold Brew', 18000, 'coldbrew.jpg', 'Kopi seduh dingin', 6000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (46, 'Peppermint Mocha', 22000, 'peppermintmocha.jpg', 'Kopi cokelat dengan peppermint', 8000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (47, 'Lavender Latte', 21000, 'lavenderlatte.jpg', 'Latte dengan aroma lavender', 7000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (48, 'Caramel Macchiato', 19000, 'caramelmachiato.jpg', 'Macchiato dengan karamel', 6000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL),
    (49, 'Hazelnut Latte', 20000, 'hazelnutlatte.jpg', 'Latte dengan rasa hazelnut', 7000, TRUE, 100, TRUE, '2023-11-08 17:32:17.309', NULL);
    
INSERT INTO "productSize" ("id", "size", "additionalPrice", "createdAt", "updatedAt")
VALUES
    (1, 'small', 10000, 2023-11-09 08:48:24.547, NULL)
    (2, 'medium', 15000, 2023-11-09 08:48:24.552, NULL)
    (3, 'large', 20000, 2023-11-09 08:48:24.553, NULL);
    
INSERT INTO "productVariant" ("id", "name", "additionalPrice", "createdAt", "updatedAt")
VALUES  
	(1, 'Ice', 2000, 2023-11-09 08:49:15.782, NULL)
	(2, 'Hot', 1000, 2023-11-09 08:49:15.785, NULL);
	
INSERT INTO "categories" ("id", "name", "createdAt", "updatedAt")
VALUES
    (1, 'Kopi Hitam', '2023-11-08 17:32:17.309', NULL),
    (2, 'Kopi dengan Susu', '2023-11-08 17:32:17.309', NULL),
    (3, 'Minuman Cokelat', '2023-11-08 17:32:17.309', NULL),
    (4, 'Minuman Teh', '2023-11-08 17:32:17.309', NULL),
    (5, 'Minuman Smoothie', '2023-11-08 17:32:17.309', NULL);
    
INSERT INTO "tags" ("id", "name", "createdAt", "updatedAt")
VALUES
    (1, 'Kopi', '2023-11-08 17:32:17.309', NULL),
    (2, 'Espresso', '2023-11-08 17:32:17.309', NULL),
    (3, 'Cappuccino', '2023-11-08 17:32:17.309', NULL),
    (4, 'Latte', '2023-11-08 17:32:17.309', NULL),
    (5, 'Mocha', '2023-11-08 17:32:17.309', NULL),
    (6, 'Americano', '2023-11-08 17:32:17.309', NULL),
    (7, 'Macchiato', '2023-11-08 17:32:17.309', NULL),
    (8, 'Cortado', '2023-11-08 17:32:17.309', NULL),
    (9, 'Flat White', '2023-11-08 17:32:17.309', NULL),
    (10, 'Affogato', '2023-11-08 17:32:17.309', NULL),
    (11, 'Ristretto', '2023-11-08 17:32:17.309', NULL),
    (12, 'Doppio', '2023-11-08 17:32:17.309', NULL),
    (13, 'Irish Coffee', '2023-11-08 17:32:17.309', NULL),
    (14, 'Milkshake', '2023-11-08 17:32:17.309', NULL),
    (15, 'Iced Tea', '2023-11-08 17:32:17.309', NULL),
    (16, 'Hot Chocolate', '2023-11-08 17:32:17.309', NULL),
    (17, 'Fruit Smoothie', '2023-11-08 17:32:17.309', NULL),
    (18, 'Green Tea Latte', '2023-11-08 17:32:17.309', NULL),
    (19, 'Iced Coffee', '2023-11-08 17:32:17.309', NULL),
    (20, 'Black Tea', '2023-11-08 17:32:17.309', NULL),
    (21, 'Chai Latte', '2023-11-08 17:32:17.309', NULL),
    (22, 'Cold Brew', '2023-11-08 17:32:17.309', NULL),
    (23, 'Peppermint Mocha', '2023-11-08 17:32:17.309', NULL),
    (24, 'Lavender Latte', '2023-11-08 17:32:17.309', NULL),
    (25, 'Caramel Macchiato', '2023-11-08 17:32:17.309', NULL),
    (26, 'Hazelnut Latte', '2023-11-08 17:32:17.309', NULL),
    (27, 'Turmeric Latte', '2023-11-08 17:32:17.309', NULL),
    (28, 'Mint Chocolate', '2023-11-08 17:32:17.309', NULL),
    (29, 'Chamomile Tea', '2023-11-08 17:32:17.309', NULL),
    (30, 'White Mocha', '2023-11-08 17:32:17.309', NULL),
    (31, 'Matcha Latte', '2023-11-08 17:32:17.309', NULL),
    (32, 'Espresso Con Panna', '2023-11-08 17:32:17.309', NULL),
    (33, 'Butter Coffee', '2023-11-08 17:32:17.309', NULL),
    (34, 'Red Eye', '2023-11-08 17:32:17.309', NULL),
    (35, 'Cinnamon Latte', '2023-11-08 17:32:17.309', NULL),
    (36, 'Golden Latte', '2023-11-08 17:32:17.309', NULL);
    
INSERT INTO "products" ("id", "productId", "tags", "createdAt", "updatedAt")
VALUES
	(1, 1, 1, '2023-11-10 08:28:21.220', NULL)
	(2, 3, 1, '2023-11-10 08:28:21.220', NULL)
	(3, 6, 1, '2023-11-10 08:28:21.220', NULL)
	(4, 7, 1, '2023-11-10 08:28:21.220', NULL)
	(5, 9, 1, '2023-11-10 08:28:21.220', NULL)
	(6, 10, 1, '2023-11-10 08:28:21.220', NULL)
	(7, 11, 1, '2023-11-10 08:28:21.220', NULL)
	(8, 12, 1, '2023-11-10 08:28:21.220', NULL)
	(9, 16, 1, '2023-11-10 08:28:21.220', NULL)
	(10, 17, 1, '2023-11-10 08:28:21.220', NULL);
	
INSERT INTO "products" ("id", "productId", "categoriesId", "createdAt", "updatedAt")
VALUES
	(1, 1, 1, '2023-11-10 08:28:21.220', NULL)
	(2, 3, 1, '2023-11-10 08:28:21.220', NULL)
	(3, 6, 1, '2023-11-10 08:28:21.220', NULL)
	(4, 7, 1, '2023-11-10 08:28:21.220', NULL)
	(5, 9, 1, '2023-11-10 08:28:21.220', NULL)
	(6, 10, 1, '2023-11-10 08:28:21.220', NULL)
	(7, 11, 1, '2023-11-10 08:28:21.220', NULL)
	(8, 12, 1, '2023-11-10 08:28:21.220', NULL)
	(9, 14, 1, '2023-11-10 08:28:21.220', NULL)
	(10, 15, 1, '2023-11-10 08:28:21.220', NULL)
	(11, 16, 1, '2023-11-10 08:28:21.220', NULL)
	(12, 17, 1, '2023-11-10 08:28:21.220', NULL);
	
INSERT INTO "productRatings"  ("id", "productId", "rate", "reviewMessege", "userId", "createdAt", "updatedAt")
VALUES
	(1, 8, 5, 'Kopinya enak banget.', 1, '2023-11-10 08:28:21.220', NULL)
	(5, 21, 4, 'Kopinya enak banget.', 1, '2023-11-10 08:28:21.220', NULL)
	(6, 22, 3, 'Kopinya enak banget.', 3, '2023-11-10 08:28:21.220', NULL)
	(7, 1, 5, 'Kopinya enak banget.', 4, '2023-11-10 08:28:21.220', NULL)
	(8, 3, 2, 'Kopinya enak banget.', 1, '2023-11-10 08:28:21.220', NULL)
	(9, 6, 1, 'Kopinya enak banget.', 6, '2023-11-10 08:28:21.220', NULL)
	(10, 2, 3, 'Kopinya enak banget.', 5, '2023-11-10 08:28:21.220', NULL)
	(11, 7, 2, 'Kopinya enak banget.', 4, '2023-11-10 08:28:21.220', NULL)
	(12, 5, 4, 'Kopinya enak banget.', 1, '2023-11-10 08:28:21.220', NULL)
	(13, 6, 2, 'Kopinya enak banget.', 5, '2023-11-10 08:28:21.220', NULL)
	(14, 8, 3, 'Kopinya enak banget.', 5, '2023-11-10 08:28:21.220', NULL)
	(15, 4, 5, 'Kopinya enak banget.', 3, '2023-11-10 08:28:21.220', NULL)
	(16, 3, 5, 'Kopinya enak banget.', 4, '2023-11-10 08:28:21.220', NULL)
	(17, 2, 1, 'Kopinya enak banget.', 1, '2023-11-10 08:28:21.220', NULL)
	(18, 9, 4, 'Kopinya enak banget.', 1, '2023-11-10 08:28:21.220', NULL);